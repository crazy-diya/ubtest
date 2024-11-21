// To parse this JSON data, do
//
//     final challengeResponse = challengeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ChallengeResponse challengeResponseFromJson(String str) => ChallengeResponse.fromJson(json.decode(str));

String challengeResponseToJson(ChallengeResponse data) => json.encode(data.toJson());

class ChallengeResponse extends Serializable{
  final String? id;

  ChallengeResponse({
    this.id,
  });

  factory ChallengeResponse.fromJson(Map<String, dynamic> json) => ChallengeResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
