part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends BaseState<ChangePasswordState> {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordFailState extends ChangePasswordState {
  final String? message;

  ChangePasswordFailState({this.message});
}

class ChangePasswordApiFailState extends ChangePasswordState {
  final String? message;

  ChangePasswordApiFailState({this.message});
}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String? responseCode;
  final String? responseDescription;

  ChangePasswordSuccessState({
    this.responseCode,
    this.responseDescription,
  });
}

class ChangePasswordWrongCurrentPassword extends ChangePasswordState {
  final String? errorMessage;

  ChangePasswordWrongCurrentPassword({this.errorMessage});
}

class ChangePasswordConfirmPasswordWrong extends ChangePasswordState {
  final String? errorMessage;

  ChangePasswordConfirmPasswordWrong({this.errorMessage});
}
