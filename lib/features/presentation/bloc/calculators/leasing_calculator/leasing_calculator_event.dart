part of 'leasing_calculator_bloc.dart';

@immutable
abstract class LeasingCalculatorEvent extends BaseEvent {}

class LeasingFieldDataEvent extends LeasingCalculatorEvent {}

class LeasingSaveDataEvent extends LeasingCalculatorEvent {
  final String? messageType;
  final String? vehicleCategory;
  final String? vehicleType;
  final String? manufactYear;
  final String? price;
  final String? advancedPayment;
  final String? amount;
  final String? tenure;
  final String? rate;

  LeasingSaveDataEvent(
      {this.messageType,
      this.vehicleCategory,
      this.vehicleType,
      this.manufactYear,
      this.price,
      this.advancedPayment,
      this.amount,
      this.tenure,
      this.rate});
}

// ignore: must_be_immutable
class  LeasingPDFDataEvent extends LeasingCalculatorEvent {
  final String? title;
  List<DocBody>? docBody;
  final bool? shouldOpen;

  LeasingPDFDataEvent({this.title, this.docBody, this.shouldOpen});
}