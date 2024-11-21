// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/attachment_data.dart';

abstract class MailBoxEvent extends BaseEvent {}

class ComposeMailEvent extends MailBoxEvent {
  final String? subject;
  final String? message;
  final String? replyType;
  final String? recipientTypeCode;
  final bool? isDraft;
  final int? inboxId;
  final int? msgId;
  final List<AttachmentData>? attachment;

  ComposeMailEvent(
      {required this.subject,
      required this.recipientTypeCode,
      required this.isDraft,
      required this.message,
      this.attachment,
      this.inboxId,
      this.msgId,
      this.replyType,});
}
class GetViewMailEvent extends MailBoxEvent {
  final int? page;
    final int? size;
    final String? recipientCategoryCode;
    final String? recipientTypeCode;
    final DateTime? fromDate;
    final DateTime? toDate;
    final int? hasAttachment;
    final String? readStatus;
    final String? subject;

  GetViewMailEvent({
    this.page,
    this.size,
    this.recipientCategoryCode,
    this.recipientTypeCode,
    this.fromDate,
    this.toDate,
    this.hasAttachment,
    this.readStatus,
    this.subject,
  });
 
}

class GetMailThreadEvent extends MailBoxEvent {
  final int? inboxId;
  final bool? isComposeDraft;

  GetMailThreadEvent({
    this.inboxId,
    this.isComposeDraft,
  });
 
}

class GetMailAttachmentEvent extends MailBoxEvent {
  final int? attachmentId;

  GetMailAttachmentEvent({
    this.attachmentId
  });
 
}

class DeleteMailAttachmentEvent extends MailBoxEvent {
  final int? attachmentId;

  DeleteMailAttachmentEvent({
    this.attachmentId
  });
 
}
class DeleteMailEvent extends MailBoxEvent {
  final List<int>? inboxIdList;
  DeleteMailEvent({
    this.inboxIdList,
  });
 }

 class DeleteMailMessageEvent extends MailBoxEvent {
  final List<int>? inboxMessageIdList;
  DeleteMailMessageEvent({
    this.inboxMessageIdList,
  });
 }

 class MarkAsReadMailEvent extends MailBoxEvent {
  final List<int>? inboxIdList;
  final bool? isSilent;
  MarkAsReadMailEvent( {
    this.inboxIdList,
    this.isSilent = false,
  });
 }

class ReplyMailEvent extends MailBoxEvent {
  final String? subject;
  final String? message;
  final String? replyType;
  final String? recipientTypeCode;
  final bool? isDraft;
  final int? inboxId;
  final int? msgId;
  final List<AttachmentData>? attachment;
  ReplyMailEvent(
      {required this.subject,
      required this.recipientTypeCode,
      required this.isDraft,
      required this.message,
      this.attachment,
      this.inboxId,
      this.msgId,
      this.replyType,});
}

class MailboxRecipientTypesEvent extends MailBoxEvent {
  String? recipientCode;
  MailboxRecipientTypesEvent({this.recipientCode});
}

class MailboxRecipientCategoryEvent extends MailBoxEvent {
}
