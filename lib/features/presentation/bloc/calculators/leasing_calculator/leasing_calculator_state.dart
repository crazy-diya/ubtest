part of 'leasing_calculator_bloc.dart';

@immutable
abstract class LeasingCalculatorState
    extends BaseState<LeasingCalculatorState> {}

class LeasingCalculatorInitial extends LeasingCalculatorState {}

class LeasingFieldDataSuccessState extends LeasingCalculatorState {
  // final HousingLoanResponseModel? response;
  //
  // HousingLoanFieldDataSuccessState({this.response});

  final String? rate;
  final String? monthlyInstallment;


  LeasingFieldDataSuccessState({this.rate , this.monthlyInstallment});
}

class LeasingFieldDataFailedState extends LeasingCalculatorState {
  final String? message;

  LeasingFieldDataFailedState({this.message});
}

class LeasingPDFSuccessState extends LeasingCalculatorState {
  final String? document;
  final bool? shouldOpen;

  LeasingPDFSuccessState({this.document, this.shouldOpen});
}

class LeasingPDFFailedState extends LeasingCalculatorState {
  final String? message;

  LeasingPDFFailedState({this.message});
}
