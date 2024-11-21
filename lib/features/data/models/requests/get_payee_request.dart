
import 'dart:convert';

GetPayeeRequest getPayeeRequestFromJson(String str) =>
    GetPayeeRequest.fromJson(json.decode(str));

String getPayeeRequestToJson(GetPayeeRequest data) =>
    json.encode(data.toJson());

class GetPayeeRequest {
  String? messageType;

  GetPayeeRequest({
     this.messageType,
  });

  factory GetPayeeRequest.fromJson(Map<String, dynamic> json)
  => GetPayeeRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
