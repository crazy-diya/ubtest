// To parse this JSON data, do
//
//     final submitProductsRequest = submitProductsRequestFromJson(jsonString);

import 'dart:convert';

class SubmitProductsRequest {
  SubmitProductsRequest({
    this.messageType,
    this.products,
  });

  String? messageType;
  List<int?>? products;

  factory SubmitProductsRequest.fromRawJson(String str) => SubmitProductsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitProductsRequest.fromJson(Map<String, dynamic> json) => SubmitProductsRequest(
    messageType: json["messageType"],
    products: List<int>.from(json["products"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "products": List<dynamic>.from(products!.map((x) => x)),
  };
}
