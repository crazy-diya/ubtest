



// To parse this JSON data, do
//
//     final floatInquiryResponse = floatInquiryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

FloatInquiryResponse floatInquiryResponseFromJson(String str) => FloatInquiryResponse.fromJson(json.decode(str));

String floatInquiryResponseToJson(FloatInquiryResponse data) => json.encode(data.toJson());

class FloatInquiryResponse extends Serializable{
    final List<FloatInquiryCbsResponseList>? floatInquiryCbsResponseList;

    FloatInquiryResponse({
        this.floatInquiryCbsResponseList,
    });

    factory FloatInquiryResponse.fromJson(Map<String, dynamic> json) => FloatInquiryResponse(
        floatInquiryCbsResponseList: json["floatInquiryCBSResponseList"] == null ? [] : List<FloatInquiryCbsResponseList>.from(json["floatInquiryCBSResponseList"]!.map((x) => FloatInquiryCbsResponseList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "floatInquiryCBSResponseList": floatInquiryCbsResponseList == null ? [] : List<dynamic>.from(floatInquiryCbsResponseList!.map((x) => x.toJson())),
    };
}

class FloatInquiryCbsResponseList {
    final String? cistat;
    final String? citype;
    final String? branch;
    final String? ssbnkn;
    final String? ciamt;
    final DateTime? cidat6;
    final String? cicnum;
    final String? cirtno;
    final String? cichg;
    final String? cipaye;
    final String? cirem;
    final DateTime? cicdt6;
    final DateTime? circv6;
    final String? cireas;
    final String? errorDes;
    final String? responseCode;
    final String? cifltt;

    FloatInquiryCbsResponseList({
        this.cistat,
        this.citype,
        this.branch,
        this.ssbnkn,
        this.ciamt,
        this.cidat6,
        this.cicnum,
        this.cirtno,
        this.cichg,
        this.cipaye,
        this.cirem,
        this.cicdt6,
        this.circv6,
        this.cireas,
        this.errorDes,
        this.responseCode,
        this.cifltt,
    });

    factory FloatInquiryCbsResponseList.fromJson(Map<String, dynamic> json) => FloatInquiryCbsResponseList(
        cistat: json["cistat"],
        citype: json["citype"],
        branch: json["branch"],
        ssbnkn: json["ssbnkn"],
        ciamt:  json["ciamt"],
        cidat6: DateTime.parse(
            json["cidat6"].toString().isDate() == true
                ? json["cidat6"]
                : json["cidat6"].toString().toValidDate()),
        cicnum: json["cicnum"],
        cirtno: json["cirtno"],
        cichg: json["cichg"],
        cipaye: json["cipaye"],
        cirem: json["cirem"],
        cicdt6:  DateTime.parse(
            json["cicdt6"].toString().isDate() == true
                ? json["cicdt6"]
                : json["cicdt6"].toString().toValidDate()),
        circv6: DateTime.parse(
            json["circv6"].toString().isDate() == true
                ? json["circv6"]
                : json["circv6"].toString().toValidDate()),
        cireas: json["cireas"],
        errorDes: json["errorDes"],
        responseCode: json["responseCode"],
        cifltt: json["cifltt"],
    );

    Map<String, dynamic> toJson() => {
        "cistat": cistat,
        "citype": citype,
        "branch": branch,
        "ssbnkn": ssbnkn,
        "ciamt": ciamt,
        "cidat6": cidat6,
        "cicnum": cicnum,
        "cirtno": cirtno,
        "cichg": cichg,
        "cipaye": cipaye,
        "cirem": cirem,
        "cicdt6": cicdt6,
        "circv6": circv6,
        "cireas": cireas,
        "errorDes": errorDes,
        "responseCode": responseCode,
        "cifltt": cifltt,
    };
}
