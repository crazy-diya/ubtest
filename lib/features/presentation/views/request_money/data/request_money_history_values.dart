class RequestMoneyHistoryValues{
  final int? id;
  final String? cdbUserPayor;
  final String? toAccount;
  final String? toAccountName;
  final double? requestedAmount;
  final String? remarks;
  final String? status;
  final String? date;


  @override
  String toString() {
    return 'RequestMoneyHistoryValues{id: $id, cdbUserPayor: $cdbUserPayor, toAccount: $toAccount, toAccountName: $toAccountName, requestedAmount: $requestedAmount, remarks: $remarks, status: $status}';
  }

  RequestMoneyHistoryValues(
      {this.id,
        this.cdbUserPayor,
        this.toAccount,
        this.toAccountName,
        this.requestedAmount,
        this.remarks,
        this.date,
        this.status});
}