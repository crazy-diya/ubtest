// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);



import 'dart:convert';

BaseResponse apiResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str), (data) => data);

String apiResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse<T extends Serializable> {
  BaseResponse({
    this.messageVersion,
    this.deviceChannel,
    this.messageType,
    this.epicTransId,
    this.appTransID,
    this.responseCode,
    this.responseDescription,
    this.errorCode,
    this.errorComponent,
    this.errorDescription,
    this.errorDetail,
    this.errorMessageType,
    this.epicUserID,
    this.data,
    this.transactionReferenceNumber,
  });

  String? messageVersion;
  String? deviceChannel;
  String? messageType;
  String? epicTransId;
  String? appTransID;
  String? responseCode;
  String? responseDescription;
  String? errorCode;
  String? errorComponent;
  String? errorDescription;
  String? errorDetail;
  String? errorMessageType;
  String? epicUserID;
  String? transactionReferenceNumber;
  T? data;

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, Function(Map<String, dynamic>?) create) =>
      BaseResponse(
        messageVersion: json["messageVersion"],
        deviceChannel: json["deviceChannel"],
        messageType: json["messageType"],
        epicTransId: json["epicTransId"],
        appTransID: json["appTransID"],
        responseCode: json["responseCode"],
        responseDescription: json["responseDescription"],
        errorCode: json["errorCode"],
        errorComponent: json["errorComponent"],
        errorDescription: json["errorDescription"],
        errorDetail: json["errorDetail"],
        errorMessageType: json["errorMessageType"],
        epicUserID: json["epicUserID"],
        transactionReferenceNumber: json["transactionReferenceNumber"],
        data: json["data"] is int
            ? null : json["data"] is String?null
            : create(json["data"] is List ? json : json['data']),
      );

  Map<String, dynamic> toJson() => {
        "messageVersion": messageVersion,
        "deviceChannel": deviceChannel,
        "messageType": messageType,
        "epicTransId": epicTransId,
        "appTransID": appTransID,
        "responseCode": responseCode,
        "responseDescription": responseDescription,
        "errorCode": errorCode,
        "errorComponent": errorComponent,
        "errorDescription": errorDescription,
        "errorDetail": errorDetail,
        "errorMessageType": errorMessageType,
        "epicUserID": epicUserID,
        "transactionReferenceNumber": transactionReferenceNumber,
        "data": data!.toJson(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
