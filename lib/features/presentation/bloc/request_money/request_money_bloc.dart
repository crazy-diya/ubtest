import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/error/messages.dart';

import '../../../../error/failures.dart';
import '../../../data/models/requests/request_money_history_request.dart';
import '../../../data/models/requests/request_money_request.dart';
import '../../../data/models/responses/request_money_history_response.dart';
import '../../../domain/usecases/request_money/request_money.dart';
import '../../../domain/usecases/request_money/request_money_history.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'request_money_event.dart';

part 'request_money_state.dart';

class RequestMoneyBloc
    extends BaseBloc<RequestMoneyEvent, BaseState<RequestMoneyState>> {
  final RequestMoney? requestMoney;
  final RequestMoneyHistory? requestMoneyHistory;

  RequestMoneyBloc({this.requestMoney,this.requestMoneyHistory}) : super(RequestMoneyInitial()) {
    on<RequestMoneyRequestEvent>(_onRequestMoneyRequestEventt);
    on<RequestMoneyHistoryRequestEvent>(_onRequestMoneyHistoryRequestEvent);
  }

  Future<void> _onRequestMoneyRequestEventt(RequestMoneyRequestEvent event,
      Emitter<BaseState<RequestMoneyState>> emit) async {
    emit(APILoadingState());
    final _result = await requestMoney!(
      RequestMoneyRequest(
       mobileNumber: event.mobileNumber,
        messageType: event.messageType,
        toAccountNumber: event.toAccountNumber,
      requestedAmount:double.parse(event.amount!) .toStringAsFixed(2),
        remarks: event.remarks,
      )
    );
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
        return RequestMoneyFailState(
            message: ErrorHandler().mapFailureToMessage(l),
            responseCode: (l as ServerFailure).errorResponse.errorCode??''
        );
      }

    }, (r) {
      if(r.responseCode == APIResponse.SUCCESS||r.responseCode=="837"){
        return RequestMoneySuccessState(
          responseDescription: r.responseDescription,
          responseCode: r.responseCode,
        );
      } else {
        return RequestMoneyFailState(
            message:r.errorDescription??r.responseDescription,
            responseCode: r.errorCode??r.responseCode
        );
      }

    }));
  }

  Future<void> _onRequestMoneyHistoryRequestEvent(RequestMoneyHistoryRequestEvent event,
      Emitter<BaseState<RequestMoneyState>> emit) async {
    emit(APILoadingState());
    final _result = await requestMoneyHistory!(
        RequestMoneyHistoryRequest(
        messageType: event.messageType,
      )
    );
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
        return RequestMoneyHistoryFailState(
            message: ErrorHandler().mapFailureToMessage(l),
            responseCode: (l as ServerFailure).errorResponse.errorCode??''
        );
      }

    }, (r) {
      if(r.responseCode == APIResponse.SUCCESS||r.responseCode=="837"||r.responseCode=="841"){
        return RequestMoneyHistorySuccessState(
          list: r.data!.list!
        );
      } else {
        return RequestMoneyHistoryFailState(
            message:r.errorDescription??r.responseDescription,
            responseCode: r.errorCode??r.responseCode
        );
      }

    }));
  }








}



