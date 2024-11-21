part of 'apply_leasing_calculator_bloc.dart';

@immutable
abstract class ApplyLeasingCalculatorEvent extends BaseEvent {}

class ApplyLeasingCalculatorSaveDataEvent extends ApplyLeasingCalculatorEvent {
  final String? messageType;
  final String? name;
  final String? nic;
  final String? email;
  final String? mobileNumber;
  final String? branch;
  final String? reqType;
  final String? rate;
  final String? installmentType;
  final String? vehicleCategory;
  final String? vehicleType;
  final String? interestPeriod;
  final int? manufactYear;
  final int? price;
  final int? advancedPayment;
  final int? amount;

  ApplyLeasingCalculatorSaveDataEvent(
      {this.messageType,
      this.name,
      this.nic,
      this.email,
      this.mobileNumber,
      this.branch,
      this.reqType,
      this.rate,
      this.installmentType,
      this.vehicleCategory,
      this.vehicleType,
      this.manufactYear,
      this.interestPeriod,
      this.price,
      this.advancedPayment,
      this.amount,});
}
