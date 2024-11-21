part of 'housing_loan_calculator_bloc.dart';

@immutable
abstract class HousingLoanCalculatorState
    extends BaseState<HousingLoanCalculatorState> {}

class HousingLoanCalculatorInitial extends HousingLoanCalculatorState {}

class HousingLoanFieldDataSuccessState extends HousingLoanCalculatorState {
  // final HousingLoanResponseModel? response;
  //
  // HousingLoanFieldDataSuccessState({this.response});

  final String? monthlyInstallment;
  final String? rate;
  final String? amount;
  final String? tenure;

  HousingLoanFieldDataSuccessState({this.monthlyInstallment, this.rate , this.amount, this.tenure});
}

class HousingLoanFieldDataFailedState extends HousingLoanCalculatorState {
  final String? message;

  HousingLoanFieldDataFailedState({this.message});
}

class HousingLoanPDFSuccessState extends HousingLoanCalculatorState {
  final String? document;
  final bool? shouldOpen;

  HousingLoanPDFSuccessState({this.document, this.shouldOpen});
}

class HousingLoanPDFFailedState extends HousingLoanCalculatorState {
  final String? message;

  HousingLoanPDFFailedState({this.message});
}
