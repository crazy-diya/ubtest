import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../data/models/requests/leasing_calculator_request.dart';
import '../../../../domain/usecases/calculators/calculator_pdf.dart';
import '../../../../domain/usecases/calculators/leasing_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'leasing_calculator_event.dart';

part 'leasing_calculator_state.dart';

class LeasingCalculatorBloc extends BaseBloc<LeasingCalculatorEvent,
    BaseState<LeasingCalculatorState>> {
  final LeasingCalculatorData? leasingCalculatorData;
  final CalculatorPDF? calculatorPDF;

  LeasingCalculatorBloc({required this.leasingCalculatorData , required this.calculatorPDF})
      : super(LeasingCalculatorInitial()) {
    on<LeasingSaveDataEvent>(_leasingSaveData);
    on<LeasingPDFDataEvent>(_getCalculatorPDF);
  }

  Future<void> _leasingSaveData(LeasingSaveDataEvent event,
      Emitter<BaseState<LeasingCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await leasingCalculatorData!(
      LeasingCalculatorRequest(
        messageType: event.messageType,
        vehicleCategory: event.vehicleCategory,
        vehicleType: event.vehicleType,
        manufactYear: event.manufactYear,
        price: event.price,
        advancedPayment: event.advancedPayment,
        amount: event.amount,
        tenure: event.tenure,
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
        return LeasingFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeasingFieldDataSuccessState(
          monthlyInstallment: r.data!.monthlyInstallment,
          rate: r.data!.rate,
          // personalLoanResponse: r.data,
          //   monthlyInstallment: r.data?.monthlyInstallment,
          //   rate: r.data?.rate
          );
    }));
  }

  Future<void> _getCalculatorPDF(LeasingPDFDataEvent event,
      Emitter<BaseState<LeasingCalculatorState>> emit) async {
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
        return LeasingPDFFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeasingPDFSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen
      );
    }));
  }


}
