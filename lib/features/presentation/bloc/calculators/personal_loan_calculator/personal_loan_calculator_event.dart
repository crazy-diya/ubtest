part of 'personal_loan_calculator_bloc.dart';

@immutable
abstract class PersonalLoanCalculatorEvent extends BaseEvent {}

class PersonalLoanFieldDataEvent extends PersonalLoanCalculatorEvent {}

class PersonalLoanSaveDataEvent extends PersonalLoanCalculatorEvent {
  final String? loanAmount;
  final String? tenure;
  final String? interestRate;
  final String? installmentType;
  final String? messageType;

  PersonalLoanSaveDataEvent(
      {this.loanAmount,
      this.tenure,
      this.interestRate,
      this.installmentType,
      this.messageType});
}

// ignore: must_be_immutable
class PersonalCalculatorPDFDataEvent extends PersonalLoanCalculatorEvent {
  final String? title;
  List<DocBody>? docBody;
  final bool? shouldOpen;

  PersonalCalculatorPDFDataEvent({this.title, this.docBody, this.shouldOpen});
}