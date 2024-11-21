part of 'apply_housing_loan_bloc.dart';

@immutable
abstract class ApplyHousingLoanEvent extends BaseEvent {}

class ApplyHousingLoanSaveDataEvent extends ApplyHousingLoanEvent {
  final String? name;
  final String? nic;
  final String? email;
  final String? mobileNumber;
  final String? amount;
  final String? paymentPeriod;
  final String? grossIncome;
  final String? reqType;
  final String? messageType;
  final String? rate;
  final String? installmentType;

  ApplyHousingLoanSaveDataEvent(
      {this.name,
      this.nic,
      this.email,
      this.mobileNumber,
      this.amount,
      this.paymentPeriod,
      this.grossIncome,
      this.reqType,
      this.messageType,
      this.rate,
      this.installmentType});
}
