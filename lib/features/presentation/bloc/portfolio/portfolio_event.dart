import '../base_event.dart';

abstract class PortfolioEvent extends BaseEvent {}

class GetAccDetailsEvent extends PortfolioEvent {}

class GetCCDetailsEvent extends PortfolioEvent {}

class GetCreditCardEvent extends PortfolioEvent {}

class GetLoanDetailsEvent extends PortfolioEvent {}

class GetLeaseDetailsEvent extends PortfolioEvent {}

class GetHomeTransactionDetailsEvent extends PortfolioEvent {
  final int? page;
  final int? size;

  GetHomeTransactionDetailsEvent({this.page, this.size});
}

class GetFDDetailsEvent extends PortfolioEvent {}

class GetHomePromotionsEvent extends PortfolioEvent {}

class GetPastCardStatementsEvent extends PortfolioEvent {}

class EditNicknameEvent extends PortfolioEvent {
  final String? nickName;
  final String? messageType;
  final int? instrumentId;
  final String? instrumentType;


  EditNicknameEvent( {this.instrumentType,this.nickName, this.messageType, this.instrumentId});
}

class PastCardStatementEvent extends PortfolioEvent {
  final String? messageType;
  final String? maskedPrimaryCardNumber;
  final String? billMonth;

  PastCardStatementEvent({this.messageType, this.maskedPrimaryCardNumber, this.billMonth});
}

class LoanHistoryEvent extends PortfolioEvent {
  final String accountNo;

  final String messageType;
  final int page;
  final int size;

  LoanHistoryEvent(
      {required this.accountNo,
      required this.messageType,
      required this.page,
      required this.size});
}

class AccountTransactionsEvent extends PortfolioEvent {
  final String accountNo;
  final String accountType;

  final String messageType;
  final int page;
  final int size;

  AccountTransactionsEvent(
      {required this.accountNo,
      required this.accountType,
      required this.messageType,
      required this.page,
      required this.size});
}

class AccountStatementsEvent extends PortfolioEvent {
  final String accountNo;
  final String? fromDate;
  final String? toDate;
  final int? fromAmount;
  final int? toAmount;
  final String? status;
  final String? accountType;

  final String messageType;
  final int page;
  final int size;
  final int? count;

  AccountStatementsEvent(
      {required this.accountNo,
      required this.messageType,
      required this.page,
      required this.size,
      this.fromDate,
      this.toDate,
      this.fromAmount,
      this.toAmount,
      this.status,
      this.count,this. accountType});
}

class LeaseHistoryEvent extends PortfolioEvent {
  final String accountNo;

  final String messageType;
  final int page;
  final int size;

  LeaseHistoryEvent(
      {required this.accountNo,
      required this.messageType,
      required this.page,
      required this.size});
}

class AccountStatementsPdfDownloadEvent extends PortfolioEvent {
  final String? accountNo;

  final String? fromDate;
  final String? accountType;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;
  final String? status;
  final int? page;
  final int? size;
  final bool? shouldOpen;

  AccountStatementsPdfDownloadEvent({
    this.accountNo,
    this.accountType,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.status,
    this.page,
    this.size,
    this.shouldOpen = false,
  });
}

class LoanHistoryExcelDownloadEvent extends PortfolioEvent {
  final String? loanNumber;

  final bool? shouldOpen;

  LoanHistoryExcelDownloadEvent({
    this.loanNumber,
    this.shouldOpen = false,
  });
}

class LeaseHistoryPdfDownloadEvent extends PortfolioEvent {
  final String? leaseNumber;

  final bool? shouldOpen;

  LeaseHistoryPdfDownloadEvent({
    this.leaseNumber,
    this.shouldOpen = false,
  });
}

class LeaseHistoryExcelDownloadEvent extends PortfolioEvent {
  final String? leaseNumber;

  final bool? shouldOpen;

  LeaseHistoryExcelDownloadEvent({
    this.leaseNumber,
    this.shouldOpen = false,
  });
}

class AccountTransactionExcelDownloadEvent extends PortfolioEvent {
  final String? accountNumber;
  final String? accountType;

  final bool? shouldOpen;

  AccountTransactionExcelDownloadEvent({
    this.accountNumber,
    this.accountType,
    this.shouldOpen = false,
  });
}

class CardTransactionPdfDownloadEvent extends PortfolioEvent {
  final String? cardNumber;

  final bool? shouldOpen;

  CardTransactionPdfDownloadEvent({
    this.cardNumber,
    this.shouldOpen = false,
  });
}

class CardTransactionExcelDownloadEvent extends PortfolioEvent {
  final String? cardNumber;

  final bool? shouldOpen;

  CardTransactionExcelDownloadEvent({
    this.cardNumber,
    this.shouldOpen = false,
  });
}

class AccountTransactionPdfDownloadEvent extends PortfolioEvent {
  final String? accountNumber;
  final String? accountType;

  final bool? shouldOpen;

  AccountTransactionPdfDownloadEvent({
    this.accountNumber,
    this.accountType,
    this.shouldOpen = false,
  });
}

