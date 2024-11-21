
import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../../data/models/responses/account_inquiry_response.dart';

import '../../../data/models/responses/fund_transfer_payee_list_response.dart';
import '../../../data/models/responses/get_user_inst_response.dart';
import '../../../data/models/responses/qr_payment_response.dart';
import '../../../data/models/responses/settings_tran_limit_response.dart';
import '../base_state.dart';

abstract class AccountState extends BaseState<AccountState> {}

class InitialAccountState extends AccountState {}

class AccountInquirySuccessState extends AccountState {
  final List<Account>? data;

  AccountInquirySuccessState({this.data});
}

class AccountInquiryFailState extends AccountState {
  final String? errorMessage;

  AccountInquiryFailState({this.errorMessage});
}

class BalanceInquirySuccessState extends AccountState {
  final double? balance;
  final String? accountNumber;

  BalanceInquirySuccessState({this.balance, this.accountNumber});
}

class BalanceInquiryFailState extends AccountState {
  final String? errorMessage;

  BalanceInquiryFailState({this.errorMessage});
}

class GetUserInstrumentSuccessState extends AccountState {
  final List<UserInstruments>? getUserInstList;

  GetUserInstrumentSuccessState({this.getUserInstList});
}

class GetUserInstrumentFailedState extends AccountState {
  final String? message;

  GetUserInstrumentFailedState({this.message});
}

/// get tran limit for FT
class GetTransLimitForFTSuccessState extends AccountState {
  final List<TranLimitDetails>? tranLimitDetails;
  final String? code;
  final String? message;

  GetTransLimitForFTSuccessState({this.tranLimitDetails , this.code , this.message});
}

class GetTransLimitForFTFailedState extends AccountState {
  final String? message;

  GetTransLimitForFTFailedState({this.message});
}


///get portfolio accounts for FT
class PortfolioAccountDetailsSuccessState extends AccountState {
  final AccountDetailsResponseDtos? accDetails;

  PortfolioAccountDetailsSuccessState({
    this.accDetails,
  });
}


class AccountDetailFailState extends AccountState {
  final String? errorMessage;

  AccountDetailFailState({this.errorMessage});
}

///biometric for FT
class BiometricPromptFor2FASuccessState extends AccountState{}

///account name for FT
class FtGetNameSuccessState extends AccountState {
  final String? acctName;

  FtGetNameSuccessState({this.acctName});
}


class FtGetNameFailState extends AccountState {
  final String? errorMessage;
  final String? errorCode;

  FtGetNameFailState({this.errorMessage,this.errorCode});
}

class QRPaymentSuccessState extends AccountState{
  final QrPaymentResponse? qrPaymentResponse;
  QRPaymentSuccessState({this.qrPaymentResponse});
}

class QRPaymentFailState extends AccountState{
  final String? errorMessage;
  final String? errorCode;
  final QrPaymentResponse? qrPaymentResponse;

  QRPaymentFailState({this.errorMessage,this.errorCode,this.qrPaymentResponse});
}

class QrPaymentPdfDownloadSuccessState extends AccountState {
  final String? document;
  final bool? shouldOpen;

  QrPaymentPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class QrPaymentPdfDownloadFailedState extends AccountState {
  final String? message;

  QrPaymentPdfDownloadFailedState({this.message});
}

///get categorylist
class GetTxnCategoryFTSuccessState<T> extends AccountState {
  final T data;

  GetTxnCategoryFTSuccessState({required this.data});
}

class GetTxnCategoryFTFailState extends AccountState {
  final String? message;

  GetTxnCategoryFTFailState({this.message});
}

///get payee list
class GetSavedPayeesForFTSuccessState extends AccountState {
  final List<PayeeResponseData>? savedPayees;

  GetSavedPayeesForFTSuccessState({this.savedPayees,});
}

class GetSavedPayeeForFTFailedState extends AccountState {
  final String? message;

  GetSavedPayeeForFTFailedState({this.message});
}

///get branch list
class GetbranchSuccessState<T> extends AccountState {
  final T data;

  GetbranchSuccessState({required this.data});
}

class GetbranchFailState extends AccountState {
  final String? message;

  GetbranchFailState({this.message});
}