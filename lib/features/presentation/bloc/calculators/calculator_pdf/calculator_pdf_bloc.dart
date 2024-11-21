import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../domain/usecases/calculators/calculator_pdf.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';
part 'calculator_pdf_event.dart';
part 'calculator_pdf_state.dart';

class CalculatorPDFBloc
    extends BaseBloc<CalculatorPDFEvent, BaseState<CalculatorPDFState>> {
  final CalculatorPDF? calculatorPDF;

  CalculatorPDFBloc({required this.calculatorPDF})
      : super(CalculatorPDFInitial()) {
    on<CalculatorPDFDataEvent>(_getCalculatorPDF);
  }

  Future<void> _getCalculatorPDF(CalculatorPDFDataEvent event,
      Emitter<BaseState<CalculatorPDFState>> emit) async {
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
        return CalculatorPDFFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CalculatorPDFSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen
      );
    }));
  }
}
