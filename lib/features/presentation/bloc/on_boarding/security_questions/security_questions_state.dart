import '../../base_state.dart';

abstract class SecurityQuestionsState
    extends BaseState<SecurityQuestionsState> {}

class InitialSecurityQuestionsState extends SecurityQuestionsState {}

class SetSecurityQuestionsSuccessState extends SecurityQuestionsState {}

class SetSecurityQuestionsFailedState extends SecurityQuestionsState {
  final String? message;

  SetSecurityQuestionsFailedState({this.message});
}

class SaveSecurityQuestionsSuccessState extends SecurityQuestionsState {}

class SaveSecurityQuestionsFailedState extends SecurityQuestionsState {
  final String? message;

  SaveSecurityQuestionsFailedState({this.message});
}

class SecurityQuestionsDropDownDataLoadedState<T> extends SecurityQuestionsState {
  final T data;

  SecurityQuestionsDropDownDataLoadedState({required this.data});
}

class SecurityQuestionsDropDownDataFailedState extends SecurityQuestionsState {
  final String? message;

  SecurityQuestionsDropDownDataFailedState({required this.message});
}