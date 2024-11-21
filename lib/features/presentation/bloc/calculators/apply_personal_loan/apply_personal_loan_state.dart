part of 'apply_personal_loan_bloc.dart';

@immutable
abstract class ApplyPersonalLoanState extends BaseState<ApplyPersonalLoanState> {}

class ApplyPersonalLoanInitial extends ApplyPersonalLoanState {}

class ApplyPersonalLoanFieldDataSuccessState extends ApplyPersonalLoanState {
  final String? responseCode;
  final String? responseDescription;

  ApplyPersonalLoanFieldDataSuccessState(
      {this.responseCode, this.responseDescription});
}

class ApplyPersonalLoanFieldDataFailedState extends ApplyPersonalLoanState {
  final String? message;

  ApplyPersonalLoanFieldDataFailedState({this.message});
}
