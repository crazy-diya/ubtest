import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../data/models/requests/fd_calculator_request.dart';
import '../../../../data/models/requests/get_currency_list_request.dart';
import '../../../../data/models/requests/get_fd_period_req.dart';
import '../../../../data/models/requests/get_fd_rate_request.dart';
import '../../../../data/models/responses/get_currency_list_response.dart';
import '../../../../data/models/responses/get_fd_period_response.dart';
import '../../../../data/models/responses/get_fd_rate_response.dart';
import '../../../../domain/usecases/calculators/calculator_pdf.dart';
import '../../../../domain/usecases/calculators/fd_calculator.dart';
import '../../../../domain/usecases/calculators/get_currency_list.dart';
import '../../../../domain/usecases/calculators/get_fd_period.dart';
import '../../../../domain/usecases/calculators/get_fd_rate.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'fd_calculator_event.dart';

part 'fd_calculator_state.dart';

class FDCalculatorBloc
    extends BaseBloc<FDCalculatorEvent, BaseState<FDCalculatorState>> {
  final FDCalculatorData? fdCalculatorData;
  final CalculatorPDF? calculatorPDF;
  final GetFDRate? getFDRate;
  final GetCurrencyList? getCurrencyList;
  final GetFDPeriod? getFDPeriod;

  FDCalculatorBloc({required this.fdCalculatorData, required this.calculatorPDF , required this.getFDRate ,required this.getCurrencyList, required this.getFDPeriod})
      : super(FDCalculatorInitial()) {
    on<FDCalculatorSaveDataEvent>(_fdCalSaveData);
    on<FDCalculatorPDFDataEvent>(_getCalculatorPDF);
    on<GetFDRateEvent>(_getFDRate);
    on<GetFDCurrencyEvent>(_getCurrencyList);
    on<GetFDPeriodEvent>(_getPeriodEvent);
  }

  Future<void> _fdCalSaveData(FDCalculatorSaveDataEvent event,
      Emitter<BaseState<FDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await fdCalculatorData!(
      FdCalculatorRequest(
        messageType: event.messageType,
        currencyCode: event.currencyCode,
        interestPeriod: event.interestPeriod,
        interestReceived: event.interestReceived,
        amount: event.amount,
        rate: event.rate,
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
       }else {
        return FDCalculatorFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return FDCalculatorFieldDataSuccessState(
        monthlyRate: r.data!.monthlyRate,
        maturityValue: r.data!.maturityValue,
        currency: r.data!.currency,
        currencyCode: r.data!.currencyCode,
        monthlyValue: r.data!.monthlyValue,
        nominalRate: r.data!.nominalRate,
          );
    }));
  }

  Future<void> _getCalculatorPDF(FDCalculatorPDFDataEvent event,
      Emitter<BaseState<FDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await calculatorPDF!(
      CalculatorPdfRequest(
        title: event.title,
        docBody: event.docBody,
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
       }else {
        return FDCalculatorPDFFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return FDCalculatorPDFSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen
      );
    }));
  }

  Future<void> _getFDRate(GetFDRateEvent event,
      Emitter<BaseState<FDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await getFDRate!(
      GetFdRateRequest(
       messageType: event.messageType,
        acceptedDate: event.acceptedDate
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
       }else {
        return GetFDRateFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetFDRateSuccessState(
            fdRatesCbsResponseDtoList: r.data!.fdRatesCbsResponseDtoList
        );
      }else{
        return GetFDRateFailedState(
          message: r.errorDescription
        );
      }

    }));
  }


  Future<void> _getCurrencyList(GetFDCurrencyEvent event,
      Emitter<BaseState<FDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await getCurrencyList!(
        GetCurrencyListRequest(messageType: "getCurrency"));

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
        return GetFDDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetFDDataLoadedState(
        data: r.data!.data
      );
    }));
  }


  Future<void> _getPeriodEvent(GetFDPeriodEvent event,
      Emitter<BaseState<FDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await getFDPeriod!(
        GetFdPeriodRequest(messageType: "getFDCalculator"));

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
        return GetFDPeriodFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetFDPeriodLoadedState(
        data: r.data!.data
      );
    }));
  }




}
