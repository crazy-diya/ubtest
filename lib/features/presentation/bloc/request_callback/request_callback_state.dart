// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';

import '../base_state.dart';

abstract class RequestCallBackState extends BaseState<RequestCallBackState> {}

class InitialRequestCallBackState extends RequestCallBackState {}


class RequestCallBackSaveSuccessState extends RequestCallBackState {}

class RequestCallBackSaveFailState extends RequestCallBackState {
  final String? message;
  final String? responseCode;

  RequestCallBackSaveFailState({this.message, this.responseCode});
}

class RequestCallBackGetSuccessState extends RequestCallBackState {
  List<Response>? requestCallBackGetResponse;
  int? count;

  RequestCallBackGetSuccessState({this.requestCallBackGetResponse, this.count});
}

class RequestCallBackGetFailState extends RequestCallBackState {
  final String? message;
  final String? responseCode;

  RequestCallBackGetFailState({this.message, this.responseCode});
}

class RequestCallBackCancelSuccessState extends RequestCallBackState {
  final String? message;
  final String? responseCode;

  RequestCallBackCancelSuccessState({this.message, this.responseCode});
}

class RequestCallBackCancelFailState extends RequestCallBackState {
  final String? message;
  final String? responseCode;

  RequestCallBackCancelFailState({this.message, this.responseCode});
}

class RequestCallBackGetDefaultDataSuccessState extends RequestCallBackState {
  RequestCallBackGetDefaultDataResponse? requestCallBackGetDefaultDataResponse;

  RequestCallBackGetDefaultDataSuccessState(
   { this.requestCallBackGetDefaultDataResponse,}
  );
}

class RequestCallBackGetDefaultDataFailState extends RequestCallBackState {
  final String? message;
  final String? responseCode;

  RequestCallBackGetDefaultDataFailState({this.message, this.responseCode});
}
