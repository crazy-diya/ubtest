// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountEntity {
    AccountEntity(
      {this.isUBAccount = true,
      this.instrumentId,
      this.status,
      this.nickName,
      this.bankName,
      this.bankCode,
      this.availableBalance = 0,
      this.accountNumber,
      this.accountType,
      this.isPrimary = false,
      this.isEmptyView = false,this.icon,this.cfprcd,this.currency});
  final bool isUBAccount;
  int? instrumentId;
  String? nickName;
  String? accountType;
  String? bankName;
  String? bankCode;
  double? availableBalance;
  final String? accountNumber;
  bool? isPrimary;
  bool isEmptyView;
  String? status;
  String? icon;
  String? cfprcd;
  String? currency;


  @override
  bool operator ==(covariant AccountEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.isUBAccount == isUBAccount &&
      other.instrumentId == instrumentId &&
      other.nickName == nickName &&
      other.accountType == accountType &&
      other.bankName == bankName &&
      other.bankCode == bankCode &&
      other.availableBalance == availableBalance &&
      other.accountNumber == accountNumber &&
      other.isPrimary == isPrimary &&
      other.isEmptyView == isEmptyView &&
      other.status == status &&
      other.icon == icon &&
      other.cfprcd == cfprcd &&
      other.currency == currency;
  }

  @override
  int get hashCode {
    return isUBAccount.hashCode ^
      instrumentId.hashCode ^
      nickName.hashCode ^
      accountType.hashCode ^
      bankName.hashCode ^
      bankCode.hashCode ^
      availableBalance.hashCode ^
      accountNumber.hashCode ^
      isPrimary.hashCode ^
      isEmptyView.hashCode ^
      status.hashCode ^
      cfprcd.hashCode ^
      currency.hashCode ^
      icon.hashCode;
  }





  @override
  String toString() {
    return 'AccountEntity(isUBAccount: $isUBAccount, instrumentId: $instrumentId, nickName: $nickName, accountType: $accountType, bankName: $bankName, bankCode: $bankCode, availableBalance: $availableBalance, accountNumber: $accountNumber, isPrimary: $isPrimary, isEmptyView: $isEmptyView, status: $status, icon: $icon ,cfprcd: $cfprcd ,currency: $currency)';
  }


}
