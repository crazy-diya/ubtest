// To parse this JSON data, do
//
//     final accTranStatusExcelDownloadResponse = accTranStatusExcelDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccTranStatusExcelDownloadResponse accTranStatusExcelDownloadResponseFromJson(String str) => AccTranStatusExcelDownloadResponse.fromJson(json.decode(str));

String accTranStatusExcelDownloadResponseToJson(AccTranStatusExcelDownloadResponse data) => json.encode(data.toJson());

class AccTranStatusExcelDownloadResponse extends Serializable {
  String? document;

  AccTranStatusExcelDownloadResponse({
    this.document,
  });

  factory AccTranStatusExcelDownloadResponse.fromJson(
          Map<String, dynamic> json) =>
      AccTranStatusExcelDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
