// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/curves/prime256v1.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class Encrypt {
  String? _CLIENT_PUB_KEY;

  set _SET_CLIENT_PUB_KEY(String value) {
    _CLIENT_PUB_KEY = value;
  }

  ECPrivateKey? _CLIENT_PRIV_KEY;

  set _SET_CLIENT_PRIV_KEY(ECPrivateKey value) {
    _CLIENT_PRIV_KEY = value;
  }

  Uint8List? _SHARED_SECRET_KEY;

  set _SET_SHARED_SECRET_KEY(Uint8List value) {
    _SHARED_SECRET_KEY = value;
  }

  String getClientPublicKey() {
    try {
      //Derive EC Key Pairs
      final keyPair = _generateKeys();
      ECPrivateKey clientPrivateKey = keyPair.privateKey as ECPrivateKey;

      ECPublicKey clientPublicKey = keyPair.publicKey as ECPublicKey;

      //Client Public Key To Pem
      final clientPublicKeyToPem =
          CryptoUtils.encodeEcPublicKeyToPem(clientPublicKey);

      //Client Cleaned Pem Key
      String clientCleanedPemKey = clientPublicKeyToPem
          .replaceAll('-----BEGIN PUBLIC KEY-----\n', '')
          .replaceAll('\n-----END PUBLIC KEY-----', '')
          .replaceAll(' ', '') // This will remove all spaces
          .replaceAll('\n', ''); // This will remove all newline characters

      _SET_CLIENT_PUB_KEY = clientCleanedPemKey;
      _SET_CLIENT_PRIV_KEY = clientPrivateKey;
      return clientCleanedPemKey;
    } catch (e) {
      rethrow;
    }
  }

  void setPublicKey({required String ecServerPublicKey}) {
    try {
      ECPublicKey serverPublicKey = _deriveServerKey(ecServerPublicKey);
      Uint8List sharedSecretKey = _generateSharedSecret(serverPublicKey);
      _SET_SHARED_SECRET_KEY = sharedSecretKey;
      // _SERVER_PUB_KEY = serverPublicKey;
    } catch (e) {
      rethrow;
    }
  }

  String encryptData({required String encryptData}) {
    try {
      Uint8List ivSalt = _generateIVSalt();

      Uint8List aesKeyE = _aesKeyDerive(ivSalt);

      Uint8List encryptDataBytes = Uint8List.fromList(utf8.encode(encryptData));

      BlockCipher paddedBlockEncryptionCipher =
          PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
      paddedBlockEncryptionCipher.init(
          true,
          PaddedBlockCipherParameters(
              ParametersWithIV<KeyParameter>(KeyParameter(aesKeyE), ivSalt),
              null));
      Uint8List cipherText =
          paddedBlockEncryptionCipher.process(encryptDataBytes);
      String encryptionResult = cipherText.encryptionDecode();

      //Combine Salt Length And Data

      final combineEncryptedBytes =
          _combineSaltLengthAndData(ivSalt, cipherText);
      final encryptedDataBase64 = combineEncryptedBytes.toBase64();

      return encryptedDataBase64;
    } catch (e) {
      rethrow;
    }
  }

  String decryptData({required String decryptingData}) {
    try {
      final decodeDecryptingData =
          Uint8List.fromList(base64.decode(decryptingData));

      // Check Encrypted Bytes Length
      if (decodeDecryptingData.length < 17) {
        log("Decrypt Data lenth is <17");
      }

      // Extract the salt length
      int saltLength = decodeDecryptingData[0];
      if (saltLength <= 0 || saltLength > 16) {
        log("Decrypt Data lenth is saltLength <= 0 || saltLength > 16");
      }

      // Extract the salt
      Uint8List ivSaltExtract = Uint8List(saltLength);
      ivSaltExtract.setRange(
          0, saltLength, decodeDecryptingData.sublist(1, saltLength + 1));

      // Extract data
      Uint8List remainingData = decodeDecryptingData.sublist(1 + saltLength);

      Uint8List aesKeyD = _aesKeyDerive(ivSaltExtract);

      BlockCipher paddedBlockDecryptionCipher =
          PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
      paddedBlockDecryptionCipher.init(
          false,
          PaddedBlockCipherParameters(
              ParametersWithIV<KeyParameter>(
                  KeyParameter(aesKeyD), ivSaltExtract),
              null));
      Uint8List decryptedText =
          paddedBlockDecryptionCipher.process(remainingData);
      String decryptionResult = decryptedText.encryptionDecode();
      return decryptionResult;
    } catch (e) {
      rethrow;
    }
  }

  //CONCRETE

  AsymmetricKeyPair<PublicKey, PrivateKey> _generateKeys() {
    var keyParams = ECKeyGeneratorParameters(ECCurve_prime256v1());

    FortunaRandom secureRandom = FortunaRandom();
    math.Random random = math.Random.secure();
    Uint8List seeds =
        Uint8List.fromList(List.generate(32, (index) => random.nextInt(256)));

    secureRandom.seed(KeyParameter(seeds));

    ECKeyGenerator generator = ECKeyGenerator();
    generator.init(ParametersWithRandom(keyParams, secureRandom));

    var pair = generator.generateKeyPair();
    return pair;
  }

  Uint8List _generateIVSalt() {
    final random = math.Random.secure();
    Uint8List ivSalt = Uint8List(16);
    ivSalt =
        Uint8List.fromList(List.generate(16, (index) => random.nextInt(256)));
    return ivSalt;
  }

  Uint8List _generateSharedSecret(ECPublicKey serverPublicKey) {
    //Generate Shared Secret
    final ECDHBasicAgreement ecBasicAgreement = ECDHBasicAgreement();
    ecBasicAgreement.init(_CLIENT_PRIV_KEY!);
    final calculateAgreement =
        ecBasicAgreement.calculateAgreement(serverPublicKey);

    String hex = calculateAgreement.toRadixString(16);

    final sharedSecretKey = HexUtils.decode(hex);
    return sharedSecretKey;
  }

  ECPublicKey _deriveServerKey(String serverKey) {
    List<String> serverPemKey = [];
    for (int i = 0; i < serverKey.length; i += 64) {
      int endIndex = (i + 64 < serverKey.length) ? i + 64 : serverKey.length;
      serverPemKey.add(serverKey.substring(i, endIndex));
    }
    String serverPem =
        '-----BEGIN PUBLIC KEY-----\n${serverPemKey.join('\n')}\n-----END PUBLIC KEY-----';

    //Server Public Key Derive
    ECPublicKey serverPublicKey = CryptoUtils.ecPublicKeyFromPem(serverPem);
    return serverPublicKey;
  }

  Uint8List _aesKeyDerive(
    Uint8List ivSalt,
  ) {
    String base64String = base64Encode(_SHARED_SECRET_KEY!);
    List<int> utf8Bytes = utf8.encode(base64String);
    final pbkdf2Params = Pbkdf2Parameters(ivSalt, 1500, 32);
    final pbkdf2KeyDerivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    pbkdf2KeyDerivator.init(pbkdf2Params);
    final pbkdfKey = pbkdf2KeyDerivator.process(Uint8List.fromList(utf8Bytes));

    return pbkdfKey;
  }

  Uint8List _combineSaltLengthAndData(
      Uint8List ivBytes, Uint8List encryptedData) {
    int totalLength = ivBytes.length + encryptedData.length + 1;
    Uint8List saltLengthAndData = Uint8List(totalLength);

    saltLengthAndData[0] = ivBytes.length;
    saltLengthAndData.setRange(1, ivBytes.length + 1, ivBytes);
    saltLengthAndData.setRange(ivBytes.length + 1, totalLength, encryptedData);

    return saltLengthAndData;
  }
}

extension Uint8ListEncoder on Uint8List {
  String toBase64() {
    return base64.encode(this);
  }

  String encryptionDecode() {
    return String.fromCharCodes(this);
  }
}

extension StringDecoder on String {
  Uint8List fromBase64() {
    return base64.decode(this);
  }
}
