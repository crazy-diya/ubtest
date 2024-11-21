// To parse this JSON data, do
//
//     final getMailAttachmentRequest = getMailAttachmentRequestFromJson(jsonString);


import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
class MailAttachmentRequestEntity extends MailAttachmentRequest{

    MailAttachmentRequestEntity({
        int? attachmentId,
    }):super(attachmentId: attachmentId);

 
}
