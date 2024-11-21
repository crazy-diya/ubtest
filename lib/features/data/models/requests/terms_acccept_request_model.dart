import 'dart:convert';

TermsAcceptRequestModel termsAcceptRequestModelFromJson(String str) =>
    TermsAcceptRequestModel.fromJson(json.decode(str));

String termsAcceptRequestModelToJson(TermsAcceptRequestModel data) =>
    json.encode(data.toJson());

class TermsAcceptRequestModel {
  TermsAcceptRequestModel({
    this.termId,
    this.acceptedDate,
    this.messageType,
    this.justpayInstrumentId,
    this.instrumentId,
    this.termType,
    this.isMigrated,
  });

  int? termId;
  String? acceptedDate;
  String? messageType;
  String? justpayInstrumentId;
  String? instrumentId;
  String? termType;
  String? isMigrated;

  factory TermsAcceptRequestModel.fromJson(Map<String, dynamic> json) =>
      TermsAcceptRequestModel(
        termId: json["termId"],
        acceptedDate: json["acceptedDate"],
        messageType: json["messageType"],
        justpayInstrumentId:json["justpayInstrumentId"],
          instrumentId:json["instrumentId"],
        termType:json["termType"],
        isMigrated:json["isMigrated"],
      );

  Map<String, dynamic> toJson() => {
        "termId": termId,
        "acceptedDate": acceptedDate,
        "messageType": messageType,
        "justpayInstrumentId":justpayInstrumentId,
        "instrumentId":instrumentId,
        "termType":termType,
        "isMigrated":isMigrated,
      };
}
