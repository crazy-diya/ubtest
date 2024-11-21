class PayeeDataEntity {
  String? title;
  String? accountNumber;
  String? amount;
  bool isSelected;

  PayeeDataEntity(
      {this.title, this.accountNumber, this.amount, this.isSelected = false});
}