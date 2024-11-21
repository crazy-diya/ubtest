
import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

TransactionNotificationResponse transactionNotificationResponseFromJson(String str) => TransactionNotificationResponse.fromJson(json.decode(str));

String transactionNotificationResponseToJson(TransactionNotificationResponse data) => json.encode(data.toJson());

class TransactionNotificationResponse extends Serializable{
    final int? count;
    final int? totalUnread;
    final List<UserNotificationResponseDtoList>? userNotificationResponseDtoList;

    TransactionNotificationResponse({
        this.count,
        this.totalUnread,
        this.userNotificationResponseDtoList,
    });

    factory TransactionNotificationResponse.fromJson(Map<String, dynamic> json) => TransactionNotificationResponse(
        count: json["count"],
        totalUnread: json["totalUnread"],
        userNotificationResponseDtoList: json["userNotificationResponseDTOList"] == null ? [] : List<UserNotificationResponseDtoList>.from(json["userNotificationResponseDTOList"]!.map((x) => UserNotificationResponseDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "totalUnread": totalUnread,
        "userNotificationResponseDTOList": userNotificationResponseDtoList == null ? [] : List<dynamic>.from(userNotificationResponseDtoList!.map((x) => x.toJson())),
    };
}

class UserNotificationResponseDtoList {
    final String? title;
    final String? body;
    final DateTime? date;
    final String? notificationType;
    final int? readStatus;
    final int? notificationId;
    final String? fromAccountName;
    final String? toAccountNo;
    final String? toAccountName;
    final String? remarks;
    final String? referenceNumber;
    final String? billerImage;
    final String? txnType;
    final String? reqMoneyId;
    final String? reqMoneystatus;
    final String? fromAccountNo;
    final String? amount;

    UserNotificationResponseDtoList({
        this.title,
        this.body,
        this.date,
        this.notificationType,
        this.readStatus,
        this.notificationId,
        this.fromAccountName,
        this.toAccountNo,
        this.toAccountName,
        this.remarks,
        this.referenceNumber,
        this.billerImage,
        this.txnType,
        this.reqMoneyId,
        this.reqMoneystatus,
        this.fromAccountNo,
        this.amount,
    });

    factory UserNotificationResponseDtoList.fromJson(Map<String, dynamic> json) => UserNotificationResponseDtoList(
        title: json["title"],
        body: json["body"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        notificationType: json["notificationType"],
        readStatus: json["readStatus"],
        notificationId: json["notificationId"],
        fromAccountName: json["fromAccountName"],
        toAccountNo: json["toAccountNo"],
        toAccountName: json["toAccountName"],
        remarks: json["remarks"],
        referenceNumber: json["referenceNumber"],
        billerImage: json["billerImage"],
        txnType: json["txnType"],
        reqMoneyId: json["reqMoneyId"],
        reqMoneystatus: json["reqMoneystatus"],
        fromAccountNo: json["fromAccountNo"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "date": date?.toIso8601String(),
        "notificationType": notificationType,
        "readStatus": readStatus,
        "notificationId": notificationId,
        "fromAccountName": fromAccountName,
        "toAccountNo": toAccountNo,
        "toAccountName": toAccountName,
        "remarks": remarks,
        "referenceNumber": referenceNumber,
        "billerImage": billerImage,
        "txnType": txnType,
        "reqMoneyId": reqMoneyId,
        "reqMoneystatus": reqMoneystatus,
        "fromAccountNo": fromAccountNo,
        "amount": amount,
    };
}

