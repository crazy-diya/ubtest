// To parse this JSON data, do
//
//     final editUserBillerRequest = editUserBillerRequestFromJson(jsonString);

import 'dart:convert';




EditUserBillerRequest editUserBillerRequestFromJson(String str) => EditUserBillerRequest.fromJson(json.decode(str));

String editUserBillerRequestToJson(EditUserBillerRequest data) => json.encode(data.toJson());

class EditUserBillerRequest {
  EditUserBillerRequest({
    this.messageType,
    this.nickName,
    this.serviceProviderId,
    this.billerId,
    this.value,
    //this.categoryId,
    //this.fieldList,
    this.isFavourite,
  });

  String? messageType;
  String? nickName;
  String? serviceProviderId;
  int? billerId;
  String? value;
  //String? categoryId;
  //List<FieldList>? fieldList;
 bool? isFavourite;

  factory EditUserBillerRequest.fromJson(Map<String, dynamic> json) => EditUserBillerRequest(
    messageType: json["messageType"],
    nickName: json["nickName"],
    serviceProviderId: json["serviceProviderId"],
    billerId: json["billerId"],
    value: json["value"],
    //categoryId: json["categoryId"],
    isFavourite: json["isFavourite"],
    //fieldList: List<FieldList>.from(json["fieldList"].map((x) => FieldList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "nickName": nickName,
    "serviceProviderId": serviceProviderId,
    "billerId": billerId,
    "value": value,
    //"categoryId": categoryId,
    "isFavourite": isFavourite,
    //"fieldList": List<dynamic>.from(fieldList!.map((x) => x.toJson())),
  };
}
