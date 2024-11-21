// ignore_for_file: public_member_api_docs, sort_constructors_first
// // To parse this JSON data, do
// //
// //     final addBillerRequest = addBillerRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// class AddBillerRequest {
//   AddBillerRequest({
//     this.nickName,
//     //this.accNumber,
//     this.serviceProviderId,
//     //this.fieldList,
//     this.messageType,
//     this.isFavourite,
//     this.value,
//   });
//
//   String? nickName;
//   //String? accNumber;
//   String? messageType;
//   int? serviceProviderId;
//   //List<FieldList>? fieldList;
//   bool? isFavourite;
//   String? value;
//
//   factory AddBillerRequest.fromRawJson(String str) => AddBillerRequest.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory AddBillerRequest.fromJson(Map<String, dynamic> json) => AddBillerRequest(
//     nickName: json["nickName"],
//     isFavourite: json["isFavourite"],
//     //accNumber: json["accNumber"],
//     messageType: json["messageType"],
//     serviceProviderId: json["serviceProviderId"],
//     value: json["value"],
//     //fieldList: List<FieldList>.from(json["fieldList"].map((x) => FieldList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isFavourite":isFavourite,
//     "nickName": nickName,
//     //"accNumber": accNumber,
//     "messageType": messageType,
//     "serviceProviderId": serviceProviderId,
//     "value": value,
//     //"fieldList": List<dynamic>.from(fieldList!.map((x) => x.toJson())),
//   };
// }
//
// class FieldList {
//   FieldList({
//     this.customFieldId,
//     this.customFieldValue,
//   });
//
//   String? customFieldId;
//   String? customFieldValue;
//
//   factory FieldList.fromRawJson(String str) => FieldList.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory FieldList.fromJson(Map<String, dynamic> json) => FieldList(
//     customFieldId: json["customFieldId"],
//     customFieldValue: json["customFieldValue"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "customFieldId": customFieldId,
//     "customFieldValue": customFieldValue,
//   };
// }



// To parse this JSON data, do
//
//     final addBillerRequest = addBillerRequestFromJson(jsonString);

import 'dart:convert';

AddBillerRequest addBillerRequestFromJson(String str) => AddBillerRequest.fromJson(json.decode(str));

String addBillerRequestToJson(AddBillerRequest data) => json.encode(data.toJson());

class AddBillerRequest {
  bool? isFavourite;
  String? nickName;
  String? messageType;
  int? serviceProviderId;
  String? value;
  bool? verified;

  AddBillerRequest({
    this.isFavourite,
    this.nickName,
    this.messageType,
    this.serviceProviderId,
    this.value,
    this.verified,
  });

  factory AddBillerRequest.fromJson(Map<String, dynamic> json) => AddBillerRequest(
    isFavourite: json["isFavourite"],
    nickName: json["nickName"],
    messageType: json["messageType"],
    serviceProviderId: json["serviceProviderId"],
    value: json["value"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "isFavourite": isFavourite,
    "nickName": nickName,
    "messageType": messageType,
    "serviceProviderId": serviceProviderId,
    "value": value,
     "verified": verified,
  };
}
