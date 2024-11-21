// To parse this JSON data, do
//
//     final editUserBillerResponse = editUserBillerResponseFromJson(jsonString);

import 'dart:convert';


import '../common/base_response.dart';

EditUserBillerResponse editUserBillerResponseFromJson(String str) => EditUserBillerResponse.fromJson(json.decode(str));

String editUserBillerResponseToJson(EditUserBillerResponse data) => json.encode(data.toJson());

class EditUserBillerResponse extends Serializable{
  EditUserBillerResponse({
    this.id,
    //this.customFieldList
  });

  int? id;
  //List<CustomFieldList>? customFieldList;

  factory EditUserBillerResponse.fromRawJson(String str) => EditUserBillerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditUserBillerResponse.fromJson(Map<String, dynamic> json) => EditUserBillerResponse(
    id: json["id"],
    //customFieldList: List<CustomFieldList>.from(json["customFieldList"].map((x) => CustomFieldList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
