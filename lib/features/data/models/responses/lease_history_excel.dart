// To parse this JSON data, do
//
//     final leaseHistoryExcelResponse = leaseHistoryExcelResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



LeaseHistoryExcelResponse leaseHistoryExcelResponseFromJson(String str) => LeaseHistoryExcelResponse.fromJson(json.decode(str));

String leaseHistoryExcelResponseToJson(LeaseHistoryExcelResponse data) => json.encode(data.toJson());

class LeaseHistoryExcelResponse extends Serializable{
  String? document;

  LeaseHistoryExcelResponse({
    this.document,
  });

  factory LeaseHistoryExcelResponse.fromJson(Map<String, dynamic> json) =>
      LeaseHistoryExcelResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
