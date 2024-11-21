
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

abstract class ForgetPasswordState extends BaseState<ForgetPasswordState> {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class CheckNicAccountNumReqSuccessState extends ForgetPasswordState {
  final ForgetPasswordResponse? forgetPasswordResponse;
  final String? message;
  final String? code;

  CheckNicAccountNumReqSuccessState({this.message,this.forgetPasswordResponse,this.code});
}

class CheckNicAccountNumReqFailedState extends ForgetPasswordState {
  final String? message;
  CheckNicAccountNumReqFailedState({this.message});
}


class CheckUsernameIdentityReqSuccessState extends ForgetPasswordState {
  final ForgetPasswordResponse? forgetPasswordResponse;
  final String? message;
  final String? code;

  CheckUsernameIdentityReqSuccessState({this.message,this.forgetPasswordResponse,this.code});
}

class CheckUsernameIdentityReqFailedState extends ForgetPasswordState {
  final String? message;
  CheckUsernameIdentityReqFailedState({this.message});
}

class CheckSQAnswerReqSuccessState extends ForgetPasswordState {
  final ForgetPasswordResponse? forgetPasswordResponse;
  final String? message;

  CheckSQAnswerReqSuccessState({this.message,this.forgetPasswordResponse});
}

class CheckSQAnswerReqFailedState extends ForgetPasswordState {
  final String? message;
  CheckSQAnswerReqFailedState({this.message});
}

class ForgotPwResetReqSuccessState extends ForgetPasswordState {
  final String? message;

  ForgotPwResetReqSuccessState({this.message});
}

class ForgotPwResetReqFailedState extends ForgetPasswordState {
  final String? message;
  ForgotPwResetReqFailedState({this.message});
}

