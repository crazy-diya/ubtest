import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_bank_mobile/features/data/models/requests/transaction_notification_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/transaction_notification_response.dart';
import 'package:union_bank_mobile/features/domain/usecases/transaction_notification/transaction_notification.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/delete_notification_request.dart';
import '../../../data/models/requests/get_money_notification_request.dart';
import '../../../data/models/requests/mark_as_read_notification_request.dart';
import '../../../data/models/requests/notices_notification_request.dart';
import '../../../data/models/requests/notification_count_request.dart';
import '../../../data/models/requests/promotion_notification_request.dart';
import '../../../data/models/requests/req_money_notification_history_request.dart';
import '../../../data/models/responses/notices_notification_list.dart';
import '../../../data/models/responses/promotion_notification_response.dart';
import '../../../domain/usecases/Notices_notifications/notices_notifications.dart';
import '../../../domain/usecases/notifications/delete_notifications.dart';
import '../../../domain/usecases/notifications/mark_as_read_notifications.dart';
import '../../../domain/usecases/notifications/money_request_notification.dart';
import '../../../domain/usecases/notifications/notification_count.dart';
import '../../../domain/usecases/notifications/req_money_notification_status.dart';
import '../../../domain/usecases/promotion_notification/promotion_notification.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc
    extends BaseBloc<NotificationsEvent, BaseState<NotificationsState>> {
  final TransactionNotification getTranNotification;
  final PromotionNotification getPromoNotification;
  final NoticesNotification getNoticesNotifications;
  final MarkAsReadNotification markAsReadNotification;
  final LocalDataSource localDataSource;
  final DeleteNotifications deleteNotifications;
  final CountNotification countNotification;
  final MoneyRequestNotification moneyRequestNotification;
  final ReqMoneyNotificationStatus reqMoneyNotificationStatus;

  NotificationsBloc({
    required this.getTranNotification,
    required this.getPromoNotification,
    required this.getNoticesNotifications,
    required this.markAsReadNotification,
    required this.localDataSource,
    required this.deleteNotifications,
    required this.countNotification,
    required this.moneyRequestNotification,
    required this.reqMoneyNotificationStatus,
  }) : super(NotificationsInitial()) {
    on<GetNotificationsEvent>(_onGetNotificationsEvent);
    on<GetPromotionEvent>(_onGetPromotionsEvent);
    on<GetNoticesEvent>(_onGetNoticesEvent);
    on<MarkNotificationAsReadEvent>(_markNotificationAsRead);
    on<DeleteNotificationEvent>(_deleteNotificationEvent);
    on<CountNotificationsEvent>(_countNotificationEvent);
    on<MoneyRequestNotificationEvent>(_moneyRequestNotification);
    on<ReqMoneyNotificationStatusEvent>(_reqMoneyNotificationStatus);
  }

  Future<void> _onGetNotificationsEvent(GetNotificationsEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await getTranNotification(TransactionNotificationRequest(
      size: event.size,
      page: event.page,
      readStatus: event.readStatus
    ));

    if (_result.isRight()) {
      emit(_result.fold(
            (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState( error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(  error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return NotificationFailedState( message: ErrorHandler().mapFailureToMessage(l));
          }
        }
            ,(r) =>
            NotificationSuccessState(
              count: r.data?.count,
                notifications: r.data!.userNotificationResponseDtoList),
      ));
    } else {
      emit(NotificationFailedState(
      ));
    }
  }

  Future<void> _onGetPromotionsEvent(GetPromotionEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await getPromoNotification(PromotionNotificationRequest(
      size: event.size,
      page: event.page,
      readStatus: event.readStatus
    ));

    if (_result.isRight()) {
      emit(_result.fold(
        (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return PromotionFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
        (r) => PromotionSuccessState(
              count: r.data?.count,
                notifications: r.data!.userNotificationResponseDtoList),
      ));
    } else {
      emit(PromotionFailedState(
      ));
    }
  }

  Future<void> _onGetNoticesEvent(GetNoticesEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await getNoticesNotifications(NoticesNotificationRequest(
      size: event.size,
      page: event.page,
      epicUserId: event.epicUserId,
      readStatus: event.readStatus
    ));

    if (_result.isRight()) {
      emit(_result.fold(
            (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return PromotionFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
        (r) =>
            NoticesSuccessState(
              count: r.data?.count,
                notifications: r.data!.userNotificationResponseDtoList),
      ));
    } else {
      emit(NoticesFailedState(
      ));
    }
  }

  Future<void> _markNotificationAsRead(MarkNotificationAsReadEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await markAsReadNotification(MarkAsReadNotificationRequest(
      notificationIds: event.notifications,
      epicUserId: localDataSource.getEpicUserId() ?? "",
    ));

    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return MarkAsReadNotificationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return MarkAsReadNotificationSuccessState(message: r.responseDescription);
    }));
  }


  Future<void> _deleteNotificationEvent(DeleteNotificationEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await deleteNotifications(DeleteNotificationRequest(
      size: event.size,
      page: event.page,
      notificationIds: event.notificationIds,
      epicUserId: localDataSource.getEpicUserId() ?? "",
    ));

    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return DeleteNotificationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DeleteNotificationSuccessState(message: r.responseDescription);
    }));
  }



  Future<void> _countNotificationEvent(CountNotificationsEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await countNotification(
        NotificationCountRequest(
      readStatus: event.readStatus,
      notificationType: event.notificationType
    ));

    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return CountNotificationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CountNotificationSuccessState(
          allNotificationCount: r.data!.allNotificationCount,
        tranNotificationCount: r.data!.tranNotificationCount,
        noticesNotificationCount: r.data!.noticesNotificationCount,
        promoNotificationCount: r.data!.promoNotificationCount
      );
    }));
  }

  Future<void> _moneyRequestNotification(MoneyRequestNotificationEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await moneyRequestNotification(
        GetMoneyNotificationRequest(
      messageType: event.messageType,
          requestMoneyId: event.requestMoneyId
    ));

    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return MoneyRequestNotificationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return MoneyRequestNotificationSuccessState(
          id: r.data!.id,
        toAccount: r.data!.toAccount,
        toAccountName: r.data!.toAccountName,
        requestedAmount: r.data!.requestedAmount,
        requestedDate: r.data!.requestedDate,
        toBankCode: r.data!.toBankCode
      );
    }));
  }

  Future<void> _reqMoneyNotificationStatus(ReqMoneyNotificationStatusEvent event,
      Emitter<BaseState<NotificationsState>> emit) async {
    emit(APILoadingState());
    final _result = await reqMoneyNotificationStatus(
        ReqMoneyNotificationHistoryRequest(
      messageType: event.messageType,
      requestMoneyId: event.requestMoneyId,
      status: event.status,
      transactionStatus: event.transactionStatus
    ));

    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return ReqMoneyNotificationStatusFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ReqMoneyNotificationStatusSuccessState(
          id: r.data!.requestMoneyId,
        description: r.data!.description
      );
    }));
  }




}



