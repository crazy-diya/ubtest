import 'dart:convert';

VerifyNicRequest verifyNicRequestFromJson(String str) =>
    VerifyNicRequest.fromJson(json.decode(str));

String verifyNicRequestToJson(VerifyNicRequest data) =>
    json.encode(data.toJson());

class VerifyNicRequest {
  VerifyNicRequest({
    this.messageType,
    this.nic,
  });

  String? messageType;
  String? nic;

  factory VerifyNicRequest.fromJson(Map<String, dynamic> json) =>
      VerifyNicRequest(
        messageType: json["messageType"],
        nic: json["nic"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "nic": nic,
      };
}
