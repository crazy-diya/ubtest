part of 'housing_loan_calculator_bloc.dart';

@immutable
abstract class HousingLoanCalculatorEvent extends BaseEvent {}

class HousingLoanFieldDataEvent extends HousingLoanCalculatorEvent {}

class HousingLoanSaveDataEvent extends HousingLoanCalculatorEvent {
  final String? loanAmount;
  final String? tenure;
  final String? interestRate;
  final String? installmentType;
  final String? messageType;

  HousingLoanSaveDataEvent(
      {this.loanAmount,
        this.tenure,
        this.interestRate,
        this.installmentType,
        this.messageType,
      });
}

// ignore: must_be_immutable
class HousingLoanPDFDataEvent extends HousingLoanCalculatorEvent {
  final String? title;
  List<DocBody>? docBody;
  final bool? shouldOpen;

  HousingLoanPDFDataEvent({this.title, this.docBody, this.shouldOpen});
}