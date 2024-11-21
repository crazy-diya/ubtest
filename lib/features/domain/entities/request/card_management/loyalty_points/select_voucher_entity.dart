import '../../../../../data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';

class SelectVoucherEntity {
  int? voucherId;
  int? noVouchers;
  int? minLoyaltyPoints;
  num? availablePoints;
  List<CardLoyaltyList>? cardLoyaltyList;

  SelectVoucherEntity({
    this.voucherId,
    this.noVouchers,
    this.minLoyaltyPoints,
    this.availablePoints,
    this.cardLoyaltyList
  });
}
