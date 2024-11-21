import 'dart:convert';

OtpRequest otpRequestFromJson(String str) =>
    OtpRequest.fromJson(json.decode(str));

String otpRequestToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
  OtpRequest({
    this.messageType,
    this.otpType,
  });

  String? messageType;
  String? otpType;

  factory OtpRequest.fromJson(Map<String, dynamic> json) => OtpRequest(
        messageType: json["messageType"],
        otpType: json["otpType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "otpType": otpType,
      };
}
