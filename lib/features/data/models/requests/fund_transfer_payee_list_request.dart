
import 'dart:convert';

FundTransferPayeeListRequest payeeListRequestFromJson(String str) => FundTransferPayeeListRequest.fromJson(json.decode(str));

String payeeListRequestToJson(FundTransferPayeeListRequest data) => json.encode(data.toJson());

class FundTransferPayeeListRequest {
  FundTransferPayeeListRequest({
    this.messageType,
    // this.epicUserId,
  });

  String? messageType;
  // String epicUserId;

  factory FundTransferPayeeListRequest.fromJson(Map<String, dynamic> json) => FundTransferPayeeListRequest(
    messageType: json["messageType"],
    // epicUserId: json["epicUserId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    // "epicUserId": epicUserId,
  };
}
