

import '../base_event.dart';

abstract class PromotionEvent extends BaseEvent {}

class GetPromotionsEvent extends PromotionEvent {
  final bool? isFromHome;
  final String? fromDate;
  final String? toDate;


  GetPromotionsEvent({this.isFromHome,this.fromDate,this.toDate});
}

class PromotionShareEvent extends PromotionEvent {


  final String? promotionId;
  final String? messageType;


  final bool? shouldOpen;

  PromotionShareEvent({

    this.promotionId,
    this.messageType,

    this.shouldOpen = false,
  });
}
