import 'dart:convert';

import 'package:equatable/equatable.dart';

GetTermsRequest getTermsRequestFromJson(String str) =>
    GetTermsRequest.fromJson(json.decode(str));

String getTermsRequestToJson(GetTermsRequest data) =>
    json.encode(data.toJson());

class GetTermsRequest extends Equatable {
  const GetTermsRequest({this.messageType, this.termType});

  final String? messageType;
  final String? termType;

  factory GetTermsRequest.fromJson(Map<String, dynamic> json) =>
      GetTermsRequest(
        messageType: json["messageType"],
        termType: json["termType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "termType": termType,
      };

  @override
  List<Object?> get props => [messageType, termType];
}
