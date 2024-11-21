// To parse this JSON data, do
//
//     final deleteItransferPayeeRequest = deleteItransferPayeeRequestFromJson(jsonString);

import 'dart:convert';

DeleteItransferPayeeRequest deleteItransferPayeeRequestFromJson(String str) => DeleteItransferPayeeRequest.fromJson(json.decode(str));

String deleteItransferPayeeRequestToJson(DeleteItransferPayeeRequest data) => json.encode(data.toJson());

class DeleteItransferPayeeRequest {
  DeleteItransferPayeeRequest({
    this.messageType,
    this.idList,
  });

  String? messageType;
  List<int?>? idList;

  factory DeleteItransferPayeeRequest.fromJson(Map<String, dynamic> json) => DeleteItransferPayeeRequest(
    messageType: json["messageType"],
    idList: List<int>.from(json["idList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "idList": List<dynamic>.from(idList!.map((x) => x)),
  };
}
