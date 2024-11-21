import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/domain/entities/request/request_callback_cancel_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/request_callback_get_request_default_data_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/request_callback_get_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/request_callback_save_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/cancel_request_callback.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/get_request_callback.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/get_request_callback_default_data.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/save_request_callback.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'request_callback_event.dart';
import 'request_callback_state.dart';

class RequestCallBackBloc
    extends BaseBloc<RequestCallBackEvent, BaseState<RequestCallBackState>> {
  final SaveRequestCallBack? saveRequestCallBack;
  final GetRequestCallBack? getRequestCallBack;
  final GetRequestCallBackDefaultData? getRequestCallBackDefaultData;
  final CancelRequestCallBack? cancelRequestCallBack;
  final LocalDataSource? localDataSource;

 RequestCallBackBloc({
    this.saveRequestCallBack,
    this.getRequestCallBack,
    this.getRequestCallBackDefaultData,
    this.cancelRequestCallBack,
    this.localDataSource
  }) : super(InitialRequestCallBackState()) {
    on<RequestCallBackGetEvent>(_onRequestCallBackGetEvent);
    on<RequestCallBackGetDefaultDataEvent>(_onRequestCallBackGetDefaultDataEvent);
    on<RequestCallBackSaveEvent>(_onRequestCallBackSaveEvent);
    on<RequestCallBackCancelEvent>(_onRequestCallBackCancelEvent);
  }

  Future<void> _onRequestCallBackGetEvent(RequestCallBackGetEvent event,
      Emitter<BaseState<RequestCallBackState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource?.getEpicUserId() ??"";
    final result = await getRequestCallBack!(
      RequestCallBackGetRequestEntity(
        epicUserId: epicUserId,
        page: event.page,
        size: event.size,
        fromDate: event.fromDate,
        toDate: event.toDate,
        status: event.status,
        subject: event.subject
      ),
    );
    emit(result.fold((l) {
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
        return RequestCallBackGetFailState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS) {
        return RequestCallBackGetSuccessState(
        requestCallBackGetResponse: r.data!.response,
          count: r.data!.count
      );
      }else{
        return RequestCallBackGetFailState(
          message: r.errorDescription??r.responseDescription,
          responseCode: r.errorCode??r.responseCode
        );
      }
    }));
  }

  Future<void> _onRequestCallBackGetDefaultDataEvent(RequestCallBackGetDefaultDataEvent event,
      Emitter<BaseState<RequestCallBackState>> emit) async {
    emit(APILoadingState());
    final result = await getRequestCallBackDefaultData!(
      RequestCallBackGetDefaultDataRequestEntity(),
    );
    emit(result.fold((l) {
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
        return RequestCallBackGetFailState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS) {
        return RequestCallBackGetDefaultDataSuccessState(
        requestCallBackGetDefaultDataResponse: r.data,
      );
      }else{
        return RequestCallBackGetDefaultDataFailState(
          message: r.errorDescription??r.responseDescription,
          responseCode: r.errorCode??r.responseCode
        );
      }
    }));
  }


    Future<void> _onRequestCallBackSaveEvent(RequestCallBackSaveEvent event,
      Emitter<BaseState<RequestCallBackState>> emit) async {
    emit(APILoadingState());
     final String epicUserId = localDataSource?.getEpicUserId() ??"";
    final result = await saveRequestCallBack!(
      RequestCallBackSaveRequestEntity(
        epicUserId: epicUserId,
        callBackTime: event.callBackTime,
        subject: event.subject,
        language: event.language,
        comment: event.comment
      ),
    );
    emit(result.fold((l) {
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
        return RequestCallBackSaveFailState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS) {
      return RequestCallBackSaveSuccessState( );
      }else{
        return RequestCallBackSaveFailState(
          message: r.errorDescription??r.responseDescription,
          responseCode: r.errorCode??r.responseCode
        );
      }
    }));
  }

   Future<void> _onRequestCallBackCancelEvent(RequestCallBackCancelEvent event,
      Emitter<BaseState<RequestCallBackState>> emit) async {
    emit(APILoadingState());
    final result = await cancelRequestCallBack!(
      RequestCallBackCancelRequestEntity(
        requestCallBackId: event.requestCallBackId
      ),
    );
    emit(result.fold((l) {
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
        return RequestCallBackCancelFailState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS) {
      return RequestCallBackCancelSuccessState(
        message: r.responseDescription??r.errorDescription,
      );
      }else{
        return RequestCallBackCancelFailState(
          message: r.errorDescription??r.responseDescription,
          responseCode: r.errorCode??r.responseCode
        );
      }
    }));
  }


}
