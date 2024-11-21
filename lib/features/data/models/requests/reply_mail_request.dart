// To parse this JSON data, do
//
//     final replyMailRequest = replyMailRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

String replyMailRequestToJson(ReplyMailRequest data) => json.encode(data.toJson());

class ReplyMailRequest{
      final String? epicUserId;
    final String? subject;
    final String? message;
    final String? replyType;
    final String? recipientTypeCode;
    final bool? isDraft;
    final int? inboxId;
    final int? msgId;
    final List<ReplyMailAttachmentData>? attachmentRequestDtoList;

    ReplyMailRequest({
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

    factory ReplyMailRequest.fromJson(Map<String, dynamic> json) => ReplyMailRequest(
        epicUserId: json["epicUserId"],
        subject: json["subject"],
        message: json["message"],
        replyType: json["replyType"],
        recipientTypeCode: json["recipientTypeCode"],
        isDraft: json["isDraft"],
        inboxId: json["inboxId"],
        msgId: json["msgId"],
        attachmentRequestDtoList: json["attachmentRequestDTOList"] == null ? [] : List<ReplyMailAttachmentData>.from(json["attachmentRequestDTOList"]!.map((x) => ReplyMailAttachmentData.fromJson(x))),
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

class ReplyMailAttachmentData extends Equatable{
    final String? attachment;
    final String? attachmentName;
    final String? attachmentType;

    const ReplyMailAttachmentData({
        this.attachment,
        this.attachmentName,
        this.attachmentType,
    });

    Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "attachmentName": attachmentName,
        "attachmentType": attachmentType,
    };

     factory ReplyMailAttachmentData.fromJson(Map<String, dynamic> json) => ReplyMailAttachmentData(
        attachment: json["attachment"],
        attachmentName: json["attachmentName"],
        attachmentType: json["attachmentType"],
    );
    
      @override
      List<Object?> get props => [attachment,attachmentName,attachmentType];
}
