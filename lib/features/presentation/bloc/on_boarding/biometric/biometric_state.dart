// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../base_state.dart';

abstract class BiometricState extends BaseState<BiometricState> {}

class InitialBiometricState extends BiometricState {}

class EnableBiometricSuccessState extends BiometricState {}

class DisableBiometricSuccessState extends BiometricState {}

class EnableBiometricFailedState extends BiometricState {
  final String? error;

  EnableBiometricFailedState({this.error});
}

class SaveUserSuccessState extends BiometricState {}

class SaveUserFailedState extends BiometricState {
  final String? message;

  SaveUserFailedState({this.message});
}

class BiometricPromptSuccessState extends BiometricState {}


class PasswordValidationSuccessState extends BiometricState {
  final int? chequeBookId;
  String? status;
  String? message;
  PasswordValidationSuccessState({
    this.status,
    this.message,this.chequeBookId
  });
}

class PasswordValidationFailedState extends BiometricState {
  final String? message;

  PasswordValidationFailedState({this.message});
}

class CheckBookRequestPasswordSuccessState extends BiometricState {
  final String? message;
  final String? code;

  CheckBookRequestPasswordSuccessState({this.message,this.code,});
}

class StatementRequestSuccessState extends BiometricState {
  final String? message;
  final String? code;

  StatementRequestSuccessState({this.message,this.code,});
}

class CheckBookRequestPasswordFailedState extends BiometricState {
  final String? message;
  final String? code;



  CheckBookRequestPasswordFailedState({this.message,this.code,});
}

class StatementRequestFailedState extends BiometricState {
  final String? message;
  final String? code;



  StatementRequestFailedState({this.message,this.code,});
}