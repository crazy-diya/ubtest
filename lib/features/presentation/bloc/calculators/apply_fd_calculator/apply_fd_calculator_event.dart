part of 'apply_fd_calculator_bloc.dart';

@immutable
abstract class ApplyFDCalculatorEvent extends BaseEvent {}

class ApplyFDCalculatorSaveDataEvent extends ApplyFDCalculatorEvent {
  final String? messageType;
  final String? nic;
  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? branch;
  final String? reqType;
  final String? rate;
  final String? installmentType;
  final String? interestPeriod;
  final String? currencyCode;
  final String? interestRecieved;
  final String? amount;

  ApplyFDCalculatorSaveDataEvent(
      {this.messageType,
      this.nic,
      this.name,
      this.email,
      this.mobileNumber,
      this.branch,
      this.reqType,
      this.rate,
      this.installmentType,
      this.interestPeriod,
      this.currencyCode,
      this.amount,
      this.interestRecieved});
}
