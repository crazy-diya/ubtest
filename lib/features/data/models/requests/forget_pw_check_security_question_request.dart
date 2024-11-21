// To parse this JSON data, do
//
//     final forgetPwCheckSecurityQuestionRequest = forgetPwCheckSecurityQuestionRequestFromJson(jsonString);

import 'dart:convert';

ForgetPwCheckSecurityQuestionRequest forgetPwCheckSecurityQuestionRequestFromJson(String str) => ForgetPwCheckSecurityQuestionRequest.fromJson(json.decode(str));

String forgetPwCheckSecurityQuestionRequestToJson(ForgetPwCheckSecurityQuestionRequest data) => json.encode(data.toJson());

class ForgetPwCheckSecurityQuestionRequest {
    final List<Answer>? answers;
    final String? identificationType;
    final String? identificationNo;
    final String? messageType;

    ForgetPwCheckSecurityQuestionRequest({
        this.answers,
        this.identificationNo,
        this.identificationType,
        this.messageType,
    });

    factory ForgetPwCheckSecurityQuestionRequest.fromJson(Map<String, dynamic> json) => ForgetPwCheckSecurityQuestionRequest(
        answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
        identificationNo: json["identificationNo"],
        identificationType: json["identificationType"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "identificationNo": identificationNo,
        "identificationType": identificationType,
        "messageType": messageType,
    };
}

class Answer {
    final int? question;
    final String? answer;

    Answer({
        this.question,
        this.answer,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
    };
}
