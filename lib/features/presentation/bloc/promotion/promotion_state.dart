import '../../../data/models/responses/promotions_response.dart';
import '../base_state.dart';

abstract class PromotionState extends BaseState<PromotionState> {}

class InitialPromotionState extends PromotionState {}

class PromotionsSuccessState extends PromotionState {
  final List<PromotionList>? promotions;
  final List<Category>? category;

  PromotionsSuccessState({this.promotions,this.category});
}

class PromotionsFailedState extends PromotionState {
  String? message;

  PromotionsFailedState({this.message});
}

class PromotionPdfShareSuccessState extends PromotionState {
  final String? document;
  final bool? shouldOpen;

  PromotionPdfShareSuccessState({this.document,this.shouldOpen,});
}

class PromotionPdfShareFailedState extends PromotionState {
  final String? message;

  PromotionPdfShareFailedState({this.message});
}
