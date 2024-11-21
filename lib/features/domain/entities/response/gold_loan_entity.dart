class GoldLoanEntity {
  final String? ticketNumber;
  String? remark;
  String? referenceID;
  final bool? isActive;
  final double? outstandingAmount;
  final String? loanPeriodsInMonths;
  final String? expireDate;
  final String? nextTopUpDate;
  final double interestBalance;
  final double maximumAdvanceLimit;
  final double capitalBalance;
  final double remainingAdvanceLimit;
  final double chargeBalance;
  final bool isTopUpAvailable;
  int? isTopUP;
  final List<ArticleDetailItem>? articleDetailList;
   double? maxValue;
   double? minValue;

  GoldLoanEntity({
    this.ticketNumber,
    this.referenceID,
    this.isActive,
    this.outstandingAmount = 0,
    this.loanPeriodsInMonths,
    this.expireDate,
    this.interestBalance = 0,
    this.maximumAdvanceLimit = 0,
    this.capitalBalance = 0,
    this.chargeBalance = 0,
    this.articleDetailList,
    this.nextTopUpDate,
    this.isTopUpAvailable = true,
    this.remainingAdvanceLimit = 0,
    this.remark,
    this.isTopUP,
    this.maxValue,
    this.minValue
  });
}

class ArticleDetailItem {
  final String? title;
  final String? description;
  final int? itemCount;
  final double? chargeBalance;

  ArticleDetailItem(
      {this.itemCount,
      this.title = '',
      this.description = '',
      this.chargeBalance});
}
