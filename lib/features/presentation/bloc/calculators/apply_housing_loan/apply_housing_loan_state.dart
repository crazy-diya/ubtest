part of 'apply_housing_loan_bloc.dart';

@immutable
abstract class ApplyHousingLoanState extends BaseState<ApplyHousingLoanState> {}

class ApplyHousingLoanInitial extends ApplyHousingLoanState {}

class ApplyHousingLoanFieldDataSuccessState extends ApplyHousingLoanState {
  final String? amount;
  final String? paymentPeriod;
  final String? grossIncome;
  final String? reqType;
  final String? messageType;
  final String? responseDes;

  ApplyHousingLoanFieldDataSuccessState({this.amount,this.paymentPeriod,this.grossIncome,this.reqType,this.messageType,this.responseDes});
}

class ApplyHousingLoanFieldDataFailedState extends ApplyHousingLoanState {
  final String? message;

  ApplyHousingLoanFieldDataFailedState({this.message});
}
