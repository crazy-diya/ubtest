// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final viewMailRequest = viewMailRequestFromJson(jsonString);

import 'dart:convert';

ViewMailRequest viewMailRequestFromJson(String str) => ViewMailRequest.fromJson(json.decode(str));

String viewMailRequestToJson(ViewMailRequest data) => json.encode(data.toJson());

class ViewMailRequest {
    final String? epicUserId;
    final int? page;
    final int? size;
    final String? recipientCategoryCode;
    final String? recipientTypeCode;
    final String? subject;
    final DateTime? fromDate;
    final DateTime? toDate;
    final int? hasAttachment;
    final String? readStatus;

  ViewMailRequest({
    this.epicUserId,
    this.page,
    this.size,
    this.recipientCategoryCode,
    this.recipientTypeCode,
    this.subject,
    this.fromDate,
    this.toDate,
    this.hasAttachment,
    this.readStatus,
  });

    factory ViewMailRequest.fromJson(Map<String, dynamic> json) => ViewMailRequest(
        epicUserId: json["epicUserId"],
        page: json["page"],
        size: json["size"],
        recipientCategoryCode: json["recipientCategoryCode"],
        recipientTypeCode: json["recipientTypeCode"],
        fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        hasAttachment: json["hasAttachment"],
        readStatus: json["readStatus"],
        subject:json["subject"]
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "page": page,
        "size": size,
        "recipientCategoryCode": recipientCategoryCode,
        "recipientTypeCode": recipientTypeCode,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "hasAttachment": hasAttachment,
        "readStatus": readStatus,
        "subject":subject
    };

  @override
  String toString() {
    return 'ViewMailRequest(epicUserId: $epicUserId, page: $page, size: $size, recipientCategoryCode: $recipientCategoryCode, recipientTypeCode: $recipientTypeCode, subject: $subject, fromDate: $fromDate, toDate: $toDate, hasAttachment: $hasAttachment, readStatus: $readStatus)';
  }
}
