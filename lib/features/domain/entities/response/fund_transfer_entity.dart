import '../../../../utils/enums.dart';
import 'account_entity.dart';
import 'saved_payee_entity.dart';

class FundTransferEntity {
  ///Fund Transfer Type (Saved, Unsaved or Scheduled)
   FTType? fundTransferType;

  SavedPayeeEntity? payTo;
   AccountEntity? accountEntity;
  final int? transactionCategoryId;
  String? transactionCategory;
  String? reference;
  double? amount;
  String? remark;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  String? accountNumber;
  String? bankName;
  String? payToBankName;
  String? ceftCode;
  int? bankCode;
  int? bankCodePayFrom;
  String? name;
  String? scheduleType;
  String? scheduleFrequency;
  int? scheduleTypeId;
  int? scheduleFrequencyId;
  String? scheduleTitle;
  String? startDate;
   String? endDate;
  bool? notifyTheBeneficiary;
  String? transactionDate;
  String? route;
  double? availableBalance;
  bool? isCDBAccount;
  String? noOfTransfers;
  String? tranId;
  String? payFromName;
  String? payFromNum;
  String? branch;
  String? payToacctname;
  String? payToacctnmbr;
  int? scheduleId;
  int? instrumentId;
  int? tabID;
  double? serviceCharge;
  FtRouteType? ftRouteType;
   String? icon;
   String? iconPayFrom;
   bool? isFromContacts;
   String? tranType;
   num? scheduleAmount;

  FundTransferEntity({
    this.accountEntity,
    this.transactionDate,
    this.fundTransferType,
    this.payTo,
    this.ceftCode,
    this.transactionCategoryId,
    this.transactionCategory,
    this.reference,
    this.amount,
    this.remark,
    this.beneficiaryEmail,
    this.beneficiaryMobile,
    this.accountNumber,
    this.route,
    this.bankName,
    this.payToBankName,
    this.bankCode,
    this.bankCodePayFrom,
    this.name,
    this.notifyTheBeneficiary,
    this.scheduleType,
    this.scheduleFrequency,
    this.scheduleTypeId,
    this.scheduleFrequencyId,
    this.scheduleTitle,
    this.startDate,
    this.endDate,
    this.availableBalance,
    this.isCDBAccount,
    this.noOfTransfers,
    this.tranId,
    this.payFromName,
    this.payFromNum,
    this.payToacctname,
    this.payToacctnmbr,
    this.scheduleId,
    this.instrumentId,
    this.serviceCharge,
    this.ftRouteType,
    this.tabID,
    this.icon,
    this.iconPayFrom,
    this.isFromContacts,
    this.tranType,
    this.scheduleAmount,
  });

   @override
  bool operator ==(covariant FundTransferEntity other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          fundTransferType == other.fundTransferType &&
          payTo == other.payTo &&
          accountEntity == other.accountEntity &&
          transactionCategoryId == other.transactionCategoryId &&
          transactionCategory == other.transactionCategory &&
          reference == other.reference &&
          amount == other.amount &&
          remark == other.remark &&
          beneficiaryEmail == other.beneficiaryEmail &&
          beneficiaryMobile == other.beneficiaryMobile &&
          accountNumber == other.accountNumber &&
          bankName == other.bankName &&
          payToBankName == other.payToBankName &&
          ceftCode == other.ceftCode &&
          bankCode == other.bankCode &&
          bankCodePayFrom == other.bankCodePayFrom &&
          name == other.name &&
          scheduleType == other.scheduleType &&
          scheduleFrequency == other.scheduleFrequency &&
          scheduleTypeId == other.scheduleTypeId &&
          scheduleFrequencyId == other.scheduleFrequencyId &&
          scheduleTitle == other.scheduleTitle &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          notifyTheBeneficiary == other.notifyTheBeneficiary &&
          transactionDate == other.transactionDate &&
          route == other.route &&
          availableBalance == other.availableBalance &&
          isCDBAccount == other.isCDBAccount &&
          noOfTransfers == other.noOfTransfers &&
          tranId == other.tranId &&
          payFromName == other.payFromName &&
          payFromNum == other.payFromNum &&
          branch == other.branch &&
          payToacctname == other.payToacctname &&
          payToacctnmbr == other.payToacctnmbr &&
          scheduleId == other.scheduleId &&
          instrumentId == other.instrumentId &&
          tabID == other.tabID &&
          serviceCharge == other.serviceCharge &&
          ftRouteType == other.ftRouteType &&
          icon == other.icon &&
          iconPayFrom == other.iconPayFrom &&
          tranType == other.tranType &&
          scheduleAmount == other.scheduleAmount &&
          isFromContacts == other.isFromContacts ;

  @override
  int get hashCode =>
      fundTransferType.hashCode ^
      payTo.hashCode ^
      accountEntity.hashCode ^
      transactionCategoryId.hashCode ^
      transactionCategory.hashCode ^
      reference.hashCode ^
      amount.hashCode ^
      remark.hashCode ^
      beneficiaryEmail.hashCode ^
      beneficiaryMobile.hashCode ^
      accountNumber.hashCode ^
      bankName.hashCode ^
      payToBankName.hashCode ^
      ceftCode.hashCode ^
      bankCode.hashCode ^
      bankCodePayFrom.hashCode ^
      name.hashCode ^
      scheduleType.hashCode ^
      scheduleFrequency.hashCode ^
      scheduleTypeId.hashCode ^
      scheduleFrequencyId.hashCode ^
      scheduleTitle.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      notifyTheBeneficiary.hashCode ^
      transactionDate.hashCode ^
      route.hashCode ^
      availableBalance.hashCode ^
      isCDBAccount.hashCode ^
      noOfTransfers.hashCode ^
      tranId.hashCode ^
      payFromName.hashCode ^
      payFromNum.hashCode ^
      branch.hashCode ^
      payToacctname.hashCode ^
      payToacctnmbr.hashCode ^
      scheduleId.hashCode ^
      instrumentId.hashCode ^
      tabID.hashCode ^
      serviceCharge.hashCode ^
      ftRouteType.hashCode ^
      icon.hashCode ^
      iconPayFrom.hashCode ^
      tranType.hashCode ^
      scheduleAmount.hashCode ^
      isFromContacts.hashCode;
}
