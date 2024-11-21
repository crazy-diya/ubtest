// To parse this JSON data, do
//
//     final deleteMailRequest = deleteMailRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

DeleteMailMessageRequest deleteMailMessageRequestFromJson(String str) => DeleteMailMessageRequest.fromJson(json.decode(str));

String deleteMailMessageRequestToJson(DeleteMailMessageRequest data) => json.encode(data.toJson());

class DeleteMailMessageRequest extends Equatable{
    final String? epicUserId;
    final List<int>? inboxMessageIdList;

    const DeleteMailMessageRequest({
        this.epicUserId,
        this.inboxMessageIdList,
    });

    factory DeleteMailMessageRequest.fromJson(Map<String, dynamic> json) => DeleteMailMessageRequest(
        epicUserId: json["epicUserId"],
        inboxMessageIdList: json["inboxMessageIdList"] == null ? [] : List<int>.from(json["inboxMessageIdList"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "inboxMessageIdList": inboxMessageIdList == null ? [] : List<dynamic>.from(inboxMessageIdList!.map((x) => x)),
    };

    @override
      List<Object?> get props => [epicUserId,inboxMessageIdList];
}
