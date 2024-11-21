import '../base_event.dart';

abstract class PaymentInstrumentEvent extends BaseEvent {}

class GetJustpayInstrumentEvent extends PaymentInstrumentEvent {
  final String? requestType;
  GetJustpayInstrumentEvent({this.requestType});
}


class SelectDefaultPaymentInstrumentEvent extends PaymentInstrumentEvent {
  final int? instrumentId;

  SelectDefaultPaymentInstrumentEvent({this.instrumentId});
}

class InstrumentStatusChangeEvent extends PaymentInstrumentEvent {
  final int? instrumentId;

  InstrumentStatusChangeEvent({this.instrumentId});
}

class AddInstrumentEvent extends PaymentInstrumentEvent {
  final String? nic;
  final String? fullName;
  final String? bankCode;
  final String? accountType;
  final String? accountNo;
  final String? nickName;
  final bool? enableAlert;

  AddInstrumentEvent({
    this.nic,
    this.fullName,
    this.bankCode,
    this.accountType,
    this.accountNo,
    this.nickName,
    this.enableAlert,
  });
}

class DeleteInstrumentEvent extends PaymentInstrumentEvent {
  final int? instrumentId;
  final String? instrumentType;
  final String? messageType;

  DeleteInstrumentEvent({
    this.instrumentId,
    this.instrumentType,
    this.messageType
  });
}

class InstrumentNikeNameChangeEvent extends PaymentInstrumentEvent {
  final int? instrumentId;
  final String? nickName;
  final String? instrumentType;
  final String? messageType;
  InstrumentNikeNameChangeEvent(
      {this.instrumentId, this.nickName, this.instrumentType,this.messageType});
}

class GetManageAccDetailsEvent extends PaymentInstrumentEvent {}
