// To parse this JSON data, do
//
//     final addBillerResponse = addBillerResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

class AddBillerResponse extends Serializable{
  AddBillerResponse({
    this.id,
  });

   final int? id;

  factory AddBillerResponse.fromRawJson(String str) => AddBillerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBillerResponse.fromJson(Map<String, dynamic> json) => AddBillerResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}


