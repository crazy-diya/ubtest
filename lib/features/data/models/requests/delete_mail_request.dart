// To parse this JSON data, do
//
//     final deleteMailRequest = deleteMailRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

DeleteMailRequest deleteMailRequestFromJson(String str) => DeleteMailRequest.fromJson(json.decode(str));

String deleteMailRequestToJson(DeleteMailRequest data) => json.encode(data.toJson());

class DeleteMailRequest extends Equatable{
    final String? epicUserId;
    final List<int>? inboxIdList;

    const DeleteMailRequest({
        this.epicUserId,
        this.inboxIdList,
    });

    factory DeleteMailRequest.fromJson(Map<String, dynamic> json) => DeleteMailRequest(
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
