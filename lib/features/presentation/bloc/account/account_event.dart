import '../base_event.dart';

abstract class AccountEvent extends BaseEvent {}

class GetAccountInquiryEvent extends AccountEvent {
  final String? cif;

  GetAccountInquiryEvent({this.cif});
}

class GetBalanceInquiryEvent extends AccountEvent {
  final String? accountNumber;

  GetBalanceInquiryEvent({this.accountNumber});
}

/// Get User Instrument
class GetUserInstrumentEvent extends AccountEvent {
  final String? requestType;

  GetUserInstrumentEvent({
    this.requestType,
  });
}

///get tran limits
class GetTranLimitForFTEvent extends AccountEvent {
}

///get portfolio accounts
class GetPortfolioAccDetailsEvent extends AccountEvent {}

///get biometric for 2FA
class BiometricFor2FALoginEvent extends AccountEvent {}

class RequestBiometricPrompt2FAEvent extends AccountEvent {}

class QRPaymentEvent extends AccountEvent {
  final String? lankaQRcode;
  final String? mcc;
  final String? instrumentId;
  final String? tidNo;
  final String? referenceNo;
  final String? remarks;
  final String? merchantName;
  final String? merchantAccountNumber;
  final String? txnAmount;

  QRPaymentEvent({
    this.instrumentId,
    this.lankaQRcode,
    this.mcc,
    this.tidNo,
    this.remarks,
    this.referenceNo,
    this.merchantName,
    this.merchantAccountNumber,
    this.txnAmount,
  });
}

class QRPaymentPdfDownloadEvent extends AccountEvent {
  final String? txnAmount;
  final String? serviceCharge;
  final String? status;
  final String? remarks;
  final String? date;
  final String? referenceNo;
  final String? transactionId;
  final bool? shouldOpen;

  QRPaymentPdfDownloadEvent({
    this.remarks,
    this.referenceNo,
    this.date,
    this.serviceCharge,
    this.txnAmount,
    this.status,
    this.transactionId,
    this.shouldOpen = false,
  });
}

class GetAccountNameFTEvent extends AccountEvent{
  final String? messageType;
  final String? accountNo;

  GetAccountNameFTEvent({this.messageType, this.accountNo});
}

class GetTxnCategoryFTEvent extends AccountEvent {
  final String? messageType;
  final String? channelType;

  GetTxnCategoryFTEvent({this.channelType,this.messageType});
}

class GetSavedPayeesForFTEvent extends AccountEvent {}

class GetBankBranchEvent extends AccountEvent {
  final String bankCode;

  GetBankBranchEvent({required this.bankCode});
}
