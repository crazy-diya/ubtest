import '../../../data/models/requests/language_request.dart';

class LanguageEntity extends LanguageRequest {
  final String? messageType;
  final String? language;
  final String? selectedDate;

  LanguageEntity({this.messageType, this.language, this.selectedDate})
      : super(
          language: language,
          messageType: messageType,
          selectedDate: selectedDate,
        );
}
