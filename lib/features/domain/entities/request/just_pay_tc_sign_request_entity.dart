// To parse this JSON data, do
//
//     final justpayTCSignRequest = justpayTcSignRequestFromMap(jsonString);

import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';

class JustpayTCSignRequestEntity extends JustpayTCSignRequest {
  JustpayTCSignRequestEntity({
    String? messageType,
    String? challengeId,
    String? termAndCondition,
  }) : super(
            challengeId: challengeId,
            termAndCondition: termAndCondition,
            messageType: messageType);
}
