// To parse this JSON data, do
//
//     final debitCardSaveDataResponse = debitCardSaveDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

DebitCardSaveDataResponse debitCardSaveDataResponseFromJson(String str) => DebitCardSaveDataResponse.fromJson(json.decode(str));

String debitCardSaveDataResponseToJson(DebitCardSaveDataResponse data) => json.encode(data.toJson());

class DebitCardSaveDataResponse extends Serializable {
  String? referenceNo;

  DebitCardSaveDataResponse({
    this.referenceNo,
  });

  factory DebitCardSaveDataResponse.fromJson(Map<String, dynamic> json) => DebitCardSaveDataResponse(
    referenceNo: json["referenceNo"],
  );

  Map<String, dynamic> toJson() => {
    "referenceNo": referenceNo,
  };
}
