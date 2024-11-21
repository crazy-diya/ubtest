
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

abstract class MailBoxState extends BaseState<MailBoxState> {}

class MailboxInitial extends MailBoxState {}

class ComposeMailSuccessState extends MailBoxState {
  final String? message;

  ComposeMailSuccessState({this.message});
}

class ComposeMailFailedState extends MailBoxState {
  final String? message;
  ComposeMailFailedState({this.message});
}
class GetViewMailLoadedState extends MailBoxState {
  final ViewMailResponse? viewMails;
  GetViewMailLoadedState({this.viewMails});
}

class GetMailThreadFailedState extends MailBoxState {
  final String? message;
  GetMailThreadFailedState({this.message});
}

class GetMailThreadLoadedState extends MailBoxState {
  final MailThreadResponse? mailThread;
  GetMailThreadLoadedState({this.mailThread});
}

class GetMailAttachmentFailedState extends MailBoxState {
  final String? message;
  GetMailAttachmentFailedState({this.message});
}

class GetMailAttachmentLoadedState extends MailBoxState {
  final MailAttachmentResponse? mailAttachmentResponse;
  GetMailAttachmentLoadedState({this.mailAttachmentResponse});
}

class DeleteMailAttachmentFailedState extends MailBoxState {
  final String? message;
  DeleteMailAttachmentFailedState({this.message});
}

class DeleteMailAttachmentSuccessState extends MailBoxState {
  final String? message;
  DeleteMailAttachmentSuccessState({this.message});
}

class GetViewMailFailedState extends MailBoxState {
  final String? message;
  GetViewMailFailedState({this.message});
}

class DeleteMailSuccessState extends MailBoxState {
  final String? message;

  DeleteMailSuccessState({this.message});
}

class DeleteMailFailedState extends MailBoxState {
  final String? message;
  DeleteMailFailedState({this.message});
}

class DeleteMailMessageSuccessState extends MailBoxState {
  final String? message;

  DeleteMailMessageSuccessState({this.message});
}

class DeleteMailMessageFailedState extends MailBoxState {
  final String? message;
  DeleteMailMessageFailedState({this.message});
}

class MarkAsReadMailSuccessState extends MailBoxState {
   final String? message;

  MarkAsReadMailSuccessState({this.message});
}

class MarkAsReadMailFailedState extends MailBoxState {
  final String? message;
  MarkAsReadMailFailedState({this.message});
}

class ReplyMailSuccessState extends MailBoxState {
  final String? message;

  ReplyMailSuccessState({this.message});
}

class ReplyMailFailedState extends MailBoxState {
  final String? message;
  ReplyMailFailedState({this.message});
}

class RecipientCategorySuccessState<T> extends MailBoxState {
  final T data;
  RecipientCategorySuccessState({required this.data});
}

class RecipientCategoryFailedState extends MailBoxState {
  final String? message;
  RecipientCategoryFailedState({this.message});
}

class RecipientTypeSuccessState<T> extends MailBoxState {
  final T data;
  RecipientTypeSuccessState({required this.data});
}

class RecipientTypeFailedState extends MailBoxState {
  final String? message;
  RecipientTypeFailedState({this.message});
}

