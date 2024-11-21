import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/common/justpay_payload.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_terms_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_user_inst_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/just_pay_challenge_id_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/portfolio_lease_details_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/portfolio_userfd_details_response.dart';
import '../../../data/models/responses/account_details_response_dtos.dart';

import '../../../data/models/responses/account_statements_response.dart';
import '../../../data/models/responses/account_transaction_history_response.dart';
import '../../../data/models/responses/card_management/card_list_response.dart';
import '../../../data/models/responses/lease_payment_history_response.dart';
import '../../../data/models/responses/loan_history_response.dart';
import '../../../data/models/responses/past_card_statement_response.dart';
import '../../../data/models/responses/portfolio_cc_details_response.dart';
import '../../../data/models/responses/portfolio_loan_details_response.dart';
import '../../../data/models/responses/promotions_response.dart';
import '../../../data/models/responses/retrieve_profile_image_response.dart';
import '../../../data/models/responses/transcation_details_response.dart';
import '../base_state.dart';

abstract class PortfolioState extends BaseState<PortfolioState> {}

class InitialPortfolioState extends PortfolioState {}

class EditNickNameSuccessState extends PortfolioState {
  final String? message;

  EditNickNameSuccessState({
    this.message,
  });
}

class EditNickNameFailState extends PortfolioState {
  final String? errorMessage;

  EditNickNameFailState({
    this.errorMessage,
  });
}


class AccountDetailsSuccessState extends PortfolioState {
  final AccountDetailsResponseDtos? accDetails;

  AccountDetailsSuccessState({
    this.accDetails,
  });
}


class AccountDetailFailState extends PortfolioState {
  final String? errorMessage;

  AccountDetailFailState({this.errorMessage});
}

class CCDetailsSuccessState extends PortfolioState {
  final PortfolioCcDetailsResponse? portfolioCcDetailsResponse;

  CCDetailsSuccessState({this.portfolioCcDetailsResponse});
}

class GetCreditCardSuccessState extends PortfolioState {
  final CardListResponse? cardListResponse;
  final String? resCode;
  final String? resDescription;
  GetCreditCardSuccessState({this.cardListResponse , this.resCode , this.resDescription});
}

class GetCreditCardListFailedState extends PortfolioState {
  final String? message;
  GetCreditCardListFailedState({this.message});
}


class LoanDetailsSuccessState extends PortfolioState {
  final PortfolioLoanDetailsResponse? portfolioLoanDetailsResponse;

  LoanDetailsSuccessState({this.portfolioLoanDetailsResponse});
}

class LeaseDetailsSuccessState extends PortfolioState {
  final PortfolioLeaseDetailsResponse? portfolioLeaseDetailsResponse;

  LeaseDetailsSuccessState({this.portfolioLeaseDetailsResponse});
}

class FDDetailsSuccessState extends PortfolioState {
  final PortfolioUserFdDetailsResponse? portfolioUserFdDetailsResponse;

  FDDetailsSuccessState({this.portfolioUserFdDetailsResponse});
}

class HomeTransactionDetailsFailedState extends PortfolioState {
  final String? message;
  final String? code;

  HomeTransactionDetailsFailedState({this.message, this.code});
}

class HomeTransactionDetailsSuccessState extends PortfolioState {
  final List<TxnDetailList>? txnDetailList;
  final int? count;
  final String? message;

  HomeTransactionDetailsSuccessState({
    this.txnDetailList,
    this.count,
    this.message,
  });
}

class CCDetailsFailState extends PortfolioState {
  final String? errorMessage;

  CCDetailsFailState({this.errorMessage});
}

class HomePromotionsSuccessState extends PortfolioState {
  final List<PromotionList>? promotions;

  HomePromotionsSuccessState({this.promotions});
}

class HomePromotionsFailedState extends PortfolioState {
  String? message;

  HomePromotionsFailedState({this.message});
}

class PastCardStatementsSuccessState extends PortfolioState {
  final List<PrimaryTxnDetail>? statements;

  PastCardStatementsSuccessState({this.statements});
}

class PastCardStatementsFailedState extends PortfolioState {
  String? message;
  String? errorCode;

  PastCardStatementsFailedState({this.message, this.errorCode});
}



class LoanHistorySuccessState extends PortfolioState {
  final int? count;
  final List<LoanHistoryResponseDto>? history;

