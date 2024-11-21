


import '../../../../data/models/responses/faq_response.dart';
import '../../base_state.dart';

abstract class FaqState extends BaseState<FaqState> {}

class InitialFaqState extends FaqState {}

class FaqSuccessState extends FaqState {
  final List<FaqList>? faqData;
  final String? publicLink;

  FaqSuccessState({this.faqData, this.publicLink});
}

class FaqFailState extends FaqState {
  final String? errorMessage;

  FaqFailState({this.errorMessage});
}