// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'drop_down_bloc.dart';

abstract class DropDownEvent extends BaseEvent {}

class FilterEvent extends DropDownEvent {
  final List<CommonDropDownResponse> dropDownData;
  final String searchText;

  FilterEvent({required this.dropDownData, required this.searchText});
}

class GetCustomDropDownEvent extends DropDownEvent {
  final List<CommonDropDownResponse> dataList;

  GetCustomDropDownEvent({required this.dataList});
}

class GetTitleDropDownEvent extends DropDownEvent {}

class GetPurposeOfAccountOpeningEvent extends DropDownEvent {}

class GetSourceOfFundsEvent extends DropDownEvent {}

class GetTransactionModeEvent extends DropDownEvent {}

class GetCityEvent extends DropDownEvent {}

class GetEmployementTypeEvent extends DropDownEvent {}

class GetEmployementFieldEvent extends DropDownEvent {}

class GetDesignationEvent extends DropDownEvent {}

class GetAnnualIncomenEvent extends DropDownEvent {}

class GetLanguageEvent extends DropDownEvent {}

class GetReligionEvent extends DropDownEvent {}

class GetAccountEvent extends DropDownEvent {}

class GetAmountRangeEvent extends DropDownEvent {}

class GetTransTypeEvent extends DropDownEvent {}

class GetQuestions1DropDownEvent extends DropDownEvent {}

class GetQuestions2DropDownEvent extends DropDownEvent {}

class GetLanguageDropDownEvent extends DropDownEvent {}

class GetBankDropDownEvent extends DropDownEvent {}

class GetActiveCurrentAccountsDropDownEvent extends DropDownEvent {}

class GetTxnCategoryDropDownEvent extends DropDownEvent {
  final String? messageType;
  final String? channelType;
  GetTxnCategoryDropDownEvent({this.channelType,this.messageType});
}

class GetBankBranchDropDownEvent extends DropDownEvent {
  final String bankCode;

  GetBankBranchDropDownEvent({required this.bankCode});
}

class GetAccountTypeDropDownEvent extends DropDownEvent {}

class GetNationalityEvent extends DropDownEvent {}

class GetMonthEvent extends DropDownEvent {}

class GetYearEvent extends DropDownEvent {}

class GetLeaseYearEvent extends DropDownEvent {}

class GetInterestTypeEvent extends DropDownEvent {}

class GetPurposeLoanEvent extends DropDownEvent {}

class GetPeriodEvent extends DropDownEvent {
  final String? messageType;

  GetPeriodEvent({this.messageType});
}

class GetCurrencyEvent extends DropDownEvent {
  final String? messageType;

  GetCurrencyEvent({this.messageType});
}

class GetAccountsEvent extends DropDownEvent {
  final String? messageType;
  final String? requestType;

  GetAccountsEvent({this.messageType,this.requestType});
}

class GetFDTypeEvent extends DropDownEvent {}

class GetVehicleOptionEvent extends DropDownEvent {}



class GetVehicleTypeEvent extends DropDownEvent {}

class GetLeasePeriodEvent extends DropDownEvent {}

class GetLMaritalStatusEvent extends DropDownEvent {}

class GetSecurityQuestionDropDownEvent extends DropDownEvent {
  String? nic;
  GetSecurityQuestionDropDownEvent({
    this.nic,
  });
}

class GetRecipientTypesEvent extends DropDownEvent {
  String? recipientCode;
  GetRecipientTypesEvent({this.recipientCode});
}

class GetRecipientCategoryEvent extends DropDownEvent {
}


class GetCardDeactivationReasonEvent extends DropDownEvent {}

class GetFTCatagoryEvent extends DropDownEvent {}

class GetFTFrequencyEvent extends DropDownEvent {}
