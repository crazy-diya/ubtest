// To parse this JSON data, do
//
//     final setSecurityQuestions = setSecurityQuestionsFromJson(jsonString);

import 'dart:convert';

SetSecurityQuestionsRequest setSecurityQuestionsFromJson(String str) =>
    SetSecurityQuestionsRequest.fromJson(json.decode(str));

String setSecurityQuestionsToJson(SetSecurityQuestionsRequest data) =>
    json.encode(data.toJson());

class SetSecurityQuestionsRequest {
  SetSecurityQuestionsRequest({
    this.messageType,
    this.answerList,
    this.isMigrated
  });

  final String? messageType;
  final List<AnswerList>? answerList;
  final String? isMigrated;

  factory SetSecurityQuestionsRequest.fromJson(Map<String, dynamic> json) =>
      SetSecurityQuestionsRequest(
        messageType: json["messageType"],
        answerList: json["answerList"] == null
            ? null
            : List<AnswerList>.from(
                json["answerList"].map((x) => AnswerList.fromJson(x))),
                isMigrated:json["isMigrated"]
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "answerList": answerList == null
            ? null
            : List<dynamic>.from(answerList!.map((x) => x.toJson())),
            "isMigrated":isMigrated
      };
}

class AnswerList {
  AnswerList({
    this.id,
    this.answer,
  });

  final int? id;
  final String? answer;

  factory AnswerList.fromJson(Map<String, dynamic> json) => AnswerList(
        id: json["id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
      };
}
