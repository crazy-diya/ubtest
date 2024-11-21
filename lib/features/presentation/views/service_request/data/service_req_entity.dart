

import '../../../../domain/entities/response/account_entity.dart';

class ServiceReqEntity {
  ///Fund Transfer Type (Saved, Unsaved or Scheduled)
  AccountEntity? accountEntity;
  double? availableBalance;
  String? payFromNum;
  String? payFromName;
  String? collectionMethod;
  String? branchName;
  String? city;
  String? noOfLeaves;
  String? branchCode;
  String? fromDate;
  String? toDate;
  int? instrumentId;
  int? bankCodePayFrom;
  double? amount;
  String? address;
  String? addressLine1;
  String? addressLine2;
  DateTime? startDate;
  DateTime? endDate;

  ServiceReqEntity(
      {this.accountEntity,
      this.availableBalance,
      this.collectionMethod,
      this.branchName,
      this.noOfLeaves,
      this.city,
      this.branchCode,
      this.payFromNum,
      this.fromDate,
      this.toDate,
      this.addressLine1,
      this.addressLine2,
      this.payFromName,
      this.instrumentId,
      this.bankCodePayFrom,
      this.amount,
      this.startDate,
      this.endDate,
      this.address});
}
