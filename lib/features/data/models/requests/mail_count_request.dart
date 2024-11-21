// To parse this JSON data, do
//
//     final mailCountRequest = mailCountRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MailCountRequest mailCountRequestFromJson(String str) => MailCountRequest.fromJson(json.decode(str));

String mailCountRequestToJson(MailCountRequest data) => json.encode(data.toJson());

// ignore: must_be_immutable
class MailCountRequest extends Equatable{
    int? page;
    int? size;

    MailCountRequest({
        this.page,
        this.size,
    });

    factory MailCountRequest.fromJson(Map<String, dynamic> json) => MailCountRequest(
        page: json["page"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
    };
    
      @override
      List<Object?> get props => [page,size];
}
