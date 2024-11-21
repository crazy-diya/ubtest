

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

SecurityQuestionResponse securityQuestionResponseFromJson(String str) => SecurityQuestionResponse.fromJson(json.decode(str));

String securityQuestionResponseToJson(SecurityQuestionResponse data) => json.encode(data.toJson());

class SecurityQuestionResponse extends Serializable{
    final List<SecurityQuestion>? data;

    SecurityQuestionResponse({
        this.data,
    });

    factory SecurityQuestionResponse.fromJson(Map<String, dynamic> json) => SecurityQuestionResponse(
        data: json["data"] == null ? [] : List<SecurityQuestion>.from(json["data"]!.map((x) => SecurityQuestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SecurityQuestion {
    final int? id;
    final String? secQuestion;
    final String? status;

    SecurityQuestion({
        this.id,
        this.secQuestion,
        this.status,
    });

    factory SecurityQuestion.fromJson(Map<String, dynamic> json) => SecurityQuestion(
        id: json["id"],
        secQuestion: json["secQuestion"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "secQuestion": secQuestion,
        "status": status,
    };
}

