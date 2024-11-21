// To parse this JSON data, do
//
//     final mailAttachmentResponse = mailAttachmentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

MailAttachmentResponse mailAttachmentResponseFromJson(String str) => MailAttachmentResponse.fromJson(json.decode(str));

String mailAttachmentResponseToJson(MailAttachmentResponse data) => json.encode(data.toJson());

class MailAttachmentResponse extends Serializable{
    final String? attachment;
    final int? attachmentId;
    final String? attachmentName;
    final String? attachmentType;

    MailAttachmentResponse({
        this.attachment,
        this.attachmentId,
        this.attachmentName,
        this.attachmentType,
    });

    factory MailAttachmentResponse.fromJson(Map<String, dynamic> json) => MailAttachmentResponse(
        attachment: json["attachment"],
        attachmentId: json["attachmentId"],
        attachmentName: json["attachmentName"],
        attachmentType: json["attachmentType"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "attachmentId": attachmentId,
        "attachmentName": attachmentName,
        "attachmentType": attachmentType,
    };
}
