class AccountStatementFilterData {
  String? fromDate;
  String? toDate;
  int? fromAmount;
  int? toAmount;
  String? status;
  bool? isFilterd;


  @override
  String toString() {
    return 'AccountStatementFilterData{fromDate: $fromDate, toDate: $toDate, fromAmount: $fromAmount, toAmount: $toAmount, status: $status, isFilterd: $isFilterd}';
  }

  AccountStatementFilterData({this.fromDate, this.toDate,this.fromAmount,this.toAmount,this.status,this.isFilterd});

}
