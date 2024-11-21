// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'credit_card_management_bloc.dart';

abstract class CreditCardManagementEvent extends BaseEvent {}

class GetPortfolioAccDetailsCreditCardEvent extends CreditCardManagementEvent {}

class GetCardListEvent extends CreditCardManagementEvent {}

class GetCardDetailsEvent extends CreditCardManagementEvent {
  final String? maskedPrimaryCardNumber;

  GetCardDetailsEvent({
    this.maskedPrimaryCardNumber,
  });
}

class GetCardActivationEvent extends CreditCardManagementEvent {
  final String? maskedCardNumber;

  GetCardActivationEvent({
    this.maskedCardNumber,
  });
}

class GetCardCreditLimitEvent extends CreditCardManagementEvent {
  final String? maskedAddonCardNumber;

  final String? addonCrLimitPerc;
  final String? addonCashLimitPerc;
  GetCardCreditLimitEvent({
    this.maskedAddonCardNumber,
    this.addonCrLimitPerc,
    this.addonCashLimitPerc,
  });
}

class GetCardEStatementEvent extends CreditCardManagementEvent {
  final String? maskedPrimaryCardNumber;

  final String? isGreenStatement;
  GetCardEStatementEvent({
    this.maskedPrimaryCardNumber,
    this.isGreenStatement,
  });
}

class GetCardLastStatementEvent extends CreditCardManagementEvent {
  final String? maskedPrimaryCardNumber;

  GetCardLastStatementEvent({
    this.maskedPrimaryCardNumber,
  });
}

class GetCardLostStolenEvent extends CreditCardManagementEvent {
  final String? maskedCardNumber;
  final String? reissueRequest;
  final bool? isBranch;
  final String? branchCode;
  GetCardLostStolenEvent({
    this.maskedCardNumber,
    this.reissueRequest,
    this.branchCode,
    this.isBranch,
  });
}

class GetCardPinEvent extends CreditCardManagementEvent {
  final String? maskedCardNumber;

  final String? pinChangeReason;
  GetCardPinEvent({
    this.maskedCardNumber,
    this.pinChangeReason,
  });
}

class GetCardTxnHistoryEvent extends CreditCardManagementEvent {
  final String? messageType;
  final String? maskedCardNumber;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;
  final int? page;
  final int? size;
  final double? fromAmount;
  final double? toAmount;
  final String? status;
  final String? billingStatus;

  GetCardTxnHistoryEvent(
      {this.messageType,
      this.maskedCardNumber,
      this.txnMonthsFrom,
      this.txnMonthsTo,
      this.page,
      this.size,
      this.fromAmount,
      this.toAmount,
      this.billingStatus,
      this.status});
}

class GetCardViewStatementEvent extends CreditCardManagementEvent {
  final String? maskedPrimaryCardNumber;
  final String? billMonth;
  GetCardViewStatementEvent({
    this.maskedPrimaryCardNumber,
    this.billMonth,
  });
}

class GetPayeeBankBranchEventForCard extends CreditCardManagementEvent {
  final String bankCode;

  GetPayeeBankBranchEventForCard({required this.bankCode});
}

class GetCardLoyaltyVouchersEvent extends CreditCardManagementEvent {}

class GetCardLoyaltyRedeemEvent extends CreditCardManagementEvent {
  String? maskedPrimaryCardNumber;
  String? redeemPoints;
  bool? sendToAddressFlag;
  String? collectBranch;
  List<Map<String, int>>? redeemOptions;

  GetCardLoyaltyRedeemEvent({
    this.maskedPrimaryCardNumber,
    this.redeemPoints,
    this.sendToAddressFlag,
    this.collectBranch,
    this.redeemOptions,
  });
}

///get tran limits
class GetTranLimitForCardEvent extends CreditCardManagementEvent {
}

class RequestBiometricPrompt2FACardEvent extends CreditCardManagementEvent {}

/// Get User Instrument
class GetUserInstrumentForCardEvent extends CreditCardManagementEvent {
  final String? requestType;

  GetUserInstrumentForCardEvent({
    this.requestType,
  });
}

///download credit card pdf report
class CCTransactionPdfDownloadEvent extends CreditCardManagementEvent {
  final String? messageType;
  final String? maskedCardNumber;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;
  final double? fromAmount;
  final double? toAmount;
  final String? status;
  final String? billingStatus;
  final bool? shouldOpen;

  CCTransactionPdfDownloadEvent(
      {this.messageType,
      this.maskedCardNumber,
      this.txnMonthsFrom,
      this.txnMonthsTo,
      this.fromAmount,
      this.toAmount,
      this.status,
      this.billingStatus,
      this.shouldOpen = false});
}

///download credit card excel report
class CCTransactionExcelDownloadEvent extends CreditCardManagementEvent {
  final String? messageType;
  final String? maskedCardNumber;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;
  final double? fromAmount;
  final double? toAmount;
  final String? status;
  final String? billingStatus;
  final bool? shouldOpen;

  CCTransactionExcelDownloadEvent(
      {this.messageType,
      this.maskedCardNumber,
      this.txnMonthsFrom,
      this.txnMonthsTo,
      this.fromAmount,
      this.toAmount,
      this.status,
      this.billingStatus,
      this.shouldOpen = false});
}
