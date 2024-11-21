class ApplyFilterEntity {
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;
  final String? transactionType;

  ApplyFilterEntity(
      {this.fromDate,
      this.toDate,
      this.fromAmount,
      this.toAmount,
      this.transactionType});
}
