import '../base_event.dart';

abstract class FundTransferEvent extends BaseEvent {}

class AddIntraFundTransferEvent extends FundTransferEvent {
  final String? transactionCategory;
  final int? instrumentId;
  final String? toBankCode;
  final String? toAccountNo;
  final String? toAccountName;
  final double? amount;
  final String? remarks;
  final String? beneficiaryEmail;
  final String? beneficiaryMobileNo;
  final String? reference;
  final String? tranType;
  final bool? isCreditCardPayment;

  AddIntraFundTransferEvent({
    this.toAccountName,
    this.toBankCode,
    this.toAccountNo,
    this.reference,
    this.instrumentId,
    this.amount,
    this.remarks,
    this.transactionCategory,
    this.beneficiaryEmail,
    this.beneficiaryMobileNo,
    this.tranType,
    this.isCreditCardPayment,

  });
}

class OneTimeFundTransferEvent extends FundTransferEvent {

}

class SchedulingFundTransferEvent extends FundTransferEvent {
    String? tranType;
    int? scheduleId;
    int? paymentInstrumentId;
    int? startDay;
    String? toAccountNo;
    String? toBankCode;
    String? toAccountName;
    String? scheduleSource;
    String? scheduleType;
    String? scheduleTitle;
    DateTime? startDate;
    DateTime? endDate;
    String? frequency;
    String? transCategory;
    String? reference;
    double? amount;
    String? remarks;
    String? beneficiaryEmail;
    String? beneficiaryMobile;
    int? failCount;
    String? status;
    String? createdUser;
    String? modifiedUser;
    DateTime? createdDate;
    DateTime? modifiedDate;
    String? fromAccountNo;
    String? fromBankCode;
    String? fromAccountName;
    double? serviceCharge;
    int? noOfTransfers;
    int? oneTime;
    String? deviceChannel;
    String? billerId;

    SchedulingFundTransferEvent({
        this.tranType,
        this.scheduleId,
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
        this.fromAccountNo,
        this.fromBankCode,
        this.fromAccountName,
        this.serviceCharge,
        this.noOfTransfers,
        this.oneTime,
        this.deviceChannel,
        this.billerId,
    });

}

// class SchedulingBillPaymentEvent extends FundTransferEvent {
//   String? messageType;
//   int? paymentInstrumentId;
//   int? startDay;
//   String? toAccountNo;
//   String? toBankCode;
//   String? toAccountName;
//   String? scheduleSource;
//   String? scheduleType;
//   String? scheduleTitle;
//   String? startDate;
//   String? endDate;
//   String? frequency;
//   String? transCategory;
//   String? reference;
//   String? amount;
//   String? remarks;
//   String? beneficiaryEmail;
//   String? beneficiaryMobile;
//   int? failCount;
//   String? status;
//   String? createdUser;
//   String? modifiedUser;
//   String? createdDate;
//   String? modifiedDate;
//   String? tranType;
//   String? billerId;
//   String? transactionDate;
//   int? starDay;

//   SchedulingBillPaymentEvent({
//     this.paymentInstrumentId,
//     this.startDay,
//     this.toAccountNo,
//     this.toBankCode,
//     this.toAccountName,
//     this.scheduleSource,
//     this.scheduleType,
//     this.scheduleTitle,
//     this.startDate,
//     this.endDate,
//     this.frequency,
//     this.transCategory,
//     this.reference,
//     this.amount,
//     this.remarks,
//     this.beneficiaryEmail,
//     this.beneficiaryMobile,
//     this.failCount,
//     this.status,
//     this.createdUser,
//     this.modifiedUser,
//     this.createdDate,
//     this.modifiedDate,
//     this.transactionDate,
//     this.starDay,
//     this.tranType,
//     this.messageType,
//     this.billerId,
//   });

// }

class TransactionLimitEvent extends FundTransferEvent {}

class TransactionLimitAddEvent extends FundTransferEvent {
  final String? code;
  final String? channelType;
  final double? maxAmountPerDay;

  TransactionLimitAddEvent({
    this.code,
    this.channelType,
    this.maxAmountPerDay,
  });
}

class FundTransferReceiptDownloadEvent extends FundTransferEvent{
  final String? transactionId;
  final String? messageType;
  final String? transactionType;
  final bool? shouldOpen;

  FundTransferReceiptDownloadEvent({this.transactionId,
    this.shouldOpen = false,
    this.transactionType,
    this.messageType});
}


class FundTransferExcelDownloadEvent extends FundTransferEvent{
  final String? transactionId;
  final String? messageType;
  final String? transactionType;
  final bool? shouldOpen;

  FundTransferExcelDownloadEvent({this.transactionId,
    this.shouldOpen = false,
    this.transactionType,
    this.messageType});
}



///Get All Schedule FT
class GetAllScheduleFTEvent extends FundTransferEvent{}

///request money
class ReqMoneyFundTranStatusEvent extends FundTransferEvent {
  final String? messageType;
  final String? requestMoneyId;
  final String? status;
  final String? transactionStatus;
  final String? transactionId;

  ReqMoneyFundTranStatusEvent(
      {this.messageType, this.requestMoneyId, this.status, this.transactionStatus, this.transactionId});
}
