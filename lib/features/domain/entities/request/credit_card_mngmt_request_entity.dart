class CreditCardMngmtRequestEntity{
  String title;
  String? bankCode;
  final String cardNo;
  String? availablePoints;
  String? pointsAboutToExpire;

  CreditCardMngmtRequestEntity({required this.title, required this.cardNo, this.bankCode,this.availablePoints,this.pointsAboutToExpire});
}