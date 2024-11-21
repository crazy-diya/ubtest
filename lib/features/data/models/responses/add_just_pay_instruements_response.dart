// To parse this JSON data, do
//
//     final addJustPayInstrumentsResponse = addJustPayInstrumentsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AddJustPayInstrumentsResponse addJustPayInstrumentsResponseFromJson(
        String str) =>
    AddJustPayInstrumentsResponse.fromJson(json.decode(str));

String addJustPayInstrumentsResponseToJson(
        AddJustPayInstrumentsResponse data) =>
    json.encode(data.toJson());

class AddJustPayInstrumentsResponse extends Serializable {
  AddJustPayInstrumentsResponse({
    this.otpTranId,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.otpType,
  });

  String? otpTranId;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;
  String? otpType;

  factory AddJustPayInstrumentsResponse.fromJson(Map<String, dynamic> json) =>
      AddJustPayInstrumentsResponse(
        otpTranId: json["otpTranId"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
        otpType: json["otpType"],
      );

  Map<String, dynamic> toJson() => {
        "otpTranId": otpTranId,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
        "otpType": otpType,
      };
}
