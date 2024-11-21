// To parse this JSON data, do
//
//     final interestedProductAddRequest = interestedProductAddRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

InterestedProductAddRequest interestedProductAddRequestFromJson(String str) => InterestedProductAddRequest.fromJson(json.decode(str));

String interestedProductAddRequestToJson(InterestedProductAddRequest data) => json.encode(data.toJson());

class InterestedProductAddRequest extends Equatable {
  const InterestedProductAddRequest({
    this.messageType,
    this.products,
  });

  final String? messageType;
  final List<String>? products;

  factory InterestedProductAddRequest.fromJson(Map<String, dynamic> json) => InterestedProductAddRequest(
        messageType: json["messageType"],
        products: List<String>.from(json["products"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "products": List<dynamic>.from(products!.map((x) => x)),
      };

  @override
  List<Object?> get props => [messageType, products];
}
