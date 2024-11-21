// To parse this JSON data, do
//
//     final promotionsResponse = promotionsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PromotionsResponse promotionsResponseFromJson(String str) => PromotionsResponse.fromJson(json.decode(str));

String promotionsResponseToJson(PromotionsResponse data) => json.encode(data.toJson());

class PromotionsResponse extends Serializable{
  final List<PromotionList>? promotionList;
  final List<Category>? categories;

  PromotionsResponse({
    this.promotionList,
    this.categories,
  });

  factory PromotionsResponse.fromJson(Map<String, dynamic> json) => PromotionsResponse(
    promotionList: json["promotionList"] == null ? [] : List<PromotionList>.from(json["promotionList"]!.map((x) => PromotionList.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  @override
  Map<String, dynamic> toJson() => {
    "promotionList": promotionList == null ? [] : List<dynamic>.from(promotionList!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  final int? id;
  final String? code;
  final String? description;

  Category({
    this.id,
    this.code,
    this.description,
  });

  Category copyWith({
    int? id,
    String? code,
    String? description,
  }) =>
      Category(
        id: id ?? this.id,
        code: code ?? this.code,
        description: description ?? this.description,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    code: json["code"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
  };
}

class PromotionList {
  final int? id;
  final String? code;
  final DateTime? expiryDate;
  final String? typeCode;
  final String? typeDescription;
  final bool? pushNotification;
  // final List<CustomerSegment>? customerSegment;
  final String? subject;
  final String? body;
  final String? shortDes;
  final double? longitude;
  final double? latitude;
  final bool? preLogin;
  final String? status;
  final String? channel;
  final List<PromoImage>? images;
  final String? createdUser;
  final String? modifiedUser;
  final DateTime? createdDate;
  final DateTime? modifiedDate;

  PromotionList({
    this.id,
    this.code,
    this.expiryDate,
    this.typeCode,
    this.typeDescription,
    this.pushNotification,
    // this.customerSegment,
    this.subject,
    this.body,
    this.shortDes,
    this.longitude,
    this.latitude,
    this.preLogin,
    this.status,
    this.channel,
    this.images,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
  });

  PromotionList copyWith({
    int? id,
    String? code,
    DateTime? expiryDate,
    String? typeCode,
    String? typeDescription,
    bool? pushNotification,
    List<String>? customerSegment,
    String? subject,
    String? body,
    String? shortDes,
    bool? preLogin,
    String? status,
    String? channel,
    List<PromoImage>? images,
    String? createdUser,
    String? modifiedUser,
    DateTime? createdDate,
    DateTime? modifiedDate,
  }) =>
      PromotionList(
        id: id ?? this.id,
        code: code ?? this.code,
        expiryDate: expiryDate ?? this.expiryDate,
        typeCode: typeCode ?? this.typeCode,
        typeDescription: typeDescription ?? this.typeDescription,
        pushNotification: pushNotification ?? this.pushNotification,
        subject: subject ?? this.subject,
        body: body ?? this.body,
        shortDes: shortDes ?? this.shortDes,
        preLogin: preLogin ?? this.preLogin,
        status: status ?? this.status,
        channel: channel ?? this.channel,
        images: images ?? this.images,
        createdUser: createdUser ?? this.createdUser,
        modifiedUser: modifiedUser ?? this.modifiedUser,
        createdDate: createdDate ?? this.createdDate,
        modifiedDate: modifiedDate ?? this.modifiedDate,
      );

  factory PromotionList.fromJson(Map<String, dynamic> json) => PromotionList(
    id: json["id"],
    code: json["code"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    typeCode: json["typeCode"],
    typeDescription: json["typeDescription"],
    pushNotification: json["pushNotification"],
    // customerSegment: json["customerSegment"] == null ? [] : List<CustomerSegment>.from(json["customerSegment"]!.map((x) => CustomerSegment.fromJson(x))),
    subject: json["subject"],
    body: json["body"],
    shortDes: json["shortDes"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    preLogin: json["preLogin"],
    status: json["status"],
    channel: json["channel"],
    images: json["images"] == null ? [] : List<PromoImage>.from(json["images"]!.map((x) => PromoImage.fromJson(x))),
    createdUser: json["createdUser"],
    modifiedUser: json["modifiedUser"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "expiryDate": "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
    "typeCode": typeCode,
    "typeDescription": typeDescription,
    "pushNotification": pushNotification,
    // "customerSegment": customerSegment == null ? [] : List<dynamic>.from(customerSegment!.map((x) => x.toJson())),
    "subject": subject,
    "body": body,
    "shortDes": shortDes,
    "longitude": longitude,
    "latitude": latitude,
    "preLogin": preLogin,
    "status": status,
    "channel": channel,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "createdUser": createdUser,
    "modifiedUser": modifiedUser,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate?.toIso8601String(),
  };
}

class CustomerSegment {
  final String? code;
  final String? description;
  final String? status;

  CustomerSegment({
    this.code,
    this.description,
    this.status,
  });

  factory CustomerSegment.fromJson(Map<String, dynamic> json) => CustomerSegment(
    code: json["code"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "status": status,
  };
}

class PromoImage {
  final int? id;
  final String? type;
  final String? imageKey;

  PromoImage({
    this.id,
    this.type,
    this.imageKey,
  });

  PromoImage copyWith({
    int? id,
    String? type,
    String? imageKey,
  }) =>
      PromoImage(
        id: id ?? this.id,
        type: type ?? this.type,
        imageKey: imageKey ?? this.imageKey,
      );

  factory PromoImage.fromJson(Map<String, dynamic> json) => PromoImage(
    id: json["id"],
    type: json["type"],
    imageKey: json["imageKey"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "imageKey": imageKey,
  };
}
