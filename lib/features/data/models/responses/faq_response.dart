// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse extends Serializable{
  FaqResponse({
    this.faqList,
    this.moreInfoUrl,
  });

  List<FaqList>? faqList;
  String? moreInfoUrl;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    faqList: List<FaqList>.from(json["faqList"].map((x) => FaqList.fromJson(x))),
    moreInfoUrl: json["moreInfoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "faqList": List<dynamic>.from(faqList!.map((x) => x.toJson())),
    "moreInfoUrl": moreInfoUrl,
  };
}

class FaqList {
  FaqList({
    this.id,
    this.question,
    this.answer,
  });

  int? id;
  String? question;
  String? answer;

  factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
  };
}
