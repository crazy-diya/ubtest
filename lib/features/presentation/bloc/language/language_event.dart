import '../base_event.dart';

abstract class LanguageEvent extends BaseEvent {}

class SetPreferredLanguageEvent extends LanguageEvent {
  final String? language;
  final String? selectedDate;

  SetPreferredLanguageEvent({this.language, this.selectedDate});
}

class SavePrefLanguageStateEvent extends LanguageEvent {}
