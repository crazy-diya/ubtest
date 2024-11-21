// To parse this JSON data, do
//
//     final getAllFundTransferScheduleResponse = getAllFundTransferScheduleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetAllFundTransferScheduleResponse getAllFundTransferScheduleResponseFromJson(
        String str) =>
    GetAllFundTransferScheduleResponse.fromJson(json.decode(str));

String getAllFundTransferScheduleResponseToJson(
        GetAllFundTransferScheduleResponse data) =>
    json.encode(data.toJson());

class GetAllFundTransferScheduleResponse extends Serializable {
  List<ScheduleDetailsDto>? completedScheduleDetailsDtos;
  List<ScheduleDetailsDto>? ongoingScheduleDetailsDtos;
  List<ScheduleDetailsDto>? upcomingScheduleDetailsDtos;
  List<ScheduleDetailsDto>? deletedScheduleDetailsDtos;

  GetAllFundTransferScheduleResponse({
     this.completedScheduleDetailsDtos,
     this.ongoingScheduleDetailsDtos,
     this.upcomingScheduleDetailsDtos,
     this.deletedScheduleDetailsDtos,
  });

  factory GetAllFundTransferScheduleResponse.fromJson(
          Map<String, dynamic> json) =>
      GetAllFundTransferScheduleResponse(
        completedScheduleDetailsDtos:json["completedScheduleDetailsDTOS"]!= null ? List<ScheduleDetailsDto>.from(
            json["completedScheduleDetailsDTOS"]
                .map((x) => ScheduleDetailsDto.fromJson(x))): [],
        ongoingScheduleDetailsDtos: json["ongoingScheduleDetailsDTOS"] != null ? List<ScheduleDetailsDto>.from(
            json["ongoingScheduleDetailsDTOS"]
                .map((x) => ScheduleDetailsDto.fromJson(x))): [],
        upcomingScheduleDetailsDtos: json["upcomingScheduleDetailsDTOS"] != null
            ? List<ScheduleDetailsDto>.from(json["upcomingScheduleDetailsDTOS"]
                .map((x) => ScheduleDetailsDto.fromJson(x)))
            : [],
        deletedScheduleDetailsDtos: json["deletedScheduleDetailsDTOS"] != null ? List<ScheduleDetailsDto>.from(
            json["deletedScheduleDetailsDTOS"]
                .map((x) => ScheduleDetailsDto.fromJson(x))): [],
      );

  Map<String, dynamic> toJson() => {
        "completedScheduleDetailsDTOS": List<dynamic>.from(
            completedScheduleDetailsDtos!.map((x) => x.toJson())),
        "ongoingScheduleDetailsDTOS": List<dynamic>.from(
            ongoingScheduleDetailsDtos!.map((x) => x.toJson())),
        "upcomingScheduleDetailsDTOS": List<dynamic>.from(
            upcomingScheduleDetailsDtos!.map((x) => x.toJson())),
        "deletedScheduleDetailsDTOS": List<dynamic>.from(
            deletedScheduleDetailsDtos!.map((x) => x.toJson())),
      };
}

class ScheduleDetailsDto {
  int? scheduleId;
  String? epicUserId;
  int? paymentInstrumentId;
  int? startDay;
  String? toAccountNo;
  String? toBankCode;
  String? toAccountName;
  String? scheduleSource;
  String? scheduleType;
  String? scheduleTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? frequency;
  String? transCategory;
  String? tranType;
  String? reference;
  double? amount;
  String? remarks;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? failCount;
  String? status;
  String? createdUser;
  String? modifiedUser;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? billerId;
  String? fromAccountNo;
  String? fromAccountName;
  String? billerLogoImage;
  int? noOfTransfers;

  ScheduleDetailsDto({
    this.scheduleId,
    this.epicUserId,
    this.paymentInstrumentId,
    this.startDay,
    this.toAccountNo,
    this.toBankCode,
    this.toAccountName,
    this.scheduleSource,
    this.scheduleType,
    this.scheduleTitle,
    this.startDate,
    this.endDate,
    this.frequency,
    this.transCategory,
    this.tranType,
    this.reference,
    this.amount,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobile,
    this.failCount,
    this.status,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
    this.billerId,
    this.fromAccountNo,
    this.fromAccountName,
    this.billerLogoImage,
    this.noOfTransfers,
  });

