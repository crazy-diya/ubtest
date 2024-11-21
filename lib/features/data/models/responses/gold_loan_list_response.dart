// To parse this JSON data, do
//
//     final goldLoanListResponse = goldLoanListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GoldLoanListResponse goldLoanListResponseFromJson(String str) =>
    GoldLoanListResponse.fromJson(json.decode(str));

String goldLoanListResponseToJson(GoldLoanListResponse data) =>
    json.encode(data.toJson());

class GoldLoanListResponse extends Serializable {
  GoldLoanListResponse({
    this.referenceno,
    this.nicno,
    this.module,
    this.goldLoanBeans,
  });

  String? referenceno;
  String? nicno;
  String? module;
  List<GoldLoanListBean>? goldLoanBeans;

  factory GoldLoanListResponse.fromJson(Map<String, dynamic> json) =>
      GoldLoanListResponse(
        referenceno: json["referenceno"],
        nicno: json["nicno"],
        module: json["module"],
        goldLoanBeans: json["Data"] != null
            ? List<GoldLoanListBean>.from(json["Data"].map((x) => GoldLoanListBean.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "referenceno": referenceno,
        "nicno": nicno,
        "module": module,
        "Data": List<dynamic>.from(goldLoanBeans!.map((x) => x.toJson())),
      };
}

class GoldLoanListBean {
  GoldLoanListBean({
    this.customerName,
    this.mobileNo,
    this.email,
    this.tickets,
  });

  String? customerName;
  String? mobileNo;
  String? email;
  List<TicketBean>? tickets;

  factory GoldLoanListBean.fromJson(Map<String, dynamic> json) => GoldLoanListBean(
        customerName: json["CustomerName"],
        mobileNo: json["MobileNo"],
        email: json["Email"],
        tickets: json["Tickets"] != null
            ? List<TicketBean>.from(
                json["Tickets"].map((x) => TicketBean.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "CustomerName": customerName,
        "MobileNo": mobileNo,
        "Email": email,
        "Tickets": List<dynamic>.from(tickets!.map((x) => x.toJson())),
      };
}

class TicketBean {
  TicketBean({
    this.ticketNumber,
    this.ticketStatus,
    this.totalOutstanding,
  });

  String? ticketNumber;
  String? ticketStatus;
  double? totalOutstanding;

  factory TicketBean.fromJson(Map<String, dynamic> json) => TicketBean(
        ticketNumber: json["TicketNumber"],
        ticketStatus: json["TicketStatus"],
        totalOutstanding: json["TotalOutstanding"],
      );

  Map<String, dynamic> toJson() => {
        "TicketNumber": ticketNumber,
        "TicketStatus": ticketStatus,
        "TotalOutstanding": totalOutstanding,
      };
}
