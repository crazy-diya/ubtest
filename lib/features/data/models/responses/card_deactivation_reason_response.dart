// To parse this JSON data, do
//
//     final cardDeactivationReasonResponse = cardDeactivationReasonResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardDeactivationReasonResponse cardDeactivationReasonResponseFromJson(String str) => CardDeactivationReasonResponse.fromJson(json.decode(str));

String cardDeactivationReasonResponseToJson(CardDeactivationReasonResponse data) => json.encode(data.toJson());

class CardDeactivationReasonResponse extends Serializable{
    final List<CardDeActiveReasonsData>? cardDeActiveReasonsData;

    CardDeactivationReasonResponse({
        this.cardDeActiveReasonsData,
    });

    factory CardDeactivationReasonResponse.fromJson(Map<String, dynamic> json) => CardDeactivationReasonResponse(
        cardDeActiveReasonsData: json["cardDeActiveReasonsDTOList"] == null ? [] : List<CardDeActiveReasonsData>.from(json["cardDeActiveReasonsDTOList"]!.map((x) => CardDeActiveReasonsData.fromJson(x))),
    );

    @override
      Map<String, dynamic> toJson() => {
        "cardDeActiveReasonsDTOList": cardDeActiveReasonsData == null ? [] : List<dynamic>.from(cardDeActiveReasonsData!.map((x) => x.toJson())),
    };
}

class CardDeActiveReasonsData {
    final String? reasonId;
    final String? deActiveReason;

    CardDeActiveReasonsData({
        this.reasonId,
        this.deActiveReason,
    });

    factory CardDeActiveReasonsData.fromJson(Map<String, dynamic> json) => CardDeActiveReasonsData(
        reasonId: json["reasonId"],
        deActiveReason: json["deActiveReason"],
    );

    Map<String, dynamic> toJson() => {
        "reasonId": reasonId,
        "deActiveReason": deActiveReason,
    };
}