  factory ScheduleDetailsDto.fromJson(Map<String, dynamic> json) =>
      ScheduleDetailsDto(
        scheduleId: json["scheduleID"],
        epicUserId: json["epicUserId"],
        paymentInstrumentId: json["paymentInstrumentId"],
        startDay: json["startDay"],
        toAccountNo: json["toAccountNo"],
        toBankCode: json["toBankCode"],
        toAccountName: json["toAccountName"],
        scheduleSource: json["scheduleSource"],
        scheduleType: json["scheduleType"],
        scheduleTitle: json["scheduleTitle"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        frequency: json["frequency"],
        transCategory: json["transCategory"],
        tranType: json["tranType"],
        reference: json["reference"],
        amount: json["amount"],
        remarks: json["remarks"],
        beneficiaryEmail: json["beneficiaryEmail"],
        beneficiaryMobile: json["beneficiaryMobile"],
        failCount: json["failCount"],
        status: json["status"],
        createdUser: json["createdUser"],
        modifiedUser: json["modifiedUser"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        billerId: json["billerId"],
        fromAccountNo: json["fromAccountNo"],
        fromAccountName: json["fromAccountName"],
        billerLogoImage: json["billerLogoImage"],
        noOfTransfers: json["noOfTransfers"],
      );

  Map<String, dynamic> toJson() => {
        "scheduleID": scheduleId,
        "epicUserId": epicUserId,
        "paymentInstrumentId": paymentInstrumentId,
        "startDay": startDay,
        "toAccountNo": toAccountNo,
        "toBankCode": toBankCode,
        "toAccountName": toAccountName,
        "scheduleSource": scheduleSource,
        "scheduleType": scheduleType,
        "scheduleTitle": scheduleTitle,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "frequency": frequency,
        "transCategory": transCategory,
        "tranType": tranType,
        "reference": reference,
        "amount": amount,
        "remarks": remarks,
        "beneficiaryEmail": beneficiaryEmail,
        "beneficiaryMobile": beneficiaryMobile,
        "failCount": failCount,
        "status": status,
        "createdUser": createdUser,
        "modifiedUser": modifiedUser,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
        "billerId": billerId,
        "fromAccountNo": fromAccountNo,
        "fromAccountName": fromAccountName,
        "billerLogoImage": billerLogoImage,
        "noOfTransfers": noOfTransfers,
      };
}

// To parse this JSON data, do
//
//     final getAllFundTransferScheduleResponse = getAllFundTransferScheduleResponseFromJson(jsonString);

// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// GetAllFundTransferScheduleResponse getAllFundTransferScheduleResponseFromJson(String str) => GetAllFundTransferScheduleResponse.fromJson(json.decode(str));
//
// String getAllFundTransferScheduleResponseToJson(GetAllFundTransferScheduleResponse data) => json.encode(data.toJson());
//
// class GetAllFundTransferScheduleResponse extends Serializable{
//   List<ScheduleDetailsDto> completedScheduleDetailsDtos;
//   List<ScheduleDetailsDto> ongoingScheduleDetailsDtos;
//   List<ScheduleDetailsDto> upcomingScheduleDetailsDtos;
//   List<ScheduleDetailsDto> deletedScheduleDetailsDtos;
//
//   GetAllFundTransferScheduleResponse({
//     required this.completedScheduleDetailsDtos,
//     required this.ongoingScheduleDetailsDtos,
//     required this.upcomingScheduleDetailsDtos,
//     required this.deletedScheduleDetailsDtos,
//   });
//
//   factory GetAllFundTransferScheduleResponse.fromJson(Map<String, dynamic> json) => GetAllFundTransferScheduleResponse(
//     completedScheduleDetailsDtos: List<ScheduleDetailsDto>.from(json["completedScheduleDetailsDTOS"].map((x) => ScheduleDetailsDto.fromJson(x))),
//     ongoingScheduleDetailsDtos: List<ScheduleDetailsDto>.from(json["ongoingScheduleDetailsDTOS"].map((x) => ScheduleDetailsDto.fromJson(x))),
//     upcomingScheduleDetailsDtos: List<ScheduleDetailsDto>.from(json["upcomingScheduleDetailsDTOS"].map((x) => ScheduleDetailsDto.fromJson(x))),
//     deletedScheduleDetailsDtos: List<ScheduleDetailsDto>.from(json["deletedScheduleDetailsDTOS"].map((x) => ScheduleDetailsDto.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "completedScheduleDetailsDTOS": List<dynamic>.from(completedScheduleDetailsDtos.map((x) => x.toJson())),
//     "ongoingScheduleDetailsDTOS": List<dynamic>.from(ongoingScheduleDetailsDtos.map((x) => x.toJson())),
//     "upcomingScheduleDetailsDTOS": List<dynamic>.from(upcomingScheduleDetailsDtos.map((x) => x.toJson())),
//     "deletedScheduleDetailsDTOS": List<dynamic>.from(deletedScheduleDetailsDtos.map((x) => x.toJson())),
//   };
// }
//
// class ScheduleDetailsDto {
//   String? tranType;
//   int? scheduleId;
//   String? epicUserId;
//   int? paymentInstrumentId;
//   int? startDay;
//   String? toAccountNo;
//   String? toBankCode;
//   String? toAccountName;
//   String? scheduleSource;
//   String? scheduleType;
//   String? scheduleTitle;
//   DateTime? startDate;
//   DateTime? endDate;
//   String? frequency;
//   String? transCategory;
//   String? reference;
//   int? amount;
//   String? remarks;
//   String? beneficiaryEmail;
//   String? beneficiaryMobile;
//   int? failCount;
//   String? status;
//   String? createdUser;
//   String? modifiedUser;
//   DateTime? createdDate;
//   DateTime? modifiedDate;
//   String? billerId;
//   String? fromAccountNo;
//   String? fromAccountName;
//
//   ScheduleDetailsDto({
//     required this.tranType,
//     required this.scheduleId,
//     required this.epicUserId,
//     required this.paymentInstrumentId,
//     required this.startDay,
//     required this.toAccountNo,
//     required this.toBankCode,
//     required this.toAccountName,
//     required this.scheduleSource,
//     required this.scheduleType,
//     required this.scheduleTitle,
//     required this.startDate,
//     required this.endDate,
//     required this.frequency,
//     required this.transCategory,
//     required this.reference,
//     required this.amount,
//     this.remarks,
//     required this.beneficiaryEmail,
//     required this.beneficiaryMobile,
//     required this.failCount,
//     required this.status,
//     required this.createdUser,
//     required this.modifiedUser,
//     required this.createdDate,
//     required this.modifiedDate,
//     this.billerId,
//     required this.fromAccountNo,
//     required this.fromAccountName,
//   });
//
//   factory ScheduleDetailsDto.fromJson(Map<String, dynamic> json) => ScheduleDetailsDto(
//     tranType: json["tranType"],
//     scheduleId: json["scheduleID"],
//     epicUserId: json["epicUserId"],
//     paymentInstrumentId: json["paymentInstrumentId"],
//     startDay: json["startDay"],
//     toAccountNo: json["toAccountNo"],
//     toBankCode: json["toBankCode"],
//     toAccountName: json["toAccountName"],
//     scheduleSource: json["scheduleSource"],
//     scheduleType: json["scheduleType"],
//     scheduleTitle: json["scheduleTitle"],
//     startDate: DateTime.parse(json["startDate"]),
//     endDate: DateTime.parse(json["endDate"]),
//     frequency: json["frequency"],
//     transCategory: json["transCategory"],
//     reference: json["reference"],
//     amount: json["amount"],
//     remarks: json["remarks"],
//     beneficiaryEmail: json["beneficiaryEmail"],
//     beneficiaryMobile: json["beneficiaryMobile"],
//     failCount: json["failCount"],
//     status: json["status"],
//     createdUser: json["createdUser"],
//     modifiedUser: json["modifiedUser"],
//     createdDate: DateTime.parse(json["createdDate"]),
//     modifiedDate: DateTime.parse(json["modifiedDate"]),
//     billerId: json["billerId"],
//     fromAccountNo: json["fromAccountNo"],
//     fromAccountName: json["fromAccountName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "tranType": tranType,
//     "scheduleID": scheduleId,
//     "epicUserId": epicUserId,
//     "paymentInstrumentId": paymentInstrumentId,
//     "startDay": startDay,
//     "toAccountNo": toAccountNo,
//     "toBankCode": toBankCode,
//     "toAccountName": toAccountName,
//     "scheduleSource": scheduleSource,
//     "scheduleType": scheduleType,
//     "scheduleTitle": scheduleTitle,
//     "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//     "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//     "frequency": frequency,
//     "transCategory": transCategory,
//     "reference": reference,
//     "amount": amount,
//     "remarks": remarks,
//     "beneficiaryEmail": beneficiaryEmail,
//     "beneficiaryMobile": beneficiaryMobile,
//     "failCount": failCount,
//     "status": status,
//     "createdUser": createdUser,
//     "modifiedUser": modifiedUser,
//     "createdDate": createdDate!.toIso8601String(),
//     "modifiedDate": modifiedDate!.toIso8601String(),
//     "billerId": billerId,
//     "fromAccountNo": fromAccountNo,
//     "fromAccountName": fromAccountName,
//   };
// }
