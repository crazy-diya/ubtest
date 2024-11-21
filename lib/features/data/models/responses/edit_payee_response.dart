import 'dart:convert';

import '../common/base_response.dart';

EditPayeeResponse editPayeeResponseFromJson(String str) => EditPayeeResponse.fromJson(json.decode(str));

String editPayeeResponseToJson(EditPayeeResponse data) => json.encode(data.toJson());

class EditPayeeResponse extends Serializable{
  EditPayeeResponse({
    this.id,
  });

  int? id;

  factory EditPayeeResponse.fromJson(Map<String, dynamic> json) => EditPayeeResponse(
    id: json["id"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
  };


}
