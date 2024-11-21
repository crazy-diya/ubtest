// To parse this JSON data, do
//
//     final mobileLoginRequest = mobileLoginRequestFromJson(jsonString);
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';

// ignore: must_be_immutable
class TemporaryLoginRequestEntity extends TemporaryLoginRequest {
  TemporaryLoginRequestEntity({
    String? username,
    String? password,
    String? messageType,
  }) : super(
          username: username,
          password: password,
          messageType: messageType,
        );
}
