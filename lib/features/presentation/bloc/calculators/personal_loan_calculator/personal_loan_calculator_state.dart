part of 'personal_loan_calculator_bloc.dart';

@immutable
abstract class PersonalLoanCalculatorState extends BaseState<PersonalLoanCalculatorState>{}

class PersonalLoanCalculatorInitial extends PersonalLoanCalculatorState {}

class PersonalLoanFieldDataSuccessState extends PersonalLoanCalculatorState {
  //final PersonalLoanResponse? personalLoanResponse;
  final String? monthlyInstallment;
  final String? rate;
  final String? amount;
  final String? tenure;
  final String? installmentType;

  PersonalLoanFieldDataSuccessState(
      {this.monthlyInstallment,
      this.rate,
      this.amount,
      this.tenure,
      this.installmentType});
}

class PersonalLoanFieldDataFailedState extends PersonalLoanCalculatorState {
  final String? message;

  PersonalLoanFieldDataFailedState({this.message});
}

class PersonalCalculatorPDFSuccessState extends PersonalLoanCalculatorState {
  final String? document;
  final bool? shouldOpen;

  PersonalCalculatorPDFSuccessState({this.document, this.shouldOpen});
}

class PersonalCalculatorPDFFailedState extends PersonalLoanCalculatorState {
  final String? message;

  PersonalCalculatorPDFFailedState({this.message});
}