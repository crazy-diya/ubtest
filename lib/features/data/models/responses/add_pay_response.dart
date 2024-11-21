import 'dart:convert';

import '../common/base_response.dart';

AddPayResponse addPayResponseFromJson(String str) =>
    AddPayResponse.fromJson(json.decode(str));

String addPayResponseToJson(AddPayResponse data) => json.encode(data.toJson());

class AddPayResponse extends Serializable {
  AddPayResponse({
    this.id,
  });

  int? id;

  factory AddPayResponse.fromJson(Map<String, dynamic> json) => AddPayResponse(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
