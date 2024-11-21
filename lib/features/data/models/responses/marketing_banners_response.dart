// To parse this JSON data, do
//
//     final marketingBannersResponse = marketingBannersResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

MarketingBannersResponse marketingBannersResponseFromJson(String str) => MarketingBannersResponse.fromJson(json.decode(str));

String marketingBannersResponseToJson(MarketingBannersResponse data) => json.encode(data.toJson());

class MarketingBannersResponse extends Serializable{
  final List<Channel>? channel;

  MarketingBannersResponse({
    this.channel,
  });

  factory MarketingBannersResponse.fromJson(Map<String, dynamic> json) => MarketingBannersResponse(
    channel: json["channel"] == null ? [] : List<Channel>.from(json["channel"]!.map((x) => Channel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel == null ? [] : List<dynamic>.from(channel!.map((x) => x.toJson())),
  };
}

class Channel {
  final String? bannerCode;
  final String? description;
  final String? bannerOneUrl;
  final String? bannerTwoUrl;
  final String? bannerThreeUrl;

  Channel({
    this.bannerCode,
    this.description,
    this.bannerOneUrl,
    this.bannerTwoUrl,
    this.bannerThreeUrl,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    bannerCode: json["bannerCode"],
    description: json["description"],
    bannerOneUrl: json["bannerOneUrl"],
    bannerTwoUrl: json["bannerTwoUrl"],
    bannerThreeUrl: json["bannerThreeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "bannerCode": bannerCode,
    "description": description,
    "bannerOneUrl": bannerOneUrl,
    "bannerTwoUrl": bannerTwoUrl,
    "bannerThreeUrl": bannerThreeUrl,
  };
}
