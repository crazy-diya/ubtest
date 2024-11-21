// To parse this JSON data, do
//
//     final getMailAttachmentRequest = getMailAttachmentRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MailAttachmentRequest getMailAttachmentRequestFromJson(String str) => MailAttachmentRequest.fromJson(json.decode(str));

String getMailAttachmentRequestToJson(MailAttachmentRequest data) => json.encode(data.toJson());

class MailAttachmentRequest extends Equatable{
    final int? attachmentId;

    MailAttachmentRequest({
        this.attachmentId,
    });

    factory MailAttachmentRequest.fromJson(Map<String, dynamic> json) => MailAttachmentRequest(
        attachmentId: json["attachmentId"],
    );

    Map<String, dynamic> toJson() => {
        "attachmentId": attachmentId,
    };
    
      @override
      List<Object?> get props => [attachmentId];
}
