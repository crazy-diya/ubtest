

import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../../data/models/responses/cheque_book_filter_response.dart';
import '../../../data/models/responses/credit_card_req_field_data_response.dart';
import '../../../data/models/responses/debit_card_req_field_data_response.dart';
import '../../../data/models/responses/lease_req_field_data_response.dart';
import '../../../data/models/responses/loan_req_field_data_response.dart';
import '../../../data/models/responses/loan_request_submit_response.dart';
import '../../../data/models/responses/loan_requests_field_data_response.dart';
import '../../../data/models/responses/service_req_filted_list_response.dart';
import '../../../data/models/responses/service_req_history_response.dart';
import '../../../data/models/responses/sr_service_charge_response.dart';
import '../../../data/models/responses/sr_statement_history_response.dart';
import '../base_state.dart';

abstract class ServiceRequestsState extends BaseState<ServiceRequestsState> {}

class InitialServiceRequestsState extends ServiceRequestsState {}

class LoanReqFieldDataSuccessState extends ServiceRequestsState {
  final LoanRequestFieldDataResponse? loanRequestFieldDataResponse;

  LoanReqFieldDataSuccessState({this.loanRequestFieldDataResponse});
}

class LoanReqFieldDataFailedState extends ServiceRequestsState {
  final String? message;

  LoanReqFieldDataFailedState({this.message});
}

class LoanReqSaveDataSuccessState extends ServiceRequestsState {
  final LoanRequestsSubmitResponse? loanRequestsSubmitResponse;

  LoanReqSaveDataSuccessState({this.loanRequestsSubmitResponse});
}

class LoanReqSavedDataFailedState extends ServiceRequestsState {
  final String? message;

  LoanReqSavedDataFailedState({this.message});
}
/// C card
class CreditCardReqFieldDataSuccessState extends ServiceRequestsState {
  final CreditCardReqFieldDataResponse? creditCardReqFieldDataResponse;

  CreditCardReqFieldDataSuccessState({this.creditCardReqFieldDataResponse});
}

class CreditCardReqFieldDataFailedState extends ServiceRequestsState {
  final String? message;

  CreditCardReqFieldDataFailedState({this.message});
}

class CreditCardReqSaveSuccessState extends ServiceRequestsState {
  final String? message;

  CreditCardReqSaveSuccessState({this.message});
}

class CreditCardReqSaveFailedState extends ServiceRequestsState {
  final String? message;
  final String? code;

  CreditCardReqSaveFailedState({this.message,this.code});
}

class LeaseReqFieldDataSuccessState extends ServiceRequestsState {
  final LeaseReqFieldDataResponse? leaseReqFieldDataResponse;

  LeaseReqFieldDataSuccessState({this.leaseReqFieldDataResponse});
}

class LeaseReqFieldDataFailedState extends ServiceRequestsState {
  final String? message;

  LeaseReqFieldDataFailedState({this.message});
}

class LeaseReqSaveDataSuccessState extends ServiceRequestsState {
  final String? message;

  LeaseReqSaveDataSuccessState({this.message});
}

class LeaseReqSaveDataFailedState extends ServiceRequestsState {
  final String? message;

  LeaseReqSaveDataFailedState({this.message});
}

class ServiceReqHistoryFailedState extends ServiceRequestsState {
  final String? message;

  ServiceReqHistoryFailedState({this.message});
}

class ServiceReqHistorySuccessState extends ServiceRequestsState {
  final String? message;
  final List<RequestList>? reqList;

  ServiceReqHistorySuccessState({
    this.message,
    this.reqList,
  });
}
class LoanReqFieldSuccessState extends ServiceRequestsState {
  final LoanReqFieldDataResponse? loanReqFieldDataResponse;

  LoanReqFieldSuccessState({this.loanReqFieldDataResponse});
}
class LoanReqFailedState extends ServiceRequestsState {
  final String? message;

  LoanReqFailedState({this.message});
}

class ServiceReqFilteredListSuccessState extends ServiceRequestsState {
  final List<ServiceReqFilteredList>? reqList;
  final String? reqType;

  ServiceReqFilteredListSuccessState({
    this.reqList,
    this.reqType,
  });
}
///
class DebitCardReqFieldDataSuccessState extends ServiceRequestsState {
  final DebitCardReqFieldDataResponse? debitCardReqFieldDataResponse;

  DebitCardReqFieldDataSuccessState({this.debitCardReqFieldDataResponse});
}
class DebitCardReqFieldDataFailedState extends ServiceRequestsState {
  final String? message;

  DebitCardReqFieldDataFailedState({this.message});
}

///Save
class DebitCardReqSaveDataSuccessState extends ServiceRequestsState {
  final String? message;

  DebitCardReqSaveDataSuccessState({this.message});
}

class DebitCardReqSaveDataFailedState extends ServiceRequestsState {
  final String? message;
  final String? code;

  DebitCardReqSaveDataFailedState({this.message,this.code});
}

////////new
//add request
class CheckBookRequestSuccessState extends ServiceRequestsState {
  final String? message;
  final String? code;



  CheckBookRequestSuccessState({this.message,this.code,});
}

class StatementRequestSuccessState extends ServiceRequestsState {
  final String? message;
  final String? code;



  StatementRequestSuccessState({this.message,this.code,});
}

class StatementRequestFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  StatementRequestFailState({this.message,this.code});
}

class GetAccountSuccessState extends ServiceRequestsState{
  final AccountDetailsResponseDtos? accDetails;

  GetAccountSuccessState({
    this.accDetails,
  });
}

class CheckBookRequestFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  CheckBookRequestFailState({this.message,this.code});
}

class GetAccountFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  GetAccountFailState({this.message,this.code});
}

//filterrequest

class FilterChequeBookSuccessState extends ServiceRequestsState{
  final List<ChequeBookList>? chequebookFilterList;
  final String? serviseCharge;
  final String? deliveryCharge;

  FilterChequeBookSuccessState({
  this.chequebookFilterList,
  this.serviseCharge,
  this.deliveryCharge,
  });
  }


class FilterChequeBookFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  FilterChequeBookFailState({this.message,this.code});
}


class FilterStatementSuccessState extends ServiceRequestsState{
  final List<FindChequeBookResponseList>? statementFilterList;
  final String? serviseCharge;
  final String? deliveryCharge;

  FilterStatementSuccessState({
    this.statementFilterList,
    this.serviseCharge,
    this.deliveryCharge,
  });
}

class FilterStatementFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  FilterStatementFailState({this.message,this.code});
}


class ServiceChargeSuccessState extends ServiceRequestsState{
  final List<ServiceCharge>? serviceChargeRequest;

  ServiceChargeSuccessState({this.serviceChargeRequest});
}

class ServiceChargeFailState extends ServiceRequestsState {
  final String? message;
  final String? code;

  ServiceChargeFailState({this.message,this.code});
}