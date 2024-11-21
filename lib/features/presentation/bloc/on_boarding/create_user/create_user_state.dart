import '../../base_state.dart';

abstract class CreateUserState extends BaseState<CreateUserState> {}

class InitialCreateUserState extends CreateUserState {}

class CreateUserSuccessState extends CreateUserState {}

class CreateUserFailedState extends CreateUserState {
  final String? message;

  CreateUserFailedState({this.message});
}

class CheckUserSuccessState extends CreateUserState {}

class CheckUserFailedState extends CreateUserState {
  final String? message;

  CheckUserFailedState({this.message});
}

class SaveUserSuccessState extends CreateUserState {}

class SaveUserFailedState extends CreateUserState {
  final String? message;

  SaveUserFailedState({this.message});
}
