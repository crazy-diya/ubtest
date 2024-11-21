// To parse this JSON data, do
//
//     final documentVerificationApiRequest = documentVerificationApiRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DocumentVerificationApiRequest extends Equatable{
  DocumentVerificationApiRequest({
    this.imageListData,
    this.messageType
  });

  List<ImageList>? imageListData;
  String? messageType;

  factory DocumentVerificationApiRequest.fromRawJson(String str) => DocumentVerificationApiRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentVerificationApiRequest.fromJson(Map<String, dynamic> json) => DocumentVerificationApiRequest(
    imageListData: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "imageList": List<dynamic>.from(imageListData!.map((x) => x.toJson())),
    "messageType": messageType,
  };

  @override
  List<Object> get props => imageListData!;
}

class ImageList {
  ImageList({
    this.name,
    this.image,
  });

  String? name;
  String? image;

  factory ImageList.fromRawJson(String str) => ImageList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
