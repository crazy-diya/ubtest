// To parse this JSON data, do
//
//     final marketingBannersRequest = marketingBannersRequestFromJson(jsonString);

import 'dart:convert';

MarketingBannersRequest marketingBannersRequestFromJson(String str) => MarketingBannersRequest.fromJson(json.decode(str));

String marketingBannersRequestToJson(MarketingBannersRequest data) => json.encode(data.toJson());

class MarketingBannersRequest {
  String? messageType;
  String? channelType;

  MarketingBannersRequest({
    this.messageType,
    this.channelType,
  });

  factory MarketingBannersRequest.fromJson(Map<String, dynamic> json) => MarketingBannersRequest(
    messageType: json["messageType"],
     channelType: json["channelType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "channelType":channelType,
  };
}