class AccountTransactionStatusPdfDownloadEvent extends PortfolioEvent {
  final String? paidFromAccountName;
  final String? paidFromAccountNo;
  final String? paidToAccountName;
  final String? paidToAccountNo;
  final String? amount;
  final String? serviceCharge;
  final String? transactionCategory;
  final String? remarks;
  final String? beneficiaryEmail;
  final String? beneficiaryMobileNo;
  final String? dateAndTime;
  final String? referenceId;

  final bool? shouldOpen;

  AccountTransactionStatusPdfDownloadEvent({
    this.paidFromAccountName,
    this.paidFromAccountNo,
    this.paidToAccountName,
    this.paidToAccountNo,
    this.amount,
    this.serviceCharge,
    this.transactionCategory,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobileNo,
    this.dateAndTime,
    this.referenceId,
    this.shouldOpen = false,
  });
}

class AccountTransactionStatusExcelDownloadEvent extends PortfolioEvent {
  final String? paidFromAccountName;
  final String? paidFromAccountNo;
  final String? paidToAccountName;
  final String? paidToAccountNo;
  final String? amount;
  final String? serviceCharge;
  final String? transactionCategory;
  final String? remarks;
  final String? beneficiaryEmail;
  final String? beneficiaryMobileNo;
  final String? dateAndTime;
  final String? referenceId;

  final bool? shouldOpen;

  AccountTransactionStatusExcelDownloadEvent({
    this.paidFromAccountName,
    this.paidFromAccountNo,
    this.paidToAccountName,
    this.paidToAccountNo,
    this.amount,
    this.serviceCharge,
    this.transactionCategory,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobileNo,
    this.dateAndTime,
    this.referenceId,
    this.shouldOpen = false,
  });
}

class AccountSatementsXcelDownloadEvent extends PortfolioEvent {
  final String? accountNo;
  final String? accountType;

  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;
  final String? status;
  final int? page;
  final int? size;
  final bool? shouldOpen;

  AccountSatementsXcelDownloadEvent({
    this.accountNo,
    this.accountType,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.status,
    this.page,
    this.size,
    this.shouldOpen = false,
  });
}

class LoanHistoryPdfDownloadEvent extends PortfolioEvent {
  final String? accountNumber;

  final bool? shouldOpen;

  LoanHistoryPdfDownloadEvent({
    this.accountNumber,
    this.shouldOpen = false,
  });
}

class PastCardExcelDownloadEvent extends PortfolioEvent {
  final String? maskedPrimaryCardNumber;
  final String? billMonth;
  final bool? shouldOpen;

  PastCardExcelDownloadEvent({
    this.maskedPrimaryCardNumber,
    this.billMonth,
    this.shouldOpen = false,
  });
}

class PastCardStatementsPdfDownloadEvent extends PortfolioEvent {
  final int? year;
  final int? month;
  final bool? shouldOpen;

  PastCardStatementsPdfDownloadEvent({
    this.year,
    this.month,
    this.shouldOpen = false,
  });
}

class AccountSatementsExcelDownloadEvent extends PortfolioEvent {
  final String? accNum;
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;
  final String? status;

  final bool? shouldOpen;

  AccountSatementsExcelDownloadEvent({
    this.accNum,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.status,
    this.shouldOpen = false,
  });
}


class GetProfileImageEvent extends PortfolioEvent{
  final String imageKey;
  GetProfileImageEvent({required this.imageKey});
}

class GetMailCountEvent extends PortfolioEvent {
  final int? page;
  final int? size;

  GetMailCountEvent({
    this.page,
    this.size,
  });
}

///count notification
class CountNotificationsForHomeEvent extends PortfolioEvent {
  final String? readStatus;
  final String? notificationType;

  CountNotificationsForHomeEvent({this.readStatus, this.notificationType});
}
/// manage other bank view

class GetJustpayInstrumentPortfolioEvent extends PortfolioEvent {
}


///Get JustPay T&C
class GetHomeTermsEvent extends PortfolioEvent {
}

class HomeAcceptTermsEvent extends PortfolioEvent {
  final int? termId;
  final String? acceptedDate;
  final String termType;

  HomeAcceptTermsEvent({this.termId, this.acceptedDate, required this.termType});
}



/* --------------------------------- JustPay -------------------------------- */


class JustPayHomeChallengeIdEvent extends PortfolioEvent {
  final String? challengeReqDeviceId;
  final bool? isOnboarded;

  JustPayHomeChallengeIdEvent({this.challengeReqDeviceId,this.isOnboarded});
}

class JustPayHomeTCSignEvent extends PortfolioEvent {
   final String? challengeId;
    final String? termAndCondition;

  JustPayHomeTCSignEvent(
    {this.challengeId,
    this.termAndCondition}
  );
}

class JustPayHomeSDKCreateIdentityEvent extends PortfolioEvent {
   final String? challengeId;

  JustPayHomeSDKCreateIdentityEvent(
    {this.challengeId,}
  );
}

class JustPayHomeSDKTCSignEvent extends PortfolioEvent {
    final String? termAndCondition;

  JustPayHomeSDKTCSignEvent(
    {
    this.termAndCondition}
  );
}

///Past card Statement download
class CardSTPdfDownloadEvent extends PortfolioEvent {
  final String? billMonth;
  final String? maskedPrimaryCardNumber;
  final bool? shouldOpen;

  CardSTPdfDownloadEvent({
    this.billMonth,
    this.maskedPrimaryCardNumber,
    this.shouldOpen = false,
  });
}

