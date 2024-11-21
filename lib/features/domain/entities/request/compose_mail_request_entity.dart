import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';

class ComposeMailRequestEntity extends ComposeMailRequest {
  ComposeMailRequestEntity({
    String? epicUserId,
    String? subject,
    String? message,
    String? replyType,
    String? recipientTypeCode,
    bool? isDraft,
    int? inboxId,
    int? msgId,
    List<ComposeMailAttachmentData>? attachmentRequestDtoList,
  }) : super(
            epicUserId: epicUserId,
            subject: subject,
            message: message,
            replyType: replyType,
            recipientTypeCode: recipientTypeCode,
            isDraft: isDraft,
            inboxId: inboxId,
            msgId: msgId,
            attachmentRequestDtoList: attachmentRequestDtoList);
}


