// To parse this JSON data, do
//
//     final retrieveProfileImageResponse = retrieveProfileImageResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

RetrieveProfileImageResponse retrieveProfileImageResponseFromJson(String str) => RetrieveProfileImageResponse.fromJson(json.decode(str));

String retrieveProfileImageResponseToJson(RetrieveProfileImageResponse data) => json.encode(data.toJson());

class RetrieveProfileImageResponse extends Serializable{
  String? imageKey;
  String? imageType;
  String? image;
  String? dataType;

  RetrieveProfileImageResponse({
    this.imageKey,
    this.imageType,
    this.image,
    this.dataType,
  });

  factory RetrieveProfileImageResponse.fromJson(Map<String, dynamic> json) => RetrieveProfileImageResponse(
    imageKey: json["imageKey"],
    imageType: json["imageType"],
    image: json["image"],
    dataType: json["dataType"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "imageKey": imageKey,
    "imageType": imageType,
    "image": image,
    "dataType": dataType,
  };
}
