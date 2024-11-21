// To parse this JSON data, do
//
//     final mailThreadResponse = mailThreadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

MailThreadResponse mailThreadResponseFromJson(String str) => MailThreadResponse.fromJson(json.decode(str));

String mailThreadResponseToJson(MailThreadResponse data) => json.encode(data.toJson());

class MailThreadResponse extends Serializable{
    final int? totalUnread;
    final InboxResponseData? inboxResponseDto;

    MailThreadResponse({
        this.totalUnread,
        this.inboxResponseDto,
    });

    factory MailThreadResponse.fromJson(Map<String, dynamic> json) => MailThreadResponse(
        totalUnread: json["totalUnread"],
        inboxResponseDto: json["inboxResponseDTO"] == null ? null : InboxResponseData.fromJson(json["inboxResponseDTO"]),
    );

    @override
      Map<String, dynamic> toJson() => {
        "totalUnread": totalUnread,
        "inboxResponseDTO": inboxResponseDto?.toJson(),
    };
}

class InboxResponseData {
    final int? id;
    final String? subject;
    final String? createdBy;
    final String? status;
    final int? inboxReadStatus;
    final String? recipientCategoryCode;
    final String? recipientCategoryName;
    final String? recipientTypeCode;
    final String? recipientTypeName;
    final String? recipientTypeEmail;
    final List<ThreadMessageResponseData>? threadMessageResponseDtos;

    InboxResponseData({
        this.id,
        this.subject,
        this.createdBy,
        this.status,
        this.inboxReadStatus,
        this.recipientCategoryCode,
        this.recipientCategoryName,
        this.recipientTypeCode,
        this.recipientTypeName,
        this.recipientTypeEmail,
        this.threadMessageResponseDtos,
    });

    factory InboxResponseData.fromJson(Map<String, dynamic> json) => InboxResponseData(
        id: json["id"],
        subject: json["subject"],
        createdBy: json["createdBy"],
        status: json["status"],
        inboxReadStatus: json["inboxReadStatus"],
        recipientCategoryCode: json["recipientCategoryCode"],
        recipientCategoryName: json["recipientCategoryName"],
        recipientTypeCode: json["recipientTypeCode"],
        recipientTypeName: json["recipientTypeName"],
        recipientTypeEmail: json["recipientTypeEmail"],
        threadMessageResponseDtos: json["threadMessageResponseDTOS"] == null ? [] : List<ThreadMessageResponseData>.from(json["threadMessageResponseDTOS"]!.map((x) => ThreadMessageResponseData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "createdBy": createdBy,
        "status": status,
        "inboxReadStatus": inboxReadStatus,
        "recipientCategoryCode": recipientCategoryCode,
        "recipientCategoryName": recipientCategoryName,
        "recipientTypeCode": recipientTypeCode,
        "recipientTypeName": recipientTypeName,
        "recipientTypeEmail": recipientTypeEmail,
        "threadMessageResponseDTOS": threadMessageResponseDtos == null ? [] : List<dynamic>.from(threadMessageResponseDtos!.map((x) => x.toJson())),
    };
}

class ThreadMessageResponseData {
    final int? id;
    final int? adminReadStatus;
    final int? customerReadStatus;
    final String? message;
    final String? createdBy;
    final String? status;
    final bool? isCompose;
    final String? replyType;
    final List<Attachment>? attachments;
    final DateTime? createdDate;

    ThreadMessageResponseData({
        this.id,
        this.adminReadStatus,
        this.customerReadStatus,
        this.message,
        this.createdBy,
        this.status,
        this.isCompose,
        this.replyType,
        this.attachments,
        this.createdDate,
    });

    factory ThreadMessageResponseData.fromJson(Map<String, dynamic> json) => ThreadMessageResponseData(
        id: json["id"],
        adminReadStatus: json["adminReadStatus"],
        customerReadStatus: json["customerReadStatus"],
        message: json["message"],
        createdBy: json["createdBy"],
        status: json["status"],
        isCompose: json["isCompose"],
        replyType: json["replyType"],
        attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminReadStatus": adminReadStatus,
        "customerReadStatus": customerReadStatus,
        "message": message,
        "createdBy": createdBy,
        "status": status,
        "isCompose": isCompose,
        "replyType": replyType,
        "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "createdDate": createdDate?.toIso8601String(),
    };
}

class Attachment {
    final int? attachmentId;
    final String? attachmentName;
    final String? attachmentType;

    Attachment({
        this.attachmentId,
        this.attachmentName,
        this.attachmentType,
    });

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        attachmentId: json["attachmentId"],
        attachmentName: json["attachmentName"],
        attachmentType: json["attachmentType"],
    );

    Map<String, dynamic> toJson() => {
        "attachmentId": attachmentId,
        "attachmentName": attachmentName,
        "attachmentType": attachmentType,
    };
}
