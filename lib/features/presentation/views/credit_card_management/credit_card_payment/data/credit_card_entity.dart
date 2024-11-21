class CreditCardEntity {
  final bool isUBAccount;
  String? nickName;
  String? accountType;
  String? bankName;
  String? bankCode;
  String? accountNumber;
  double? availableBalance;
  final String? cardNumber;
  String? icon;

  CreditCardEntity({
    required this.isUBAccount,
    this.nickName,
    this.accountType,
    this.bankName,
    this.bankCode,
    this.accountNumber,
    this.availableBalance,
    this.cardNumber,
    this.icon,
  });
}
