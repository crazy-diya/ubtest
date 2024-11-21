

import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/fund_transfer_scheduling_response.dart';
import '../../../data/models/responses/get_all_sheduke_ft_response.dart';
import '../../../data/models/responses/get_user_inst_response.dart';
import '../../../data/models/responses/intra_fund_transfer_response.dart';

import '../../../data/models/responses/mobile_login_response.dart';
import '../../../data/models/responses/transaction_limit_response.dart';
import '../base_state.dart';

abstract class FundTransferState extends BaseState<FundTransferState> {}

class InitialFundTransferState extends FundTransferState {}

/// Intra Fund Transfer
class IntraFundTransferSuccessState extends FundTransferState {
  final IntraFundTransferResponse? intraFundTransferResponse;
  final String? responseDescription;

  IntraFundTransferSuccessState({
    this.intraFundTransferResponse,
    this.responseDescription,
  });
}

class IntraFundTransferFailedState extends FundTransferState {
  final String? message;
  final String? code;
  final String? transactionReferenceNumber;

  IntraFundTransferFailedState({this.message,this.code,this.transactionReferenceNumber});
}

/// One Time Fund Transfer
class OneTimeFundTransferSuccessState extends FundTransferState {
  OneTimeFundTransferSuccessState();
}

class OneTimeFundTransferFailedState extends FundTransferState {
  final String? message;

  OneTimeFundTransferFailedState({this.message});
}

/// Scheduling Fund Transfer
class SchedulingFundTransferSuccessState extends FundTransferState {
  SchedulingFundTransferResponse? schedulingFundTransferResponse;
  SchedulingFundTransferSuccessState({this.schedulingFundTransferResponse,});
}

class SchedulingFundTransferFailedState extends FundTransferState {
  final String? message;
  final String? code;

  SchedulingFundTransferFailedState({this.message,this.code});
}

/// Scheduling Bill Payment
// class SchedulingBillPaymentSuccessState extends FundTransferState {
//   ScheduleBillPaymentResponse? scheduleBillPaymentResponse;
//   SchedulingBillPaymentSuccessState({this.scheduleBillPaymentResponse,});
// }

// class SchedulingBillPaymentFailedState extends FundTransferState {
//   final String? message;
//   final String? code;

//   SchedulingBillPaymentFailedState({this.message,this.code});
// }

/// Transaction Limit

class TransactionLimitSuccessState extends FundTransferState {
  final List<TxnLimitDetail>? txnLimitDetail;
  final int? count;

  TransactionLimitSuccessState({
    this.txnLimitDetail,
    this.count,
  });
}

class TransactionLimitFailedState extends FundTransferState {
  final String? message;

  TransactionLimitFailedState({this.message});
}

/// Transaction Limit Add

class TransactionLimitAddSuccessState extends FundTransferState {
  final BaseResponse? baseResponse;

  TransactionLimitAddSuccessState({this.baseResponse});
}

class TransactionLimitAddFailedState extends FundTransferState {
  final String? message;

  TransactionLimitAddFailedState({this.message});
}

///PDF
class FundTransferReceiptDownloadSuccessState extends FundTransferState{
  final String? document;
  final bool? shouldOpen;

  FundTransferReceiptDownloadSuccessState({this.document, this.shouldOpen});
}
 class  FundTransferReceiptDownloadFailedState extends FundTransferState{
   final String? message;

  FundTransferReceiptDownloadFailedState({this.message});
 }

 ///EXCEL
class FundTransferExcelDownloadSuccessState extends FundTransferState{
  final String? document;
  final bool? shouldOpen;

  FundTransferExcelDownloadSuccessState({this.document, this.shouldOpen});
}
class  FundTransferExcelDownloadFailedState extends FundTransferState{
  final String? message;

  FundTransferExcelDownloadFailedState({this.message});
}

 ///Schedule List
class GetAllScheduleFTSuccessState extends FundTransferState{
  final List<ScheduleFtList>? scheduleFtList;

  GetAllScheduleFTSuccessState({this.scheduleFtList});
}
class GetAllScheduleFTFailedState extends FundTransferState{
  final String? errorMessage;

  GetAllScheduleFTFailedState({this.errorMessage});
}


class GetUserInstrumentForTransferSuccessState extends FundTransferState {
  final List<UserInstruments>? getUserInstList;

  GetUserInstrumentForTransferSuccessState({this.getUserInstList});
}

class GetUserInstrumentForTransferFailedState extends FundTransferState {
  final String? message;

  GetUserInstrumentForTransferFailedState({this.message});
}

class AccountInquiryForTransferFailState extends FundTransferState {
  final String? errorMessage;

  AccountInquiryForTransferFailState({this.errorMessage});
}


///get otp for transactions
class OtpForFundTransSuccessState extends FundTransferState {
  final MobileLoginResponse? mobileLoginResponse;
  final String? responseCode;
  final String? responseDescription;

  OtpForFundTransSuccessState({this.mobileLoginResponse, this.responseCode, this.responseDescription});
}

///req money
class ReqMoneyFundTranStatusSuccessState extends FundTransferState {
  final String? id;
  final String? description;

  ReqMoneyFundTranStatusSuccessState({this.id, this.description});
}

class ReqMoneyFundTranStatusFailedState extends FundTransferState {
  final String? message;

  ReqMoneyFundTranStatusFailedState({this.message});
}