import '../base_state.dart';

abstract class LanguageState extends BaseState<LanguageState> {}

class InitialLanguageState extends LanguageState {}

class SetPreferredLanguageSuccessState extends LanguageState {}

class SetPreferredLanguageFailedState extends LanguageState {
  final String? message;

  SetPreferredLanguageFailedState({this.message});
}

class SavePrefLanguageSuccessState extends LanguageState {}

class SavePrefLanguageFailedState extends LanguageState {
  final String? message;

  SavePrefLanguageFailedState({this.message});
}
