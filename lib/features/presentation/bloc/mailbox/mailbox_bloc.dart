// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/reply_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/compose_mail_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/delete_mail_message_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/delete_mail_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/mail_attachment_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/mail_thread_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/mark_as_read_mail_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/recipient_category_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/recipient_type_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/reply_mail_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/view_mail_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_category.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_types.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/compose_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail_attachment.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail_message.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_mail_attachment.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_mail_thread.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_view_mails.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/mark_as_read_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/reply_mail.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import 'mailbox_event.dart';
import 'mailbox_state.dart';

class MailBoxBloc extends BaseBloc<MailBoxEvent, BaseState<MailBoxState>> {
  final ComposeMail composeMail;
  final DeleteMail  deleteMail;
  final DeleteMailMessage  deleteMailMessage;
  final ReplyMail replyMail;
  final MarkAsReadMail markAsReadMail;
  final GetViewMails getViewMails;
  final GetMailThread getMailThread;
  final GetMailAttcahment getMailAttcahment;
  final DeleteMailAttcahment deleteMailAttcahment;
  final LocalDataSource localDataSource;
  final GetRecipientTypes? getRecipientTypes;
  final GetRecipientCategory? getRecipientCategory;

  MailBoxBloc({
    required this.composeMail,
    required this.deleteMail,
    required this.deleteMailMessage,
    required this.replyMail,
    required this.markAsReadMail,
    required this.getViewMails,
    required this.getMailThread,
    required this.localDataSource,
    required this.getMailAttcahment,
    required this.deleteMailAttcahment,
    required this.getRecipientTypes,
    required this.getRecipientCategory,
  }) : super(MailboxInitial()) {
    on<ComposeMailEvent> (_onComposeMailEvent);
    on<GetViewMailEvent> (_onGetViewMailEvent);
    on<GetMailThreadEvent> (_onGetMailThreadEvent);
    on<GetMailAttachmentEvent> (_onGetMailAttachmentEvent);
    on<DeleteMailEvent> (_onDeleteMailEvent);
    on<DeleteMailMessageEvent> (_onDeleteMailMessageEvent);
    on<MarkAsReadMailEvent> (_onMarkAsReadMailEvent);
    on<ReplyMailEvent> (_onReplyMailEvent);
    on<DeleteMailAttachmentEvent>(_onDeleteMailAttachmentEvent);
    on<MailboxRecipientCategoryEvent>(_onGetRecipientCategoryDropDownEvent);
    on<MailboxRecipientTypesEvent>(_onGetRecipientTypeDropDownEvent);
    
  }

