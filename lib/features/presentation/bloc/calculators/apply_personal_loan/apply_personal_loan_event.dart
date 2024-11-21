part of 'apply_personal_loan_bloc.dart';

@immutable
abstract class ApplyPersonalLoanEvent extends BaseEvent {}

class ApplyPersonalLoanSaveDataEvent extends ApplyPersonalLoanEvent {
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

  ApplyPersonalLoanSaveDataEvent(
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
