// To parse this JSON data, do
//
//     final updateProfileImageRequest = updateProfileImageRequestFromJson(jsonString);

import 'dart:convert';

UpdateProfileImageRequest updateProfileImageRequestFromJson(String str) =>
    UpdateProfileImageRequest.fromJson(json.decode(str));

String updateProfileImageRequestToJson(UpdateProfileImageRequest data) =>
    json.encode(data.toJson());

class UpdateProfileImageRequest {
  UpdateProfileImageRequest({
    this.messageType,
    this.image,
  });

  String? messageType;
  String? image;

  factory UpdateProfileImageRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileImageRequest(
        messageType: json["messageType"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "image": image,
      };
}
