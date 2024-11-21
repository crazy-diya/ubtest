part of 'request_money_bloc.dart';

abstract class RequestMoneyEvent extends BaseEvent{}

class RequestMoneyRequestEvent extends RequestMoneyEvent{
  final String? messageType;
  final String? toAccountNumber;
  final String? mobileNumber;
  final String? amount;
  final String? remarks;

  RequestMoneyRequestEvent(
      {this.messageType, this.toAccountNumber, this.mobileNumber , this.amount,this.remarks});
}

class RequestMoneyHistoryRequestEvent extends RequestMoneyEvent{
  final String? messageType;

  RequestMoneyHistoryRequestEvent({this.messageType});
}
