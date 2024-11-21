import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../data/models/requests/personal_loan_request.dart';
import '../../../../domain/usecases/calculators/calculator_pdf.dart';
import '../../../../domain/usecases/calculators/personal_loan_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'personal_loan_calculator_event.dart';

part 'personal_loan_calculator_state.dart';

class PersonalLoanCalculatorBloc extends BaseBloc<PersonalLoanCalculatorEvent,
    BaseState<PersonalLoanCalculatorState>> {
  final PersonalLoanCalculator? personalLoanCalculator;
  final CalculatorPDF? calculatorPDF;

  PersonalLoanCalculatorBloc({required this.personalLoanCalculator, required this.calculatorPDF})
      : super(PersonalLoanCalculatorInitial()) {
    on<PersonalLoanSaveDataEvent>(_personalLoanSaveData);
    on<PersonalCalculatorPDFDataEvent>(_getCalculatorPDF);
  }

  Future<void> _personalLoanSaveData(PersonalLoanSaveDataEvent event,
      Emitter<BaseState<PersonalLoanCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await personalLoanCalculator!(
      PersonalLoanRequest(
        amount: event.loanAmount,
        installmentType: event.installmentType,
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
        return PersonalLoanFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return PersonalLoanFieldDataSuccessState(
          //personalLoanResponse: r.data,
          monthlyInstallment: r.data?.monthlyInstallment,
          tenure: r.data!.tenure,
          amount: r.data!.amount,
          installmentType: r.data!.installmentType,
          rate: r.data?.rate);
    }));
  }


  Future<void> _getCalculatorPDF(PersonalCalculatorPDFDataEvent event,
      Emitter<BaseState<PersonalLoanCalculatorState>> emit) async {
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
        return PersonalCalculatorPDFFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return PersonalCalculatorPDFSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen
      );
    }));
  }

}
