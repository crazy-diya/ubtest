import '../../../../data/models/responses/promotions_response.dart';

class FilteredData {
  FilteredData({ this.promotionalType, required this.promotionData});

  String? promotionalType;
  List<PromotionList> promotionData;
}
