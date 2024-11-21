// To parse this JSON data, do
//
//     final fundTransferExcelDownloadResponse = fundTransferExcelDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

BillPaymentExcelDownloadResponse billPaymentExcelDownloadResponseFromJson(String str) => BillPaymentExcelDownloadResponse.fromJson(json.decode(str));

String fundTransferExcelDownloadResponseToJson(BillPaymentExcelDownloadResponse data) => json.encode(data.toJson());

class BillPaymentExcelDownloadResponse extends Serializable{
  String? document;

  BillPaymentExcelDownloadResponse({
    this.document,
  });

  factory BillPaymentExcelDownloadResponse.fromJson(Map<String, dynamic> json) => BillPaymentExcelDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
