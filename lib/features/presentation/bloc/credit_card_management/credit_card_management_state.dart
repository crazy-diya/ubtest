part of 'credit_card_management_bloc.dart';

abstract class CreditCardManagementState
    extends BaseState<CreditCardManagementState> {}

class CreditCardManagementInitial extends CreditCardManagementState {}

class PortfolioAccountDetailsCreditCardSuccessState
    extends CreditCardManagementState {
  final AccountDetailsResponseDtos? accDetails;

  PortfolioAccountDetailsCreditCardSuccessState({
    this.accDetails,
  });
}

class PortfolioAccountDetailsCreditCardFailState
    extends CreditCardManagementState {
  final String? errorMessage;

  PortfolioAccountDetailsCreditCardFailState({this.errorMessage});
}

class GetCardListLoadedState extends CreditCardManagementState {
  final CardListResponse? cardListResponse;
  final String? resCode;
  final String? resDescription;
  GetCardListLoadedState({this.cardListResponse , this.resCode , this.resDescription});
}

class GetCardListFailedState extends CreditCardManagementState {
  final String? message;
  GetCardListFailedState({this.message});
}

class GetCardDetailsSuccessState extends CreditCardManagementState {
  final CardDetailsResponse? cardDetailsResponse;
  final String? resCode;
  final String? resDescription;
  GetCardDetailsSuccessState({this.cardDetailsResponse , this.resCode , this.resDescription});
}

class GetCardDetailsFailedState extends CreditCardManagementState {
  final String? message;
  GetCardDetailsFailedState({this.message});
}

class GetCardActivationSuccessState extends CreditCardManagementState {
  final String? message;
  GetCardActivationSuccessState({this.message});
}

class GetCardActivationFailedState extends CreditCardManagementState {
  final String? message;
  GetCardActivationFailedState({this.message});
}

class GetCardCreditLimitSuccessState extends CreditCardManagementState {
  final CardCreditLimitResponse? cardCreditLimitResponse;
  final String? resCode;
  final String? resDescription;
  GetCardCreditLimitSuccessState({this.cardCreditLimitResponse , this.resCode , this.resDescription});
}

class GetCardCreditLimitFailedState extends CreditCardManagementState {
  final String? message;
  GetCardCreditLimitFailedState({this.message});
}

class GetCardEStatementSuccessState extends CreditCardManagementState {
  final CardEStatementResponse? cardEStatementResponse;
  final String? resCode;
  final String? resDescription;
  GetCardEStatementSuccessState({this.cardEStatementResponse , this.resCode , this.resDescription});
}

class GetCardEStatementFailedState extends CreditCardManagementState {
  final String? message;
  GetCardEStatementFailedState({this.message});
}

class GetCardLastStatementSuccessState extends CreditCardManagementState {
  final CardLastStatementResponse? cardLastStatementResponse;
  GetCardLastStatementSuccessState({this.cardLastStatementResponse});
}

class GetCardLastStatementFailedState extends CreditCardManagementState {
  final String? message;
  GetCardLastStatementFailedState({this.message});
}

class GetCardLostStolenSuccessState extends CreditCardManagementState {
  final CardLostStolenResponse? cardLostStolenResponse;
  final String? resCode;
  final String? resDescription;
  GetCardLostStolenSuccessState({this.cardLostStolenResponse , this.resCode , this.resDescription});
}

class GetCardLostStolenFailedState extends CreditCardManagementState {
  final String? message;
  GetCardLostStolenFailedState({this.message});
}

class GetCardPinSuccessState extends CreditCardManagementState {
  final CardPinResponse? cardPinResponse;
  final String? resCode;
  final String? resDescription;
  GetCardPinSuccessState({this.cardPinResponse , this.resCode , this.resDescription});
}

class GetCardPinFailedState extends CreditCardManagementState {
  final String? message;
  GetCardPinFailedState({this.message});
}

class GetCardTxnHistorySuccessState extends CreditCardManagementState {
  final CardTxnHistoryResponse? cardTxnHistoryResponse;
  GetCardTxnHistorySuccessState({this.cardTxnHistoryResponse});
}

class GetCardTxnHistoryFailedState extends CreditCardManagementState {
  final String? message;
  GetCardTxnHistoryFailedState({this.message});
}

class GetCardViewStatementSuccessState extends CreditCardManagementState {
  final CardViewStatementResponse? cardViewStatementResponse;
  GetCardViewStatementSuccessState({this.cardViewStatementResponse});
}

class GetCardViewStatementFailedState extends CreditCardManagementState {
  final String? message;
  GetCardViewStatementFailedState({this.message});
}

class GetPayeeBranchSuccessStateForCard<T> extends CreditCardManagementState {
  final T data;

  GetPayeeBranchSuccessStateForCard({required this.data});
}

class GetPayeeBranchFaildStateForCard extends CreditCardManagementState {
  final String? message;

  GetPayeeBranchFaildStateForCard({this.message});
}

class GetCardLoyaltyVouchersLoadedState extends CreditCardManagementState {
  final CardLoyaltyVouchersResponse? cardLoyaltyVouchersResponse;
  GetCardLoyaltyVouchersLoadedState({this.cardLoyaltyVouchersResponse});
}

class GetCardLoyaltyRedeemSuccessState extends CreditCardManagementState {
  final CardLoyaltyRedeemResponse? cardLoyaltyRedeemResponse;
  GetCardLoyaltyRedeemSuccessState({this.cardLoyaltyRedeemResponse});
}

class GetCardLoyaltyRedeemFailedState extends CreditCardManagementState {
  final String? message;
  GetCardLoyaltyRedeemFailedState({this.message});
}

/// get tran limit for Card
class GetTransLimitForCardSuccessState extends CreditCardManagementState {
  final List<TranLimitDetails>? tranLimitDetails;
  final String? code;
  final String? message;

  GetTransLimitForCardSuccessState({this.tranLimitDetails , this.code , this.message});
}

class GetTransLimitForCardFailedState extends CreditCardManagementState {
  final String? message;

  GetTransLimitForCardFailedState({this.message});
}

class BiometricPromptFor2FACardSuccessState extends CreditCardManagementState{}

///get user instruments
class GetUserInstrumentForCardSuccessState extends CreditCardManagementState {
  final List<UserInstruments>? getUserInstList;

  GetUserInstrumentForCardSuccessState({this.getUserInstList});
}

class GetUserInstrumentForCardFailedState extends CreditCardManagementState {
  final String? message;

  GetUserInstrumentForCardFailedState({this.message});
}

///download card history report
class CCTransactionPdfDownloadSuccessState extends CreditCardManagementState {
  final String? document;
  final bool? shouldOpen;

  CCTransactionPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class CCTransactionPdfDownloadFailedState extends CreditCardManagementState {
  final String? message;

  CCTransactionPdfDownloadFailedState({this.message});
}

///download card history excel report
class CCTransactionExcelDownloadSuccessState extends CreditCardManagementState {
  final String? document;
  final bool? shouldOpen;

  CCTransactionExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class CCTransactionExcelDownloadFailedState extends CreditCardManagementState {
  final String? message;

  CCTransactionExcelDownloadFailedState({this.message});
}
