class TransactionHistoryArgs {
  final String? heading;
  final String? mobileNumber;
  final String? date;
  final double? amount;
  final String? refNumber;
  final String? remark;
  final String? crdr;
  final String? fromAccNumber;
  final String? fromAccName;
  final double? serviceFee;
  final String? id;
  final String? refId;

  TransactionHistoryArgs({
    this.heading,
    this.mobileNumber,
    this.date,
    this.amount,
    this.refNumber,
    this.remark,
    this.crdr,
    this.fromAccName,
    this.fromAccNumber,
    this.serviceFee,
    this.id,
    this.refId
  });
}
