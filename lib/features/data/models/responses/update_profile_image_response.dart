// To parse this JSON data, do
//
//     final updateProfileImageResponse = updateProfileImageResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

UpdateProfileImageResponse updateProfileImageResponseFromJson(String str) =>
    UpdateProfileImageResponse.fromJson(json.decode(str));

String updateProfileImageResponseToJson(UpdateProfileImageResponse data) =>
    json.encode(data.toJson());

class UpdateProfileImageResponse extends Serializable {
  UpdateProfileImageResponse({
    this.attachmentKey,
  });

  String? attachmentKey;

  factory UpdateProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileImageResponse(
        attachmentKey: json["attachmentKey"],
      );

  Map<String, dynamic> toJson() => {
        "attachmentKey": attachmentKey,
      };
}
