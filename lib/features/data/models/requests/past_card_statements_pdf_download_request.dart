// To parse this JSON data, do
//
//     final pastcardStatementstPdfDownloadRequest = pastcardStatementstPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

PastcardStatementstPdfDownloadRequest pastcardStatementstPdfDownloadRequestFromJson(String str) => PastcardStatementstPdfDownloadRequest.fromJson(json.decode(str));

String pastcardStatementstPdfDownloadRequestToJson(PastcardStatementstPdfDownloadRequest data) => json.encode(data.toJson());

class PastcardStatementstPdfDownloadRequest {
  String messageType;
  int? year;
  int? month;

  PastcardStatementstPdfDownloadRequest({
    required this.messageType,
     this.year,
     this.month,
  });

  factory PastcardStatementstPdfDownloadRequest.fromJson(Map<String, dynamic> json) => PastcardStatementstPdfDownloadRequest(
    messageType: json["messageType"],
    year: json["year"],
    month: json["month"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "year": year,
    "month": month,
  };
}
