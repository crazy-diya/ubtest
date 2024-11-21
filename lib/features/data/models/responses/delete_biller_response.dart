// To parse this JSON data, do
//
//     final deleteBillerResponse = deleteBillerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

DeleteBillerResponse deleteBillerResponseFromJson(String str) => DeleteBillerResponse.fromJson(json.decode(str));

String deleteBillerResponseToJson(DeleteBillerResponse data) => json.encode(data.toJson());

class DeleteBillerResponse extends Serializable{
  final List<int>? successFieldIds;
  final List<dynamic>? notFoundFieldIds;

  DeleteBillerResponse({
    this.successFieldIds,
    this.notFoundFieldIds,
  });

  factory DeleteBillerResponse.fromJson(Map<String, dynamic> json) => DeleteBillerResponse(
    successFieldIds: json["successFieldIds"] == null ? [] : List<int>.from(json["successFieldIds"]!.map((x) => x)),
    notFoundFieldIds: json["notFoundFieldIds"] == null ? [] : List<dynamic>.from(json["notFoundFieldIds"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "successFieldIds": successFieldIds == null ? [] : List<dynamic>.from(successFieldIds!.map((x) => x)),
    "notFoundFieldIds": notFoundFieldIds == null ? [] : List<dynamic>.from(notFoundFieldIds!.map((x) => x)),
  };
}
