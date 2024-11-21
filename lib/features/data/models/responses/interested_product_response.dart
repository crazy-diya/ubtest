// To parse this JSON data, do
//
//     final interestedProductResponse = interestedProductResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

InterestedProductResponse interestedProductResponseFromJson(String str) => InterestedProductResponse.fromJson(json.decode(str));

String interestedProductResponseToJson(InterestedProductResponse data) => json.encode(data.toJson());

class InterestedProductResponse extends Serializable {
  InterestedProductResponse({
    this.data,
  }) : super();

  List<InterestedProduct>? data;

  factory InterestedProductResponse.fromJson(Map<String, dynamic> json) => InterestedProductResponse(
        data: List<InterestedProduct>.from(json['data'].map((x) => InterestedProduct.fromJson(x))).toList(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

class InterestedProduct {
  InterestedProduct({
    this.id,
    this.description,
  });

  final int? id;
  final String? description;

  factory InterestedProduct.fromJson(Map<String, dynamic> json) => InterestedProduct(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
