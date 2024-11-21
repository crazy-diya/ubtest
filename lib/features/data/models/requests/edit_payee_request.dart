import 'dart:convert';

EditPayeeRequest editPayeeRequestFromJson(String str) =>
    EditPayeeRequest.fromJson(json.decode(str));

String editPayeeRequestToJson(EditPayeeRequest data) =>
    json.encode(data.toJson());

class EditPayeeRequest {
  EditPayeeRequest({
    this.messageType,
    this.accountNumber,
    this.nickName,
    this.bankCode,
    this.branchId,
    this.name,
    this.favourite,
    this.id
  });

  String? messageType;
  int? id;
  String? accountNumber;
  String? nickName;
  String? bankCode;
  String? branchId;
  String? name;
  bool? favourite;

  factory EditPayeeRequest.fromJson(Map<String, dynamic> json) =>
      EditPayeeRequest(
        messageType: json["messageType"],
        accountNumber: json["accountNumber"],
        nickName: json["nickName"],
        bankCode: json["bankCode"],
        branchId: json["branchId"],
        name: json["name"],
        favourite: json["favourite"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "messageType": messageType,
        "accountNumber": accountNumber,
        "nickName": nickName,
        "bankCode": bankCode,
        "branchId": branchId,
        "name": name,
        "favourite": favourite,
      };
}
