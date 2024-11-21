import 'dart:convert';
import 'package:union_bank_mobile/utils/extension.dart';
import '../common/base_response.dart';

GetTermsResponse getTermsResponseFromJson(String str) =>
    GetTermsResponse.fromJson(json.decode(str));

String getTermsResponseToJson(GetTermsResponse data) =>
    json.encode(data.toJson());

class GetTermsResponse extends Serializable {
  GetTermsResponse({
    this.data,
  });

  TermsData? data;

  factory GetTermsResponse.fromJson(Map<String, dynamic> json) =>
      GetTermsResponse(
        data: TermsData.fromJson(json),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class TermsData {
  TermsData({
    this.termId,
    this.termBody,
    this.termType,
    this.termVersion,
    this.termStatus,
    this.createdDate,
    this.modifiedDate,
  });

  int? termId;
  String? termBody;
  String? termType;
  String? termVersion;
  String? termStatus;
  DateTime? createdDate;
  DateTime? modifiedDate;

  factory TermsData.fromJson(Map<String, dynamic> json) => TermsData(
        termId: json["termId"],
        termBody:json["termBody"]!=null?json["termBody"].toString().base64ToString():"",
        termType: json["termType"],
        termVersion: json["termVersion"],
        termStatus: json["termStatus"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "termId": termId,
        "termBody": termBody,
        "termType": termType,
        "termVersion": termVersion,
        "termStatus": termStatus,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
      };
}
