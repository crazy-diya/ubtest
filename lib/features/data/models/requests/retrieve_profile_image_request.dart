// To parse this JSON data, do
//
//     final retrieveProfileImageRequest = retrieveProfileImageRequestFromJson(jsonString);

import 'dart:convert';

RetrieveProfileImageRequest retrieveProfileImageRequestFromJson(String str) => RetrieveProfileImageRequest.fromJson(json.decode(str));

String retrieveProfileImageRequestToJson(RetrieveProfileImageRequest data) => json.encode(data.toJson());

class RetrieveProfileImageRequest {
  String? imageKey;
  String? imageType;
  String? messageType;

  RetrieveProfileImageRequest({
    this.imageKey,
    this.imageType,
    this.messageType,
  });

  factory RetrieveProfileImageRequest.fromJson(Map<String, dynamic> json) => RetrieveProfileImageRequest(
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
