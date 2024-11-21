// To parse this JSON data, do
//
//     final mailCountResponse = mailCountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

MailCountResponse mailCountResponseFromJson(String str) => MailCountResponse.fromJson(json.decode(str));

String mailCountResponseToJson(MailCountResponse data) => json.encode(data.toJson());

class MailCountResponse extends Serializable{
    int? mailThreadCount;
    int? totalUnread;

    MailCountResponse({
        this.mailThreadCount,
        this.totalUnread,
    });

    MailCountResponse copyWith({
        int? mailThreadCount,
        int? totalUnread,
    }) => 
        MailCountResponse(
            mailThreadCount: mailThreadCount ?? this.mailThreadCount,
            totalUnread: totalUnread ?? this.totalUnread,
        );

    factory MailCountResponse.fromJson(Map<String, dynamic> json) => MailCountResponse(
        mailThreadCount: json["mailThreadCount"],
        totalUnread: json["totalUnread"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "mailThreadCount": mailThreadCount,
        "totalUnread": totalUnread,
    };
}
