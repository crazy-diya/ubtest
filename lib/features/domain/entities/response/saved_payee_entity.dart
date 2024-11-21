// ignore_for_file: public_member_api_docs, sort_constructors_first
class SavedPayeeEntity {
  String? nickName;
  String? accountNumber;
  String? payeeImageUrl;
  String? accountHolderName;
  String? bankName;
  String? bankCode;
  String? branchName;
  String? branchCode;
  String? ceftCode;
  bool isFavorite;
  bool isSelected;
  int? id;
  String? epicUserId;
  String? name;
  

  SavedPayeeEntity(
      {this.nickName,
      this.bankCode,
      this.ceftCode,
      this.accountHolderName,
      this.bankName,
      this.payeeImageUrl,
      this.branchName,
      this.branchCode,
      this.isFavorite = false,
      this.accountNumber,
      this.isSelected = false,
      this.id,
        this.epicUserId,
        this.name,
      });

  @override
  String toString() {
    return 'SavedPayeeEntity(nickName: $nickName, accountNumber: $accountNumber, payeeImageUrl: $payeeImageUrl, accountHolderName: $accountHolderName, bankName: $bankName, bankCode: $bankCode, branchName: $branchName, branchCode: $branchCode, ceftCode: $ceftCode, isFavorite: $isFavorite, isSelected: $isSelected, id: $id, epicUserId: $epicUserId, name: $name)';
  }
}
