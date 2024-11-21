import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:union_bank_mobile/features/data/models/common/justpay_payload.dart';

class PlatformServices {
  static const String ADB_REQ_KEY =
      "ba6c17af";
  static const String ROOT_REQ_KEY =
      "b1e4fead";
  static const String EMU_REQ_KEY =
      "c231def8";
  static const String BIO_REQ_KEY =
      "180c2247";
  static const String ADB_DISABLE_KEY =
      "ceb45240";
  static const String ADB_RES_KEY =
      "c68622628700ae373e914ec0a7c527cb85dea7292e6cf7fffc8239e0f98e9b33";
  static const String ROOT_RES_KEY =
      "18417d51b0f0917e79ee900abfeb4aa59c51bd65b456cf23e3b607cd677eb8c9";
  static const String ENC_PAYLOAD_KEY =
      "e26a77e21ade03e45633f65e2be1e210af45a06981782fe4820023a8e7ce714c";
  static const String JAIL_KEY = 
      "3f67a8a2";

  //new dim
  static const String CHECK_EMU_NEW =
      "8b08d02";

  static const String CHECK_ROOT_NEW =
      "33b2f052";

  //JustPay
  static String JP_DEVICE_ID =
      "2b34675e";
  static String JP_IS_IDENTITY_EXISTS =
      "9a479f83";
  static String JP_REVOKE =
      "78fd1637";
  static String JP_CREATE_IDENTITY =
      "80dcbec1";
  static String JP_SIGN_TERMS =
      "cc658593";
  // LankaQR
  static String LQR_REQ_KEY =
      "D995DA23505A798C93DA3E2E7F2F1611BB3F4DF1110612705F60C17DFD2759FF";
  static String LQR_GEN_REQ_KEY =
      "f6a380f7";
  static String QR_DECODER =
      "2ef6f68d";

  static const String GET_SIGNATURE =
      "842d1d79";
  
   //new dim
  static const String CHECKSUM =
      "e681eecb";
  
   static const String SCREENSHOTDISABLE =
      "917ca3f0";

      
  


  static const platform = MethodChannel('ubgo_method_channel');


  static Future<String> getQRDecoder(String qrScanData) async {
    try {
      final result = await platform.invokeMethod(QR_DECODER, {"qrString": qrScanData});
      return result;
    } on PlatformException catch (e) {
      return "Error: ${e.message}";
    }
  }

  static Future<bool> get getADBStatus async {
    final res = await platform.invokeMethod(ADB_REQ_KEY);
    Map<String, bool> map = _decoder(res.keys.first, res.values.first);
    if (map.keys.first == ADB_RES_KEY) {
      return map.values.first;
    } else {
      return false;
    }
  }


   static Future<bool> get isRealDevice async {
    try {
      final res = await platform.invokeMethod(EMU_REQ_KEY);
      return res;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> get isRooted async {
    final res = await platform.invokeMethod(ROOT_REQ_KEY);
    Map<String, bool> map = _decoder(res.keys.first, res.values.first);
    if (map.keys.first == ROOT_RES_KEY) {
      return map.values.first;
    } else {
      return false;
    }
  }

  static Future<bool> get isJailBroken async {
    try {
      final res = await platform.invokeMethod(JAIL_KEY);
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> get hasBiometricEnrolled async {
    final res = await platform.invokeMethod(BIO_REQ_KEY);
    return res;
  }

  static disableADB() async {
    await platform.invokeMethod(ADB_DISABLE_KEY);
  }

   static Map<String, bool> _decoder(String key, String value) {
    final String decoded = utf8.decode(base64Decode(utf8.decode(base64Decode(key))));
    final resArr = decoded.split(value);
    final Map<String, bool> result = HashMap();
    result.putIfAbsent(resArr.join(""), () => resArr.length.isOdd);
    return result;
  }

  static Future<String> getJustPayDeviceId() async {
    try {
      final String result = await platform.invokeMethod(JP_DEVICE_ID);
      return result;
    } on PlatformException catch (e) {
      return e.message ?? '';
    }
  }

  static Future<bool> isJustPayIdentityExists() async {
    try {
      final bool result = await platform.invokeMethod(JP_IS_IDENTITY_EXISTS);
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> justPayRevoke() async {
    try {
      await platform.invokeMethod(JP_REVOKE);
      return true;
    } on PlatformException {
      return false;
    }
  }

  static Future<JustPayPayload> justPayCreateIdentity(String challenge) async {
    try {
      final String result = await platform
          .invokeMethod(JP_CREATE_IDENTITY, {"challenge": challenge});
      log('$result');
      return JustPayPayload.fromRawJson(result);
    } on PlatformException catch (e) {
      return JustPayPayload(isSuccess: false, data: e.message);
    }
  }

  static Future<JustPayPayload> justPaySignedTerms(String terms) async {
    try {
      final String result =
          await platform.invokeMethod(JP_SIGN_TERMS, {"terms": terms});
      return JustPayPayload.fromRawJson(result);
    } on PlatformException catch (e) {
      return JustPayPayload(isSuccess: false, data: e.message);
    }
  }

  static Future<bool> get isEmu async {
    try {
      final res = await platform.invokeMethod(CHECK_EMU_NEW);
      return res;
    } on PlatformException {
      return true;
    }
  }

  static Future<bool> get isRoot async {
    try {
      final res = await platform.invokeMethod(CHECK_ROOT_NEW);
      return res;
    } on PlatformException {
      return true;
    }
  }

  static Future<String?> getSignature() async {
    try {
      final String? result = await platform.invokeMethod(GET_SIGNATURE);
      return result;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

   static Future<String?> getTamperCheck() async {
    try {
     final String? result = await platform
          .invokeMethod(CHECKSUM);
      log('$result');
       return result;
    } on PlatformException catch (e) {
       return e.message;
    }
  }

   static screenShotDisable() async {
     await platform .invokeMethod(SCREENSHOTDISABLE);
  }

}