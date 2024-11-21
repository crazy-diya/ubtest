// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

MailThreadRequest mailThreadRequestFromJson(String str) => MailThreadRequest.fromJson(json.decode(str));

String mailThreadRequestToJson(MailThreadRequest data) => json.encode(data.toJson());

class MailThreadRequest extends Equatable {
    final String? epicUserId;
    final int? inboxId;
    final bool? isComposeDraft;

  const MailThreadRequest({
    this.epicUserId,
    this.inboxId,
    this.isComposeDraft,
  });

    factory MailThreadRequest.fromJson(Map<String, dynamic> json) => MailThreadRequest(
        epicUserId: json["epicUserId"],
        inboxId: json["inboxId"],
        isComposeDraft:json["isComposeDraft"]
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "inboxId": inboxId,
        "isComposeDraft":isComposeDraft
    };
    
      @override
      List<Object?> get props =>[epicUserId,inboxId,isComposeDraft];
}
