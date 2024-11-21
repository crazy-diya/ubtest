class TransactionLimitsEntity {
   int? count;
  final String? code;
  final String? description;
   double? maxAmountPerDay;
   double? newAmountPerDay;
   bool isEditLimit ;

  TransactionLimitsEntity({
    this.isEditLimit  = false,
    this.count,
    this.newAmountPerDay,
    this.code,
    this.description,
    this.maxAmountPerDay,
  });
}
