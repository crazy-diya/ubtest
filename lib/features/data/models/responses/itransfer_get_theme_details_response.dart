// To parse this JSON data, do
//
//     final itransferGetThemeDetailsResponse = itransferGetThemeDetailsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ItransferGetThemeDetailsResponse itransferGetThemeDetailsResponseFromJson(String str) => ItransferGetThemeDetailsResponse.fromJson(json.decode(str));

String itransferGetThemeDetailsResponseToJson(ItransferGetThemeDetailsResponse data) => json.encode(data.toJson());

class ItransferGetThemeDetailsResponse extends Serializable {
  ItransferGetThemeDetailsResponse({
    this.bgImageUrl,
    this.themeId,
    this.maxAmountPerDay,
    this.maxITransferPerDay,
    this.maxAmountPerTrans,
    this.minAmountPerTrans,
    this.paymentInstrumentId,
  });

  String? bgImageUrl;
  int? themeId;
  int? maxAmountPerDay;
  int? maxITransferPerDay;
  int? maxAmountPerTrans;
  int? minAmountPerTrans;
  int? paymentInstrumentId;

  factory ItransferGetThemeDetailsResponse.fromJson(Map<String, dynamic> json) => ItransferGetThemeDetailsResponse(
    bgImageUrl: json["bgImageUrl"],
    themeId: json["themeId"],
    maxAmountPerDay: json["maxAmountPerDay"],
    maxITransferPerDay: json["maxITransferPerDay"],
    maxAmountPerTrans: json["maxAmountPerTrans"],
    minAmountPerTrans: json["minAmountPerTrans"],
    paymentInstrumentId: json["paymentInstrumentId"],
  );

  Map<String, dynamic> toJson() => {
    "bgImageUrl": bgImageUrl,
    "themeId": themeId,
    "maxAmountPerDay": maxAmountPerDay,
    "maxITransferPerDay": maxITransferPerDay,
    "maxAmountPerTrans": maxAmountPerTrans,
    "minAmountPerTrans": minAmountPerTrans,
    "paymentInstrumentId": paymentInstrumentId,
  };
}
