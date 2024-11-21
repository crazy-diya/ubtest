part of 'request_money_bloc.dart';

abstract class RequestMoneyState extends BaseState<RequestMoneyState> {}

class RequestMoneyInitial extends RequestMoneyState {}

class RequestMoneyFailState extends RequestMoneyState {
  final String? message;
  final String? responseCode;

  RequestMoneyFailState({this.message, this.responseCode});
}

class RequestMoneySuccessState extends RequestMoneyState {
  final String? responseCode;
  final String? responseDescription;

  RequestMoneySuccessState({
    this.responseCode,
    this.responseDescription,
  });
}

class RequestMoneyHistoryFailState extends RequestMoneyState {
  final String? message;
  final String? responseCode;

  RequestMoneyHistoryFailState({this.message, this.responseCode});
}

class RequestMoneyHistorySuccessState extends RequestMoneyState {
  final List<ListElement>? list;

  RequestMoneyHistorySuccessState({this.list});
}

