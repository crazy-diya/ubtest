// To parse this JSON data, do
//
//     final deleteMailRequest = deleteMailRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MarkAsReadMailRequest deleteMailRequestFromJson(String str) => MarkAsReadMailRequest.fromJson(json.decode(str));

String deleteMailRequestToJson(MarkAsReadMailRequest data) => json.encode(data.toJson());

class MarkAsReadMailRequest extends Equatable{
    final String? epicUserId;
    final List<int>? inboxIdList;

    const MarkAsReadMailRequest({
        this.epicUserId,
        this.inboxIdList,
    });

    factory MarkAsReadMailRequest.fromJson(Map<String, dynamic> json) => MarkAsReadMailRequest(
        epicUserId: json["epicUserId"],
        inboxIdList: json["inboxIdList"] == null ? [] : List<int>.from(json["inboxIdList"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "inboxIdList": inboxIdList == null ? [] : List<dynamic>.from(inboxIdList!.map((x) => x)),
    };

    @override
      List<Object?> get props => [epicUserId,inboxIdList];
}
