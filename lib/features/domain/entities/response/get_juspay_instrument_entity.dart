import 'dart:typed_data';

class UserInstrumentsListEntity {
  int? id;
  String? accountNo;
  String? accType;
  String? bankCode;
  String? bankName;
  String? nickName;
  String? status;
  Uint8List? image;
  bool? isSelected;
  String? instrumentType;
  bool? isPrimary;
  bool? alert;
  String? accountBalance;
  String? icon;

  UserInstrumentsListEntity({
    this.id,
    this.accountNo,
    this.accType,
    this.bankCode,
    this.bankName,
    this.nickName,
    this.status,
    this.image,
    this.isSelected,
    this.instrumentType,
    this.isPrimary,
    this.alert,
    this.icon,
    this.accountBalance,
  });

  @override
  bool operator ==(covariant UserInstrumentsListEntity other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          id == other.id &&
          accountNo == other.accountNo &&
          accType == other.accType &&
          bankCode == other.bankCode &&
          bankName == other.bankName &&
          nickName == other.nickName &&
          status == other.status &&
          image == other.image &&
          isSelected == other.isSelected &&
          instrumentType == other.instrumentType &&
          isPrimary == other.isPrimary &&
          alert == other.alert &&
          accountBalance == other.accountBalance;

  @override
  int get hashCode =>
      id.hashCode ^
      accountNo.hashCode ^
      accType.hashCode ^
      bankCode.hashCode ^
      bankName.hashCode ^
      nickName.hashCode ^
      status.hashCode ^
      image.hashCode ^
      isSelected.hashCode ^
      instrumentType.hashCode ^
      isPrimary.hashCode ^
      alert.hashCode ^
      accountBalance.hashCode;
}