  LoanHistorySuccessState({this.history,this.count});
}

class LoanHistoryFailedState extends PortfolioState {
  String? message;

  LoanHistoryFailedState({this.message});
}

class LeaseHistorySuccessState extends PortfolioState {
  final List<LeaseHistoryResponseDto>? leaseHistory;
  final int? count;

  LeaseHistorySuccessState({this.leaseHistory,this.count});
}

class LeaseHistoryFailedState extends PortfolioState {
  String? message;

  LeaseHistoryFailedState({this.message});
}


class AccountStatementsSuccessState extends PortfolioState {
  final List<StatementResponseDto>? accStatements;
  final int? count;
  final double? totalCreditAmount;
  final double? totalDebitAmount;
  final DateTime? firstTxnDate;
  final DateTime? lastTxnDate;


  AccountStatementsSuccessState({this.accStatements,this.firstTxnDate,this.lastTxnDate,this.count,this.totalCreditAmount,this.totalDebitAmount});
}

class AccountStatementsFailedState extends PortfolioState {
  String? message;

  AccountStatementsFailedState({this.message});
}

class AccountTransactionsSuccessState extends PortfolioState {
  final List<RecentTransactionList>? accountTransactions;
  final int? count;
  final double? totalCreditAmount;
  final double? totalDebitAmount;


  AccountTransactionsSuccessState({this.accountTransactions,this.count,this.totalCreditAmount,this.totalDebitAmount});
}

class AccountTransactionsFailedState extends PortfolioState {
  String? message;

  AccountTransactionsFailedState({this.message});
}

class AccountStatementsPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountStatementsPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountStatementsPdfDownloadFailedState extends PortfolioState {
  final String? message;

  AccountStatementsPdfDownloadFailedState({this.message});
}

///Past card statement pdf
class CardSTPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  CardSTPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class CardSTPdfDownloadFailedState extends PortfolioState {
  final String? message;

  CardSTPdfDownloadFailedState({this.message});
}



class LeaseHistoryExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  LeaseHistoryExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class LeaseHistoryExcelDownloadFailedState extends PortfolioState {
  final String? message;

  LeaseHistoryExcelDownloadFailedState({this.message});
}



class LeaseHistoryPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  LeaseHistoryPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class LeaseHistoryPdfDownloadFailedState extends PortfolioState {
  final String? message;

  LeaseHistoryPdfDownloadFailedState({this.message});
}



class LoanHistoryExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  LoanHistoryExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class LoanHistoryExcelDownloadFailedState extends PortfolioState {
  final String? message;

  LoanHistoryExcelDownloadFailedState({this.message});
}




class AccountTransactionExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountTransactionExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountTransactionExcelDownloadFailedState extends PortfolioState {
  final String? message;

  AccountTransactionExcelDownloadFailedState({this.message});
}



class CardTransactionExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  CardTransactionExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class CardTransactionExcelDownloadFailedState extends PortfolioState {
  final String? message;

  CardTransactionExcelDownloadFailedState({this.message});
}

class CardTransactionPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  CardTransactionPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class CardTransactionPdfDownloadFailedState extends PortfolioState {
  final String? message;

  CardTransactionPdfDownloadFailedState({this.message});
}

class AccountTransactionStatusExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountTransactionStatusExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountTransactionStatusExcelDownloadFailedState extends PortfolioState {
  final String? message;

  AccountTransactionStatusExcelDownloadFailedState({this.message});
}


class AccountTransactionStatusPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountTransactionStatusPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountTransactionStatusPdfDownloadFailedState extends PortfolioState {
  final String? message;

  AccountTransactionStatusPdfDownloadFailedState({this.message});
}




class AccountTransactionPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountTransactionPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountTransactionPdfDownloadFailedState extends PortfolioState {
  final String? message;

  AccountTransactionPdfDownloadFailedState({this.message});
}

class AccountSatementsXcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountSatementsXcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountSatementsXcelDownloadFailedState extends PortfolioState {
  final String? message;

  AccountSatementsXcelDownloadFailedState({this.message});
}

class LoanHistoryPdDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  LoanHistoryPdDownloadSuccessState({this.document,this.shouldOpen,});
}

class LoanHistoryPdDownloadFailedState extends PortfolioState {
  final String? message;

