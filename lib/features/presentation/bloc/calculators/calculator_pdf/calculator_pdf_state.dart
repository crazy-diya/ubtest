part of 'calculator_pdf_bloc.dart';

@immutable
abstract class CalculatorPDFState
    extends BaseState<CalculatorPDFState> {}

class CalculatorPDFInitial extends CalculatorPDFState {}

class CalculatorPDFSuccessState extends CalculatorPDFState {
  final String? document;
  final bool? shouldOpen;

  CalculatorPDFSuccessState({this.document, this.shouldOpen});
}

class CalculatorPDFFailedState extends CalculatorPDFState {
  final String? message;

  CalculatorPDFFailedState({this.message});
}
