// // To parse this JSON data, do
// //
// //     final getSavedBillersResponse = getSavedBillersResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import '../common/base_response.dart';
//
// class GetSavedBillersResponse extends Serializable {
//   GetSavedBillersResponse({
//     this.billerList,
//     this.favoriteBillerList,
//   });
//
//   List<BillerList>? billerList;
//   List<BillerList>? favoriteBillerList;
//
//   factory GetSavedBillersResponse.fromRawJson(String str) => GetSavedBillersResponse.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GetSavedBillersResponse.fromJson(Map<String, dynamic> json) => GetSavedBillersResponse(
//     billerList: List<BillerList>.from(json["billerList"].map((x) => BillerList.fromJson(x))),
//     favoriteBillerList: List<BillerList>.from(json["favoriteBillerList"].map((x) => BillerList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "billerList": List<dynamic>.from(billerList!.map((x) => x.toJson())),
//     "favoriteBillerList": List<dynamic>.from(favoriteBillerList!.map((x) => x.toJson())),
//   };
// }
//
// class BillerList {
//   BillerList({
//     this.id,
//     this.nickName,
//     this.userId,
//     this.referenceNumber,
//     this.categoryCode,
//     this.categoryId,
//     this.serviceProviderId,
//     this.serviceProviderCode,
//     this.serviceProviderName,
//     this.chargeCode,
//     this.isFavourite,
//     this.categoryName,
//     this.customFieldList,
//     this.imageUrl,
//     this.sortId
//   });
//
//   int? id;
//   String? nickName;
//   String? userId;
//   String? referenceNumber;
//   String? categoryCode;
//   int? categoryId;
//   int? serviceProviderId;
//   String? serviceProviderCode;
//   String? serviceProviderName;
//   ChargeCode? chargeCode;
//   bool? isFavourite;
//   String? categoryName;
//   List<CustomFieldList>? customFieldList;
//   String? imageUrl;
//   int? sortId;
//
//   factory BillerList.fromRawJson(String str) => BillerList.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory BillerList.fromJson(Map<String, dynamic> json) => BillerList(
//     id: json["id"],
//     nickName: json["nickName"],
//     userId: json["userId"],
//     referenceNumber: json["referenceNumber"],
//     categoryCode: json["categoryCode"],
//     categoryId: json["categoryId"],
//     serviceProviderId: json["serviceProviderId"],
//     serviceProviderCode: json["serviceProviderCode"],
//     serviceProviderName: json["serviceProviderName"],
//     chargeCode: json["chargeCode"]!=null?ChargeCode.fromJson(json["chargeCode"]):ChargeCode(),
//     isFavourite: json["isFavourite"],
//     categoryName: json["categoryName"],
//     imageUrl: json["imageUrl"],
//     customFieldList: List<CustomFieldList>.from(json["customFieldList"].map((x) => CustomFieldList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "nickName": nickName,
//     "userId": userId,
//     "referenceNumber": referenceNumber,
//     "categoryCode": categoryCode,
//     "categoryId": categoryId,
//     "serviceProviderId": serviceProviderId,
//     "serviceProviderCode": serviceProviderCode,
//     "serviceProviderName": serviceProviderName,
//     "chargeCode": chargeCode!.toJson(),
//     "isFavourite": isFavourite,
//     "categoryName": categoryName,
//     "imageUrl": imageUrl,
//     "customFieldList": List<dynamic>.from(customFieldList!.map((x) => x.toJson())),
//   };
// }
//
// class ChargeCode {
//   ChargeCode({
//     this.chargeCode,
//     this.chargeAmount,
//   });
//
//   String? chargeCode;
//   double? chargeAmount;
//
//   factory ChargeCode.fromRawJson(String str) => ChargeCode.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ChargeCode.fromJson(Map<String, dynamic> json) => ChargeCode(
//     chargeCode: json["chargeCode"]??'',
//     chargeAmount: json["chargeAmount"]!=null?double.parse(json["chargeAmount"].toString()):0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "chargeCode": chargeCode,
//     "chargeAmount": chargeAmount,
//   };
// }
//
// class CustomFieldList {
//   CustomFieldList({
//     this.customFieldId,
//     this.customFieldValue,
//     this.customFieldName,
//     this.customFieldDetails,
//   });
//
//   int? customFieldId;
//   String? customFieldValue;
//   String? customFieldName;
//   CustomFieldDetails? customFieldDetails;
//
//   factory CustomFieldList.fromRawJson(String str) => CustomFieldList.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory CustomFieldList.fromJson(Map<String, dynamic> json) => CustomFieldList(
//     customFieldId: json["customFieldId"],
//     customFieldValue: json["customFieldValue"],
//     customFieldName: json["customFieldName"],
//     customFieldDetails: CustomFieldDetails.fromJson(json["customFieldDetails"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "customFieldId": customFieldId,
//     "customFieldValue": customFieldValue,
//     "customFieldName": customFieldName,
//     "customFieldDetails": customFieldDetails!.toJson(),
//   };
// }
//
// class CustomFieldDetails {
//   CustomFieldDetails({
//     this.id,
//     this.name,
//     this.validation,
//     this.length,
//     this.fieldType,
//   });
//
//   int? id;
//   String? name;
//   String? validation;
//   String? length;
//   FieldType? fieldType;
//
//   factory CustomFieldDetails.fromRawJson(String str) => CustomFieldDetails.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory CustomFieldDetails.fromJson(Map<String, dynamic> json) => CustomFieldDetails(
//     id: json["id"],
//     name: json["name"],
//     validation: json["validation"],
//     length: json["length"],
//     fieldType: FieldType.fromJson(json["fieldType"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "validation": validation,
//     "length": length,
//     "fieldType": fieldType!.toJson(),
//   };
// }
//
// class FieldType {
//   FieldType({
//     this.id,
//     this.name,
//   });
//
//   int? id;
//   String? name;
//
//   factory FieldType.fromRawJson(String str) => FieldType.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory FieldType.fromJson(Map<String, dynamic> json) => FieldType(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }


// To parse this JSON data, do
//
//     final getSavedBillersResponse = getSavedBillersResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final getSavedBillersResponse = getSavedBillersResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetSavedBillersResponse getSavedBillersResponseFromJson(String str) => GetSavedBillersResponse.fromJson(json.decode(str));

String getSavedBillersResponseToJson(GetSavedBillersResponse data) => json.encode(data.toJson());

class GetSavedBillersResponse extends Serializable {
  List<BillerList>? billerList;
  List<BillerList>? favoriteBillerList;

  GetSavedBillersResponse({
    this.billerList,
    this.favoriteBillerList,
  });

  factory GetSavedBillersResponse.fromJson(Map<String, dynamic> json) => GetSavedBillersResponse(
    billerList: List<BillerList>.from(json["billerList"].map((x) => BillerList.fromJson(x))),
    favoriteBillerList: List<BillerList>.from(json["favoriteBillerList"].map((x) => BillerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "billerList": List<dynamic>.from(billerList!.map((x) => x.toJson())),
    "favoriteBillerList": List<dynamic>.from(favoriteBillerList!.map((x) => x.toJson())),
  };
}

class BillerList {
  int? billerIsFave;
  int? id;
  String? nickName;
  String? status;
  String? referenceNumber;
  String? categoryCode;
  int? categoryId;
  int? serviceProviderId;
  String? serviceProviderCode;
  String? serviceProviderName;
  String? imageUrl;
  ChargeCode? chargeCode;
  bool? isFavourite;
  String? categoryName;
  double? serviceCharge;
  String? value;

  BillerList({
    this.id,
    this.nickName,
    this.status,
    this.referenceNumber,
    this.categoryCode,
    this.categoryId,
    this.serviceProviderId,
    this.serviceProviderCode,
    this.serviceProviderName,
    this.imageUrl,
    this.chargeCode,
    this.isFavourite,
    this.categoryName,
    this.serviceCharge,
    this.value,
    this.billerIsFave,
  });

  factory BillerList.fromJson(Map<String, dynamic> json) => BillerList(
    id: json["id"],
    nickName: json["nickName"] ?? "-",
    status: json["status"],
    referenceNumber: json["referenceNumber"],
    categoryCode: json["categoryCode"],
    categoryId: json["categoryId"],
    serviceProviderId: json["serviceProviderId"],
    serviceProviderCode: json["serviceProviderCode"],
    serviceProviderName: json["serviceProviderName"],
    imageUrl: json["imageUrl"],
    chargeCode: ChargeCode.fromJson(json["chargeCode"]),
    isFavourite: json["isFavourite"],
    categoryName: json["categoryName"],
    serviceCharge: json["serviceCharge"],
    value: json["value"],
    billerIsFave: json["billerIsFave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "status": status,
    "referenceNumber": referenceNumber,
    "categoryCode": categoryCode,
    "categoryId": categoryId,
    "serviceProviderId": serviceProviderId,
    "serviceProviderCode": serviceProviderCode,
    "serviceProviderName": serviceProviderName,
    "imageUrl": imageUrl,
    "chargeCode": chargeCode?.toJson(),
    "isFavourite": isFavourite,
    "categoryName": categoryName,
    "serviceCharge": serviceCharge,
    "value": value,
    "billerIsFave": billerIsFave,
  };
}

class ChargeCode {
  ChargeCode();

  factory ChargeCode.fromJson(Map<String, dynamic> json) => ChargeCode(
  );

  Map<String, dynamic> toJson() => {
  };
}