  LoanHistoryPdDownloadFailedState({this.message});
}

class PastCardExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  PastCardExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class   PastCardExcelDownloadFailedState extends PortfolioState {
  final String? message;

  PastCardExcelDownloadFailedState({this.message});
}

class PastCardStatementsPdfDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  PastCardStatementsPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class PastCardStatementsPdfDownloadFailedState extends PortfolioState {
  final String? message;

  PastCardStatementsPdfDownloadFailedState({this.message});
}

class AccountSatementsExcelDownloadSuccessState extends PortfolioState {
  final String? document;
  final bool? shouldOpen;

  AccountSatementsExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class AccountSatementsExcelDownloadFailedState extends PortfolioState {
  final String? message;

  AccountSatementsExcelDownloadFailedState({this.message});
}

class GetProfileImageFailState extends PortfolioState{
  final String? message;

  GetProfileImageFailState({this.message});
}

class GetProfileImageSuccessState extends PortfolioState{
  final RetrieveProfileImageResponse? retrieveProfileImageResponse;
  GetProfileImageSuccessState({this.retrieveProfileImageResponse});
}
class GetMailCountFailedState extends PortfolioState {
  final String? message;
  final String? responseCode;

  GetMailCountFailedState({
    this.message,
    this.responseCode,
  });
}

class GetMailCountSuccessState extends PortfolioState {
  final MailCountResponse? mailCountResponse;

  GetMailCountSuccessState({this.mailCountResponse});
}

///notification count
class CountNotificationForHomeSuccessState extends PortfolioState {
  final int? allNotificationCount;
  final int? promoNotificationCount;
  final int? tranNotificationCount;
  final int? noticesNotificationCount;

  CountNotificationForHomeSuccessState(
      {
        this.allNotificationCount,
        this.promoNotificationCount,
        this.tranNotificationCount,
        this.noticesNotificationCount});
}

class CountNotificationForHomeFailedState extends PortfolioState {
  final String? message;

  CountNotificationForHomeFailedState({this.message});
}
class GetPaymentInstrumentPortfolioSuccessState extends PortfolioState {
  final List<UserInstruments>? getUserInstList;

  GetPaymentInstrumentPortfolioSuccessState({this.getUserInstList});
}
class GetPaymentInstrumentPortfolioFailedState extends PortfolioState {
  final String? message;

  GetPaymentInstrumentPortfolioFailedState({this.message});
}

/* -------------------------------- T&C STATE ------------------------------- */

class JustpayTermsLoadedState extends PortfolioState {
  final TermsData? termsData;

  JustpayTermsLoadedState({this.termsData});
}

class JustpayTermsSubmittedState extends PortfolioState {

}

class JustpayTermsFailedState extends PortfolioState {
  final String? message;

  JustpayTermsFailedState({this.message});
}


/* --------------------------------- Justpay -------------------------------- */

class JustPayHomeChallengeIdSuccessState extends PortfolioState {
  final JustPayChallengeIdResponse? justPayChallengeIdResponse;

  JustPayHomeChallengeIdSuccessState({this.justPayChallengeIdResponse});
}

class JustPayHomeChallengeIdFailedState extends PortfolioState {
  final String? message;

  JustPayHomeChallengeIdFailedState({this.message});
}


class JustPayHomeTCSignSuccessState extends PortfolioState {
  final BaseResponse? justPayTCSignResponse;

  JustPayHomeTCSignSuccessState({this.justPayTCSignResponse});
}

class JustPayHomeTCSignFailedState extends PortfolioState {
  final String? message;

  JustPayHomeTCSignFailedState({this.message});
}


class JustPayHomeSDKCreateIdentitySuccessState extends PortfolioState {
  final JustPayPayload? justPayPayload;

  JustPayHomeSDKCreateIdentitySuccessState({this.justPayPayload});
}

class JustPayHomeSDKCreateIdentityFailedState extends PortfolioState {
  final String? message;

  JustPayHomeSDKCreateIdentityFailedState({this.message});
}

class JustPayHomeSDKTCSignSuccessState extends PortfolioState {
  final JustPayPayload? justPayPayload;

  JustPayHomeSDKTCSignSuccessState({this.justPayPayload});
}

class JustPayHomeSDKTCSignFailedState extends PortfolioState {
  final String? message;

  JustPayHomeSDKTCSignFailedState({this.message});
}

