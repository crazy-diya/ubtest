part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends BaseState<ResetPasswordState> {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordFailState extends ResetPasswordState {
  final String? message;
  final String? responseCode;

  ResetPasswordFailState({this.message, this.responseCode});
}

class ResetPasswordSuccessState extends ResetPasswordState {
  final String? responseCode;
  final String? responseDescription;

  ResetPasswordSuccessState({
    this.responseCode,
    this.responseDescription,
  });
}


class TemporaryResetFailedState extends ResetPasswordState {
  final String? message;
  final String? errorCode;

  TemporaryResetFailedState({this.message,this.errorCode});
}

class TemporaryResetAPIFailedState extends ResetPasswordState {
  final String? message;
  final String? errorCode;

  TemporaryResetAPIFailedState({this.message,this.errorCode,});
}

class TemporaryResetSuccessState extends ResetPasswordState {
  final TemporaryLoginResponse? temporaryLoginResponse;
  final String? responseCode;
  final String? responseDescription;

  TemporaryResetSuccessState(  {this.temporaryLoginResponse, this.responseCode, this.responseDescription});
}


