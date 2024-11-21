class TranLimitEntity{
  String? transactionType;
  String? maxUserAmountPerDay;
  String? maxUserAmountPerTran;
  String? maxGlobalLimitPerTran;
  String? maxGlobalLimitPerDay;
  String? minUserAmountPerTran;
  String? globalTwoFactorLimit;
  String? description;
  String? twoFactorLimmit;
  bool? isTwofactorEnabble;


  @override
  String toString() {
    return 'TranLimitEntity{transactionType: $transactionType, maxUserAmountPerDay: $maxUserAmountPerDay, maxUserAmountPerTran: $maxUserAmountPerTran, maxGlobalLimitPerTran: $maxGlobalLimitPerTran, minUserAmountPerTran: $minUserAmountPerTran, description: $description, twoFactorLimmit: $twoFactorLimmit, isTwofactorEnabble: $isTwofactorEnabble}';
  }

  TranLimitEntity(
      {this.transactionType,
      this.maxUserAmountPerDay,
      this.maxUserAmountPerTran,
      this.minUserAmountPerTran,
      this.description,
      this.isTwofactorEnabble,
      this.maxGlobalLimitPerTran,
      this.globalTwoFactorLimit,
      this.maxGlobalLimitPerDay,
      this.twoFactorLimmit
      });
}