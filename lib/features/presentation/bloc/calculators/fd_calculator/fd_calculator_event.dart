part of 'fd_calculator_bloc.dart';

@immutable
abstract class FDCalculatorEvent extends BaseEvent {}

class FDCalculatorFieldDataEvent extends FDCalculatorEvent {}

class FDCalculatorSaveDataEvent extends FDCalculatorEvent {
  final String? messageType;
  final String? currencyCode;
  final String? amount;
  final String? interestPeriod;
  final String? interestReceived;
  final String? rate;

  FDCalculatorSaveDataEvent(
      {this.messageType,
      this.currencyCode,
      this.amount,
      this.interestPeriod,
      this.interestReceived,
      this.rate});
}

// ignore: must_be_immutable
class FDCalculatorPDFDataEvent extends FDCalculatorEvent {
  final String? title;
  List<DocBody>? docBody;
  final bool? shouldOpen;

  FDCalculatorPDFDataEvent({this.title, this.docBody, this.shouldOpen});
}


class GetFDRateEvent extends FDCalculatorEvent {
  final String? messageType;
  final DateTime? acceptedDate;

  GetFDRateEvent({this.messageType, this.acceptedDate});
}

class GetFDCurrencyEvent extends FDCalculatorEvent {
  final String? messageType;

  GetFDCurrencyEvent({this.messageType});
}

class GetFDPeriodEvent extends FDCalculatorEvent {
  final String? messageType;

  GetFDPeriodEvent({this.messageType});
}