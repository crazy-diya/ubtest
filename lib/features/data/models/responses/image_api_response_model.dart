// To parse this JSON data, do
//
//     final imageApiResponse = imageApiResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ImageApiResponseModel imageApiResponseModelFromJson(String str) => ImageApiResponseModel.fromJson(json.decode(str));

String imageApiResponseModelToJson(ImageApiResponseModel data) => json.encode(data.toJson());

class ImageApiResponseModel extends Serializable{
  ImageApiResponseModel({
    this.imageKey,
    this.imageType,
    this.image,
  });

  String? imageKey;
  String? imageType;
  String? image;

  factory ImageApiResponseModel.fromJson(Map<String, dynamic> json) => ImageApiResponseModel(
    imageKey: json["imageKey"],
    imageType: json["imageType"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "imageKey": imageKey,
    "imageType": imageType,
    "image": image,
  };
}
