// // To parse this JSON data, do
// //
// //     final deleteBillerRequest = deleteBillerRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// DeleteBillerRequest deleteBillerRequestFromJson(String str) => DeleteBillerRequest.fromJson(json.decode(str));
//
// String deleteBillerRequestToJson(DeleteBillerRequest data) => json.encode(data.toJson());
//
// class DeleteBillerRequest {
//   String? messageType;
//   List<int>? customFields;
//
//   DeleteBillerRequest({
//     this.messageType,
//     this.customFields,
//   });
//
//   factory DeleteBillerRequest.fromJson(Map<String, dynamic> json) => DeleteBillerRequest(
//     messageType: json["messageType"],
//     customFields: List<int>.from(json["customFields"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "customFields": List<dynamic>.from(customFields!.map((x) => x)),
//   };
// }


// To parse this JSON data, do
//
//     final deleteBillerRequest = deleteBillerRequestFromJson(jsonString);

import 'dart:convert';

DeleteBillerRequest deleteBillerRequestFromJson(String str) => DeleteBillerRequest.fromJson(json.decode(str));

String deleteBillerRequestToJson(DeleteBillerRequest data) => json.encode(data.toJson());

class DeleteBillerRequest {
  String? messageType;
  List<int>? billerIds;

  DeleteBillerRequest({
    this.messageType,
    this.billerIds,
  });

  factory DeleteBillerRequest.fromJson(Map<String, dynamic> json) => DeleteBillerRequest(
    messageType: json["messageType"],
    billerIds: List<int>.from(json["billerIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "billerIds": List<dynamic>.from(billerIds!.map((x) => x)),
  };
}

