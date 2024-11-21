// To parse this JSON data, do
//
//     final imageApiRequest = imageApiRequestFromJson(jsonString);

import 'dart:convert';

ImageApiRequestModel imageApiRequestModelFromJson(String str) =>
    ImageApiRequestModel.fromJson(json.decode(str));

String imageApiRequestToJson(ImageApiRequestModel data) =>
    json.encode(data.toJson());

class ImageApiRequestModel {
  ImageApiRequestModel({
    this.imageKey,
    this.imageType,
    this.messageType,
  });

  String? imageKey;
  String? imageType;
  String? messageType;

  factory ImageApiRequestModel.fromJson(Map<String, dynamic> json) =>
      ImageApiRequestModel(
        imageKey: json["imageKey"],
        imageType: json["imageType"],
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "imageKey": imageKey,
        "imageType": imageType,
        "messageType": messageType,
      };
}
