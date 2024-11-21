// To parse this JSON data, do
//
//     final requestMoneyHistoryResponse = requestMoneyHistoryResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

RequestMoneyHistoryResponse requestMoneyHistoryResponseFromJson(String str) => RequestMoneyHistoryResponse.fromJson(json.decode(str));

String requestMoneyHistoryResponseToJson(RequestMoneyHistoryResponse data) => json.encode(data.toJson());

class RequestMoneyHistoryResponse extends Serializable{
  final List<ListElement>? list;

  RequestMoneyHistoryResponse({
    this.list,
  });

  factory RequestMoneyHistoryResponse.fromJson(Map<String, dynamic> json) => RequestMoneyHistoryResponse(
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  final int? id;
  final String? cdbUserPayor;
  final String? toAccount;
  final String? toAccountName;
  final double? requestedAmount;
  final String? remarks;
  final String? status;
  final String? date;

  ListElement({
    this.id,
    this.cdbUserPayor,
    this.toAccount,
    this.toAccountName,
    this.requestedAmount,
    this.remarks,
    this.date,
    this.status,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    cdbUserPayor: json["cdbUserPayor"],
    toAccount: json["toAccount"],
    toAccountName: json["toAccountName"],
    requestedAmount: json["requestedAmount"]?.toDouble(),
    remarks: json["remarks"],
    date: json["date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cdbUserPayor": cdbUserPayor,
    "toAccount": toAccount,
    "toAccountName": toAccountName,
    "requestedAmount": requestedAmount,
    "remarks": remarks,
    "date": date,
    "status": status,
  };
}