   Future<void> _onComposeMailEvent(ComposeMailEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    List<ComposeMailAttachmentData>? files = event.attachment != null
        ? event.attachment!
            .map((e) => ComposeMailAttachmentData(
                attachment: e.base64File,
                attachmentName: e.fileName,
                attachmentType: e.extension))
            .toList()
        : null;
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await composeMail(ComposeMailRequestEntity(
        epicUserId: epicUserId,
        subject: event.subject,
        message: event.message,
        isDraft: event.isDraft,
        replyType:event.replyType,
        msgId: event.msgId,
        inboxId: event.inboxId,
        recipientTypeCode: event.recipientTypeCode,
        attachmentRequestDtoList: files));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ComposeMailFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS||r.responseCode=="11"){
         return ComposeMailSuccessState(message: r.responseDescription);
      }else{
       return ComposeMailFailedState(
            message:r.errorDescription??r.responseDescription);
      }
     
    }));
  }



  Future<void> _onGetViewMailEvent(
      GetViewMailEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await getViewMails(ViewMailRequestEntity(
        epicUserId: epicUserId,
          page: event.page,
          size: event.size,
          recipientCategoryCode:event.recipientCategoryCode,
          recipientTypeCode:event.recipientTypeCode,
          fromDate:event.fromDate,
          toDate:event.toDate,
          hasAttachment:event.hasAttachment,
          readStatus:event.readStatus,
          subject: event.subject
        ));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetViewMailFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
       AppConstants.unreadMailCount.add(r.data?.totalUnread??0);
      return GetViewMailLoadedState(viewMails: r.data);
    }));
  }

  Future<void> _onGetMailThreadEvent(
      GetMailThreadEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await getMailThread(MailThreadRequestEntity(
        epicUserId: epicUserId,
        inboxId: event.inboxId,
        isComposeDraft: event.isComposeDraft
        ));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetMailThreadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetMailThreadLoadedState(mailThread: r.data);
    }));
  }

   Future<void> _onGetMailAttachmentEvent(
      GetMailAttachmentEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final result = await getMailAttcahment(MailAttachmentRequestEntity(attachmentId: event.attachmentId));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetMailAttachmentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetMailAttachmentLoadedState(mailAttachmentResponse: r.data);
    }));
  }

  Future<void> _onDeleteMailAttachmentEvent(
      DeleteMailAttachmentEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final result = await deleteMailAttcahment(MailAttachmentRequestEntity(attachmentId: event.attachmentId));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return DeleteMailAttachmentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DeleteMailAttachmentSuccessState(message: r.responseDescription);
    }));
  }

  Future<void> _onDeleteMailMessageEvent(
      DeleteMailMessageEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await deleteMailMessage(DeleteMailMessageRequestEntity(epicUserId: epicUserId,inboxMessageIdList: event.inboxMessageIdList));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return DeleteMailMessageFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DeleteMailMessageSuccessState(message: r.responseDescription);
    }));
  }

   Future<void> _onDeleteMailEvent(
      DeleteMailEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await deleteMail(DeleteMailRequestEntity(epicUserId: epicUserId,inboxIdList: event.inboxIdList));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return DeleteMailFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DeleteMailSuccessState(message: r.responseDescription);
    }));
  }

   Future<void> _onMarkAsReadMailEvent(
      MarkAsReadMailEvent event, Emitter<BaseState<MailBoxState>> emit) async {
   if(event.isSilent == false ) emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await markAsReadMail(MarkAsReadMailRequestEntity(epicUserId: epicUserId,inboxIdList: event.inboxIdList));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return MarkAsReadMailFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return MarkAsReadMailSuccessState(message: r.responseDescription);
    }));
  }

  Future<void> _onReplyMailEvent(ReplyMailEvent event, Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    List<ReplyMailAttachmentData>? files = event.attachment != null
        ? event.attachment!
            .map((e) => ReplyMailAttachmentData(
                attachment: e.base64File,
                attachmentName: e.fileName,
                attachmentType: e.extension))
            .toList()
        : null;
    final String epicUserId = localDataSource.getEpicUserId() ??"";
    final result = await replyMail(ReplyMailRequestEntity(
        epicUserId: epicUserId,
        subject: event.subject,
        message: event.message,
        isDraft: event.isDraft,
        replyType:event.replyType,
        msgId: event.msgId,
        inboxId: event.inboxId,
        recipientTypeCode: event.recipientTypeCode,
        attachmentRequestDtoList: files));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ReplyMailFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ReplyMailSuccessState(message: r.responseDescription);
    }));
  }

  
  Future<void> _onGetRecipientCategoryDropDownEvent(MailboxRecipientCategoryEvent event,
      Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ?? "";
    final result = await getRecipientCategory!(
        RecipientCategoryRequestEntity(epicUserId: epicUserId));

    emit(result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return RecipientCategoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return RecipientCategorySuccessState(
          data: r.data?.responseRecipientCategories
              ?.map(
                (e) => CommonDropDownResponse(
                  description: e.categoryName,
                  code: e.categoryCode
                ),
              )
              .toList());
    }));
  }

  Future<void> _onGetRecipientTypeDropDownEvent(MailboxRecipientTypesEvent event,
      Emitter<BaseState<MailBoxState>> emit) async {
    emit(APILoadingState());
    final result = await getRecipientTypes!(
        RecipientTypeRequestEntity(recipientCode: event.recipientCode));

    emit(result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return RecipientTypeFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return RecipientTypeSuccessState(
          data: r.data?.responseRecipientTypeList
              ?.map(
                (e) => CommonDropDownResponse(
                  description: e.typeName,
                  code: e.typeCode,
                  key: e.email
                ),
              )
              .toList());
    }));
  }
}
