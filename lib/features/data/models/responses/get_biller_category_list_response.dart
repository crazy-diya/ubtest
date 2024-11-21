// To parse this JSON data, do
//
//     final getBillerCategoryListResponse = getBillerCategoryListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetBillerCategoryListResponse getBillerCategoryListResponseFromJson(String str) => GetBillerCategoryListResponse.fromJson(json.decode(str));

String getBillerCategoryListResponseToJson(GetBillerCategoryListResponse data) => json.encode(data.toJson());

class GetBillerCategoryListResponse extends Serializable {
  List<Datum>? data;

  GetBillerCategoryListResponse({
    this.data,
  });

  factory GetBillerCategoryListResponse.fromJson(Map<String, dynamic> json) => GetBillerCategoryListResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? code;
  String? description;
  String? name;
  String? status;
  String? createdUser;
  String? modifiedUser;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? logoUrl;
  List<DbpBspMetaCollection>? dbpBspMetaCollection;

  Datum({
    this.id,
    this.code,
    this.description,
    this.name,
    this.status,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
    this.logoUrl,
    this.dbpBspMetaCollection,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    description: json["description"],
    name: json["name"],
    status: json["status"],
    createdUser: json["createdUser"],
    modifiedUser: json["modifiedUser"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    logoUrl: json["logoUrl"],
    dbpBspMetaCollection: List<DbpBspMetaCollection>.from(json["dbpBspMetaCollection"].map((x) => DbpBspMetaCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
    "name": name,
    "status": status,
    "createdUser": createdUser,
    "modifiedUser": modifiedUser,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate?.toIso8601String(),
    "logoUrl":logoUrl,
    "dbpBspMetaCollection": List<dynamic>.from(dbpBspMetaCollection!.map((x) => x.toJson())),
  };
}

class DbpBspMetaCollection {
  int? id;
  String? name;
  String? description;
  String? displayName;
  String? collectionAccount;
  String? status;
  DateTime? createdDate;
  String? imageUrl;
  bool? isAggregator;
  String? aggregator;
  String? referenceSample;
  String? referencePattern;
  double? serviceCharge;
  // List<DbpBspMetaCustomFieldCollection>? dbpBspMetaCustomFieldCollection;

  DbpBspMetaCollection({
    this.id,
    this.name,
    this.description,
    this.displayName,
    this.collectionAccount,
    this.status,
    this.createdDate,
    this.imageUrl,
    this.isAggregator,
    this.aggregator,
    this.referenceSample,
    this.referencePattern,
    this.serviceCharge
    // this.dbpBspMetaCustomFieldCollection,
  });

  factory DbpBspMetaCollection.fromJson(Map<String, dynamic> json) => DbpBspMetaCollection(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    displayName: json["displayName"],
    collectionAccount: json["collectionAccount"],
    status: json["status"],
    createdDate: DateTime.parse(json["createdDate"]),
    imageUrl: json["imageUrl"],
    isAggregator: json["isAggregator"],
    aggregator: json["aggregator"],
    referenceSample: json["referenceSample"],
    referencePattern: json["referencePattern"],
    serviceCharge:json["serviceCharge"]
    // dbpBspMetaCustomFieldCollection: List<DbpBspMetaCustomFieldCollection>.from(json["dbpBspMetaCustomFieldCollection"].map((x) => DbpBspMetaCustomFieldCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "displayName": displayName,
    "collectionAccount": collectionAccount,
    "status": status,
    "createdDate": createdDate?.toIso8601String(),
    "imageUrl": imageUrl,
    "isAggregator": isAggregator,
    "aggregator": aggregator,
    "referenceSample": referenceSample,
    "referencePattern": referencePattern,
    "serviceCharge":serviceCharge
    // "dbpBspMetaCustomFieldCollection": List<dynamic>.from(dbpBspMetaCustomFieldCollection!.map((x) => x.toJson())),
  };
}

class FieldType {
  int? id;
  String? name;

  FieldType({
    this.id,
    this.name,
  });

  factory FieldType.fromJson(Map<String, dynamic> json) => FieldType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
