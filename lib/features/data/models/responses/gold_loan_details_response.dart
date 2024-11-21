// To parse this JSON data, do
//
//     final goldLoanDetailsResponse = goldLoanDetailsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GoldLoanDetailsResponse goldLoanDetailsResponseFromJson(String str) =>
    GoldLoanDetailsResponse.fromJson(json.decode(str));

String goldLoanDetailsResponseToJson(GoldLoanDetailsResponse data) =>
    json.encode(data.toJson());

class GoldLoanDetailsResponse extends Serializable {
  GoldLoanDetailsResponse({
    this.referenceno,
    this.nicno,
    this.module,
    this.goldLoanDetailsBean,
    this.maximum,
    this.minimum,
  });

  String? referenceno;
  String? nicno;
  String? module;
  double? minimum;
  double? maximum;
  List<GoldLoanDetailsBean>? goldLoanDetailsBean;

  factory GoldLoanDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GoldLoanDetailsResponse(
        referenceno: json["referenceno"],
        nicno: json["nicno"],
        module: json["module"],
          minimum: json["minimum"],
          maximum: json["maximum"],
        goldLoanDetailsBean: json["Data"] != null
            ? List<GoldLoanDetailsBean>.from(
                json["Data"].map((x) => GoldLoanDetailsBean.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "referenceno": referenceno,
        "nicno": nicno,
        "module": module,
    "minimum": minimum,
    "maximum": maximum,
        "Data": List<dynamic>.from(goldLoanDetailsBean!.map((x) => x.toJson())),
      };
}

class GoldLoanDetailsBean {
  GoldLoanDetailsBean({
    this.period,
    this.ticketNumber,
    this.ticketStatus,
    this.outstandingBalance,
    this.interestBalance,
    this.expiryDate,
    this.capitalBalance,
    this.totalItemCount,
    this.totalWeight,
    this.articles,
    this.remainingAdvanceLimit,
    this.maximumAdvanceLimit,
  });

  String? period;
  String? ticketNumber;
  String? ticketStatus;
  String? outstandingBalance;
  String? interestBalance;
  DateTime? expiryDate;
  String? capitalBalance;
  String? totalItemCount;
  String? totalWeight;
  List<ArticleBean>? articles;
  String? remainingAdvanceLimit;
  String? maximumAdvanceLimit;

  factory GoldLoanDetailsBean.fromJson(Map<String, dynamic> json) =>
      GoldLoanDetailsBean(
        period: json["Period"],
        ticketNumber: json["TicketNumber"],
        ticketStatus: json["TicketStatus"],
        outstandingBalance: json["OutstandingBalance"],
        interestBalance: json["InterestBalance"],
        expiryDate: DateTime.parse(json["ExpiryDate"]),
        capitalBalance: json["CapitalBalance"],
        totalItemCount: json["TotalItemCount"],
        totalWeight: json["TotalWeight"],
        articles: json["Articles"] != null
            ? List<ArticleBean>.from(
                json["Articles"].map((x) => ArticleBean.fromJson(x)))
            : List.empty(),
        remainingAdvanceLimit: json["RemainingAdvanceLimit"],
        maximumAdvanceLimit: json["MaximumAdvanceLimit"],
      );

  Map<String, dynamic> toJson() => {
        "Period": period,
        "TicketNumber": ticketNumber,
        "TicketStatus": ticketStatus,
        "OutstandingBalance": outstandingBalance,
        "InterestBalance": interestBalance,
        "ExpiryDate": expiryDate!.toIso8601String(),
        "CapitalBalance": capitalBalance,
        "TotalItemCount": totalItemCount,
        "TotalWeight": totalWeight,
        "Articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
        "RemainingAdvanceLimit": remainingAdvanceLimit,
        "MaximumAdvanceLimit": maximumAdvanceLimit,
      };
}

class ArticleBean {
  ArticleBean({
    this.articleId,
    this.articleWeight,
    this.goldWeight,
    this.itemCount,
    this.remark,
    this.machineGoldContent,
    this.itemId,
    this.item,
    this.itemDescriptionId,
    this.itemDescription,
    this.goldContentId,
    this.content,
    this.isAcidTest,
    this.acidTestUserId,
    this.acidTestUser,
    this.cMarketValue,
    this.cGivenValue,
    this.cMaxValue,
    this.assesedValue,
    this.chargeAmount,
    this.chargeBalance,
    this.acidTest,
  });

  int? articleId;
  int? articleWeight;
  int? goldWeight;
  int? itemCount;
  String? remark;
  String? machineGoldContent;
  int? itemId;
  String? item;
  int? itemDescriptionId;
  String? itemDescription;
  int? goldContentId;
  int? content;
  bool? isAcidTest;
  String? acidTestUserId;
  String? acidTestUser;
  double? cMarketValue;
  double? cGivenValue;
  double? cMaxValue;
  double? assesedValue;
  double? chargeAmount;
  double? chargeBalance;
  String? acidTest;

  factory ArticleBean.fromJson(Map<String, dynamic> json) => ArticleBean(
        articleId: json["ArticleID"],
        articleWeight: json["ArticleWeight"],
        goldWeight: json["GoldWeight"],
        itemCount: json["ItemCount"],
        remark: json["Remark"],
        machineGoldContent: json["MachineGoldContent"],
        itemId: json["ItemID"],
        item: json["Item"],
        itemDescriptionId: json["ItemDescriptionID"],
        itemDescription: json["ItemDescription"],
        goldContentId: json["GoldContentID"],
        content: json["Content"],
        isAcidTest: json["IsAcidTest"],
        acidTestUserId: json["AcidTestUserID"],
        acidTestUser: json["AcidTestUser"],
        cMarketValue: json["CMarketValue"].toDouble(),
        cGivenValue: json["CGivenValue"],
        cMaxValue: json["CMaxValue"],
        assesedValue: json["AssesedValue"].toDouble(),
        chargeAmount: json["ChargeAmount"],
        chargeBalance: json["ChargeBalance"],
        acidTest: json["AcidTest"],
      );

  Map<String, dynamic> toJson() => {
        "ArticleID": articleId,
        "ArticleWeight": articleWeight,
        "GoldWeight": goldWeight,
        "ItemCount": itemCount,
        "Remark": remark,
        "MachineGoldContent": machineGoldContent,
        "ItemID": itemId,
        "Item": item,
        "ItemDescriptionID": itemDescriptionId,
        "ItemDescription": itemDescription,
        "GoldContentID": goldContentId,
        "Content": content,
        "IsAcidTest": isAcidTest,
        "AcidTestUserID": acidTestUserId,
        "AcidTestUser": acidTestUser,
        "CMarketValue": cMarketValue,
        "CGivenValue": cGivenValue,
        "CMaxValue": cMaxValue,
        "AssesedValue": assesedValue,
        "ChargeAmount": chargeAmount,
        "ChargeBalance": chargeBalance,
        "AcidTest": acidTest,
      };
}
