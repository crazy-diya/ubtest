
// To parse this JSON data, do
//
//     final composeMailRequest = composeMailRequestFromJson(jsonString);

import 'dart:convert';

ComposeMailRequest composeMailRequestFromJson(String str) => ComposeMailRequest.fromJson(json.decode(str));

String composeMailRequestToJson(ComposeMailRequest data) => json.encode(data.toJson());

class ComposeMailRequest {
    final String? epicUserId;
    final String? subject;
    final String? message;
    final String? replyType;
    final String? recipientTypeCode;
    final bool? isDraft;
    final int? inboxId;
    final int? msgId;
    final List<ComposeMailAttachmentData>? attachmentRequestDtoList;

    ComposeMailRequest({
        this.epicUserId,
        this.subject,
        this.message,
        this.replyType,
        this.recipientTypeCode,
        this.isDraft,
        this.inboxId,
        this.msgId,
        this.attachmentRequestDtoList,
    });

    factory ComposeMailRequest.fromJson(Map<String, dynamic> json) => ComposeMailRequest(
        epicUserId: json["epicUserId"],
        subject: json["subject"],
        message: json["message"],
        replyType: json["replyType"],
        recipientTypeCode: json["recipientTypeCode"],
        isDraft: json["isDraft"],
        inboxId: json["inboxId"],
        msgId: json["msgId"],
        attachmentRequestDtoList: json["attachmentRequestDTOList"] == null ? [] : List<ComposeMailAttachmentData>.from(json["attachmentRequestDTOList"]!.map((x) => ComposeMailAttachmentData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "subject": subject,
        "message": message,
        "replyType": replyType,
        "recipientTypeCode": recipientTypeCode,
        "isDraft": isDraft,
        "inboxId": inboxId,
        "msgId": msgId,
        "attachmentRequestDTOList": attachmentRequestDtoList == null ? [] : List<dynamic>.from(attachmentRequestDtoList!.map((x) => x.toJson())),
    };
}

class ComposeMailAttachmentData {
    final String? attachment;
    final String? attachmentName;
    final String? attachmentType;

    ComposeMailAttachmentData({
        this.attachment,
        this.attachmentName,
        this.attachmentType,
    });

    factory ComposeMailAttachmentData.fromJson(Map<String, dynamic> json) => ComposeMailAttachmentData(
        attachment: json["attachment"],
        attachmentName: json["attachmentName"],
        attachmentType: json["attachmentType"],
    );

    Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "attachmentName": attachmentName,
        "attachmentType": attachmentType,
    };
}

