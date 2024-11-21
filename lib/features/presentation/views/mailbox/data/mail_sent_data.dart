
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/attachment_data.dart';

class MailComposeData {
  String? requestType;
  String? status;
  String? subject;
  String? message;
  int? inboxId;
  int? msgId;
  bool? isNewCompose;
  List<AttachmentData>? attachment;
  MailComposeData({
    this.requestType,
    this.status,
    this.subject,
    this.message,
    this.inboxId,
    this.msgId,
    this.isNewCompose,
    this.attachment
  });
}
