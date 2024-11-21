class ManageOtherBankAccountEntity {
  String title;
  String accountNo;
  String image;
  bool isSelected;
  bool isFavorite;

  ManageOtherBankAccountEntity({
    required this.title,
    required this.accountNo,
    required this.image,
    this.isSelected = false,
    this.isFavorite = false,
  });
}
