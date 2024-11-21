import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_bank_mobile/features/data/models/requests/housing_loan_request.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../domain/usecases/calculators/calculator_pdf.dart';
import '../../../../domain/usecases/calculators/housing_loan_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'housing_loan_calculator_event.dart';
part 'housing_loan_calculator_state.dart';

class HousingLoanCalculatorBloc extends BaseBloc<HousingLoanCalculatorEvent,BaseState<HousingLoanCalculatorState>> {
  final HousingLoanCalculatorData? housingLoanCalculator;
  final CalculatorPDF? calculatorPDF;

  HousingLoanCalculatorBloc({required this.housingLoanCalculator,required this.calculatorPDF})
      : super(HousingLoanCalculatorInitial()) {
    on<HousingLoanSaveDataEvent>(_housingLoanSaveData);
    on<HousingLoanPDFDataEvent>(_getCalculatorPDF);
  }

  Future<void> _housingLoanSaveData(HousingLoanSaveDataEvent event,
      Emitter<BaseState<HousingLoanCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await housingLoanCalculator! (
      HousingLoanRequestModel(
        installmentType: event.installmentType,
        amount: event.loanAmount,
        rate: event.interestRate,
        tenure: event.tenure,
        messageType: event.messageType,

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
        return HousingLoanFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return HousingLoanFieldDataSuccessState(
        monthlyInstallment: r.data!.monthlyInstallment,
            amount: r.data!.amount,
        rate: r.data!.rate,
        tenure: r.data!.tenure
        // personalLoanResponse: r.data,
        //   monthlyInstallment: r.data?.monthlyInstallment,
        //   rate: r.data?.rate
      );
    }));
  }


  Future<void> _getCalculatorPDF(HousingLoanPDFDataEvent event,
      Emitter<BaseState<HousingLoanCalculatorState>> emit) async {
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
        return HousingLoanPDFFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return HousingLoanPDFSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen
      );
    }));
  }


}
