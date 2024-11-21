// To parse this JSON data, do
//
//     final biometricLoginRequest = biometricLoginRequestFromJson(jsonString);

import 'package:union_bank_mobile/features/data/models/requests/biometric_login_request.dart';

// ignore: must_be_immutable
class BiometricLoginRequestEntity extends BiometricLoginRequest {
  BiometricLoginRequestEntity({
    String? uniqueCode, 
    String? messageType
    })
      : super(messageType: messageType, uniqueCode: uniqueCode);
}
