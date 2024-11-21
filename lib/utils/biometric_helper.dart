
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:union_bank_mobile/utils/app_localizations.dart';
// import 'package:open_document/my_files/init.dart';
import 'package:union_bank_mobile/utils/enums.dart';

class BiometricHelper {
   BiometricHelper(
      {LocalAuthentication? localAuthentication}) {
    auth = localAuthentication;
  }
  LocalAuthentication? auth;

  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<bool> isDeviceSupport() async {
    try {
      return await auth!.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  Future<bool> checkBiometrics() async {
    try {
      return await auth!.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await auth!.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  Future<LoginMethods> getBiometricType() async {
    try {
      List<BiometricType> biometricType = await auth!.getAvailableBiometrics();
      if (biometricType.isNotEmpty) {
        if (Platform.isAndroid) {
          if (biometricType.contains(BiometricType.fingerprint)) {
            return LoginMethods.FINGERPRINT;
          } else if (biometricType.contains(BiometricType.face)) {
            return LoginMethods.FACEID;
          } else if (biometricType.contains(BiometricType.strong)) {
            return LoginMethods.FINGERPRINT;
          } else if (biometricType.contains(BiometricType.weak)) {
            return LoginMethods.FACEID;
          } else {
            return LoginMethods.NONE;
          }
        } else {
          var iosInfo = await DeviceInfoPlugin().iosInfo;
          if (biometricType.contains(BiometricType.fingerprint)) {
            return LoginMethods.FINGERPRINT;
          } else if (biometricType.contains(BiometricType.face)) {
            return LoginMethods.FACEID;
          } else if (double.parse(iosInfo.systemVersion) >= 10) {
            return LoginMethods.FACEID;
          }else if (double.parse(iosInfo.systemVersion)  < 10) {
            return LoginMethods.FINGERPRINT;
          } else {
            return LoginMethods.NONE;
          }
        }
      } else {
        return LoginMethods.NONE;
      }
    } on PlatformException {
      return LoginMethods.NONE;
    }
  }

  // Future<bool> authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     // setState(() {
  //     _isAuthenticating = true;
  //     _authorized = 'Authenticating';
  //     // });
  //     authenticated = await auth!.authenticate(
  //         localizedReason: 'Let OS determine authentication method',);
  //     _isAuthenticating = false;
  //     _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  //     return authenticated;
  //   } on PlatformException catch (e) {
  //     _isAuthenticating = false;
  //     _authorized = 'Error - ${e.message}';
  //     _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  //     return authenticated;
  //   }
  // }

  Future<bool?> authenticateWithBiometrics(BuildContext context) async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = AppLocalizations.of(context).translate("authenticating");

      authenticated = await auth!.authenticate(
          localizedReason: AppLocalizations.of(context).translate("scan_preferred_configured_biometric"),
          options: const AuthenticationOptions(
            useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
          ),
          );

      _isAuthenticating = false;
      _authorized = AppLocalizations.of(context).translate("authenticating");
      _authorized = authenticated ? AppLocalizations.of(context).translate("authorized") : AppLocalizations.of(context).translate("not_authorized");

      return authenticated;
    } on PlatformException catch (e) {
      _isAuthenticating = false;
      _authorized = '${AppLocalizations.of(context).translate("error")} - ${e.message}';
      _authorized = authenticated ? AppLocalizations.of(context).translate("authorized") : AppLocalizations.of(context).translate("not_authorized");
      if(e.code == auth_error.lockedOut){
        return null;
      }else{
        return authenticated;

      }
      
    }
  }

  Future<void> cancelAuthentication() async {
    await auth!.stopAuthentication();
    _isAuthenticating = false;
  }
}
