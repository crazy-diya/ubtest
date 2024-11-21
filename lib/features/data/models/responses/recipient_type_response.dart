// import 'dart:convert';

// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

// RecipientTypeResponse recipientTypeResponseFromJson(String str) => RecipientTypeResponse.fromJson(json.decode(str));

// String recipientTypeResponseToJson(RecipientTypeResponse data) => json.encode(data.toJson());

// class RecipientTypeResponse extends Serializable{
//     final List<RecipientTypeData>? recipientTypeData;

//     RecipientTypeResponse({
//         this.recipientTypeData,
//     });

//     factory RecipientTypeResponse.fromJson(Map<String, dynamic> json) => RecipientTypeResponse(
//         recipientTypeData: json["requestTypeList"] == null ? [] : List<RecipientTypeData>.from(json["requestTypeList"]!.map((x) => RecipientTypeData.fromJson(x))),
//     );

//     @override
//       Map<String, dynamic> toJson() => {
//         "requestTypeList": recipientTypeData == null ? [] : List<dynamic>.from(recipientTypeData!.map((x) => x.toJson())),
//     };
// }

// class RecipientTypeData {
//     final String? reqTypeCode;
//     final String? reqTypeDescription;
//     final String? status;

//     RecipientTypeData({
//         this.reqTypeCode,
//         this.reqTypeDescription,
//         this.status,
//     });

//     factory RecipientTypeData.fromJson(Map<String, dynamic> json) => RecipientTypeData(
//         reqTypeCode: json["reqTypeCode"],
//         reqTypeDescription: json["reqTypeDescription"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "reqTypeCode": reqTypeCode,
//         "reqTypeDescription": reqTypeDescription,
//         "status": status,
//     };
// }

// To parse this JSON data, do
//
//     final recipientTypeResponse = recipientTypeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

RecipientTypeResponse recipientTypeResponseFromJson(String str) => RecipientTypeResponse.fromJson(json.decode(str));

String recipientTypeResponseToJson(RecipientTypeResponse data) => json.encode(data.toJson());

class RecipientTypeResponse extends Serializable{
    final List<RecipientTypeData>? responseRecipientTypeList;

    RecipientTypeResponse({
        this.responseRecipientTypeList,
    });

    factory RecipientTypeResponse.fromJson(Map<String, dynamic> json) => RecipientTypeResponse(
        responseRecipientTypeList: json["responseRecipientTypeList"] == null ? [] : List<RecipientTypeData>.from(json["responseRecipientTypeList"]!.map((x) => RecipientTypeData.fromJson(x))),
    );

    @override
      Map<String, dynamic> toJson() => {
        "responseRecipientTypeList": responseRecipientTypeList == null ? [] : List<dynamic>.from(responseRecipientTypeList!.map((x) => x.toJson())),
    };
}

class RecipientTypeData {
    final String? typeCode;
    final String? typeName;
    final String? email;

    RecipientTypeData({
        this.typeCode,
        this.typeName,
        this.email,
    });

    factory RecipientTypeData.fromJson(Map<String, dynamic> json) => RecipientTypeData(
        typeCode: json["typeCode"],
        typeName: json["typeName"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "typeCode": typeCode,
        "typeName": typeName,
        "email": email,
    };
}

