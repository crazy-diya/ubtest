// To parse this JSON data, do
//
//     final leaseHistoryPdfResponse = leaseHistoryPdfResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



LeaseHistoryPdfResponse leaseHistoryPdfResponseFromJson(String str) => LeaseHistoryPdfResponse.fromJson(json.decode(str));

String leaseHistoryPdfResponseToJson(LeaseHistoryPdfResponse data) => json.encode(data.toJson());

class LeaseHistoryPdfResponse extends Serializable{
  String? document;

  LeaseHistoryPdfResponse({
    this.document,
  });

  factory LeaseHistoryPdfResponse.fromJson(Map<String, dynamic> json) =>
      LeaseHistoryPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
