class PromoAndOffersCategoryEntity {
  final String? label;
  bool isSelected;
  final bool? isInitialItem;
  final String? code;

  PromoAndOffersCategoryEntity({
    this.label,
    this.code,
    this.isSelected = false,
    this.isInitialItem = false,
  });
}
