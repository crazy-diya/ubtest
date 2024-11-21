// To parse this JSON data, do
//
//     final submitProductsResponse = submitProductsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

class SubmitProductsResponse extends Serializable{
  SubmitProductsResponse({
    this.data,
  });

  List<int>? data;

  factory SubmitProductsResponse.fromRawJson(String str) => SubmitProductsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitProductsResponse.fromJson(Map<String, dynamic> json) => SubmitProductsResponse(
    data: List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
