// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';

import '../base_state.dart';

abstract class FloatInquiryState extends BaseState<FloatInquiryState> {}

class InitialFloatInquiryState extends FloatInquiryState {}


class FloatInquirySuccessState extends FloatInquiryState {
  FloatInquiryResponse? floatInquiryResponse;

  FloatInquirySuccessState(
   { this.floatInquiryResponse,}
  );
}

class FloatInquiryFailState extends FloatInquiryState {
  final String? message;
  final String? responseCode;

  FloatInquiryFailState({this.message, this.responseCode});
}

