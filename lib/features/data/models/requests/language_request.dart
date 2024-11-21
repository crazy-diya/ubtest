// To parse this JSON data, do
//
//     final languageRequest = languageRequestFromJson(jsonString);

import 'dart:convert';

LanguageRequest languageRequestFromJson(String str) =>
    LanguageRequest.fromJson(json.decode(str));

String languageRequestToJson(LanguageRequest data) =>
    json.encode(data.toJson());

class LanguageRequest {
  LanguageRequest({
    this.messageType,
    this.language,
    this.selectedDate,
  });

  final String? messageType;
  final String? language;
  final String? selectedDate;

  factory LanguageRequest.fromJson(Map<String, dynamic> json) =>
      LanguageRequest(
        messageType: json["messageType"],
        language: json["language"],
        selectedDate: json["selectedDate"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "language": language,
        "selectedDate": selectedDate,
      };
}
