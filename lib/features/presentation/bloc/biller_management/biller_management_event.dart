

import '../../../domain/entities/response/custom_field_entity.dart';
import '../base_event.dart';

abstract class BillerManagementEvent extends BaseEvent {}

class GetSavedBillersEvent extends BillerManagementEvent {}

class AddBillerEvent extends BillerManagementEvent {
  final String? nickName;
  //final String? accNumber;
  final int? serviceProviderId;
  final List<CustomFieldEntity>? customFields;
  final bool? isFavorite;
  final String? billerNo;
  final bool verified;

  AddBillerEvent({this.nickName, this.serviceProviderId, this.customFields,this.isFavorite,this.billerNo,required this.verified, });
}

class FavouriteBillerEvent extends BillerManagementEvent {
  final String messageType;
  final int? billerId;
  final bool? isFavourire;

  FavouriteBillerEvent({this.billerId,required this.messageType,this.isFavourire});
}

class DeleteBillerEvent extends BillerManagementEvent {
  final int? billerId;
  final List<int>? deleteAccountList;

  DeleteBillerEvent({this.billerId,this.deleteAccountList});
}

class GetBillerCategoryListEvent extends BillerManagementEvent {}

class EditUserBillerEvent extends BillerManagementEvent {
  final String? nickName;
  final String? serviceProviderId;
  final int? billerId;
  final String? categoryId;
  //final List<CustomFieldEntity>? fieldList;
  final bool? isFavorite;
  final String accNum;

  EditUserBillerEvent(
      {this.nickName,
      this.serviceProviderId,
      this.billerId,
      this.categoryId,
        this.isFavorite,
        required this.accNum
      });
}

class UnFavoriteBillerEvent extends BillerManagementEvent {
  final int? billerId;

  UnFavoriteBillerEvent({this.billerId});
}

/// Bill Payment
class BillPaymentEvent extends BillerManagementEvent {
  final int? instrumentId;
  final String? billerId;
  final String? accountNumber;
  final double? amount;
  final String? remarks;
  //final String? serviceCharge;
  final String? billPaymentCategory;
  final String? serviceProviderId;

  BillPaymentEvent(
      {this.instrumentId,
      this.billerId,
      this.accountNumber,
      this.amount,
      this.remarks,
     //this.serviceCharge,
        this.billPaymentCategory,
        this.serviceProviderId
      });
}

///PDF download
class BillerPdfDDownloadEvent extends BillerManagementEvent {
  final String? transactionId;
  final String? transactionType;
  final bool? shouldOpen;

  BillerPdfDDownloadEvent({
    this.shouldOpen = false,
    this.transactionId,
    this.transactionType,
  });
}

///excel download
class BillerExcelDownloadEvent extends BillerManagementEvent{
  final String? transactionId;
  final String? transactionType;
  final bool? shouldOpen;

  BillerExcelDownloadEvent({
    this.shouldOpen = false,
    this.transactionId,
    this.transactionType,
  });
}

class SchedulingBillPaymentEvent extends BillerManagementEvent {
  String? messageType;
  int? paymentInstrumentId;
  int? startDay;
  String? toAccountNo;
  String? toBankCode;
  String? toAccountName;
  String? scheduleSource;
  String? scheduleType;
  String? scheduleTitle;
  String? startDate;
  String? endDate;
  String? frequency;
  String? transCategory;
  String? reference;
  String? amount;
  String? remarks;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? failCount;
  String? status;
  String? createdUser;
  String? modifiedUser;
  String? createdDate;
  String? modifiedDate;
  String? tranType;
  String? billerId;
  String? transactionDate;
  int? starDay;

  SchedulingBillPaymentEvent({
    this.paymentInstrumentId,
    this.startDay,
    this.toAccountNo,
    this.toBankCode,
    this.toAccountName,
    this.scheduleSource,
    this.scheduleType,
    this.scheduleTitle,
    this.startDate,
    this.endDate,
    this.frequency,
    this.transCategory,
    this.reference,
    this.amount,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobile,
    this.failCount,
    this.status,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
    this.transactionDate,
    this.starDay,
    this.tranType,
    this.messageType,
    this.billerId,
  });

}
