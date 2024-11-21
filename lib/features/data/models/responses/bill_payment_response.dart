// // To parse this JSON data, do
// //
// //     final billPaymentResponse = billPaymentResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import '../common/base_response.dart';
//
// BillPaymentResponse billPaymentResponseFromJson(String str) =>
//     BillPaymentResponse.fromJson(json.decode(str));
//
// String billPaymentResponseToJson(BillPaymentResponse data) =>
//     json.encode(data.toJson());
//
// class BillPaymentResponse extends Serializable {
//   BillPaymentResponse({
//     this.userInstrumentsResponseDto,
//     this.billerResponseDto,
//     this.amount,
//     this.serviceCharge,
//     this.dateTime,
//     this.referenceNumber,
//     this.remarks,
//     this.transactionId,
//   });
//
//   UserInstrumentsResponseDto? userInstrumentsResponseDto;
//   BillerResponseDto? billerResponseDto;
//   double? amount;
//   double? serviceCharge;
//   String? dateTime;
//   String? referenceNumber;
//   String? remarks;
//   String? transactionId;
//
//   factory BillPaymentResponse.fromJson(Map<String, dynamic> json) =>
//       BillPaymentResponse(
//         userInstrumentsResponseDto: UserInstrumentsResponseDto.fromJson(
//             json["userInstrumentsResponseDTO"]),
//         billerResponseDto:
//         BillerResponseDto.fromJson(json["billerResponseDTO"]),
//         amount: json["amount"],
//         serviceCharge: json["serviceCharge"],
//         dateTime: json["dateTime"],
//         referenceNumber: json["referenceNumber"],
//         remarks: json["remarks"],
//         transactionId: json["transactionId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "userInstrumentsResponseDTO": userInstrumentsResponseDto!.toJson(),
//     "billerResponseDTO": billerResponseDto!.toJson(),
//     "amount": amount,
//     "serviceCharge": serviceCharge,
//     "dateTime": dateTime,
//     "referenceNumber": referenceNumber,
//     "remarks": remarks,
//     "transactionId": transactionId,
//   };
// }
//
// class BillerResponseDto {
//   BillerResponseDto({
//     this.billerName,
//     this.accountNumber,
//   });
//
//   String? billerName;
//   String? accountNumber;
//
//   factory BillerResponseDto.fromJson(Map<String, dynamic> json) =>
//       BillerResponseDto(
//         billerName: json["billerName"],
//         accountNumber: json["accountNumber"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "billerName": billerName,
//     "accountNumber": accountNumber,
//   };
// }
//
// class UserInstrumentsResponseDto {
//   UserInstrumentsResponseDto({
//     this.accountNo,
//     this.nickName,
//   });
//
//   String? accountNo;
//   String? nickName;
//
//   factory UserInstrumentsResponseDto.fromJson(Map<String, dynamic> json) => UserInstrumentsResponseDto(
//     accountNo: json["accountNo"],
//     nickName: json["nickName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "accountNo": accountNo,
//     "nickName": nickName,
//   };
// }



// To parse this JSON data, do
//
//     final billPaymentResponse = billPaymentResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

BillPaymentResponse billPaymentResponseFromJson(String str) => BillPaymentResponse.fromJson(json.decode(str));

String billPaymentResponseToJson(BillPaymentResponse data) => json.encode(data.toJson());

class BillPaymentResponse extends Serializable {
  String? sname;
  String? accn;
  String? crbbal;
  String? avlbbal;
  String? qqname;
  String? dactno;
  String? dlgbal;
  String? dahold;
  String? cactno;
  String? clgbal;
  String? cahold;
  String? errorDes;
  String? responseCode;

  // DateTime? txnTime;
  String? field2;
  String? refId;
  String? txnId;

  BillPaymentResponse({
    this.sname,
    this.accn,
    this.crbbal,
    this.avlbbal,
    this.qqname,
    this.dactno,
    this.dlgbal,
    this.dahold,
    this.cactno,
    this.clgbal,
    this.cahold,
    this.errorDes,
    this.responseCode,
    // this.txnTime,
    this.field2,
    this.refId,
    this.txnId,
  });

  factory BillPaymentResponse.fromJson(Map<String, dynamic> json) => BillPaymentResponse(
    sname: json["sname"],
    accn: json["accn"],
    crbbal: json["crbbal"],
    avlbbal: json["avlbbal"],
    qqname: json["qqname"],
    dactno: json["dactno"],
        dlgbal: json["dlgbal"],
        dahold: json["dahold"],
        cactno: json["cactno"],
        clgbal: json["clgbal"],
        cahold: json["cahold"],
        errorDes: json["errorDes"],
        responseCode: json["responseCode"],
        // txnTime: DateTime.parse(json["txnTime"]),
        field2: json["field2"],
        refId: json["refId"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
    "sname": sname,
    "accn": accn,
    "crbbal": crbbal,
    "avlbbal": avlbbal,
    "qqname": qqname,
    "dactno": dactno,
        "dlgbal": dlgbal,
        "dahold": dahold,
        "cactno": cactno,
        "clgbal": clgbal,
        "cahold": cahold,
        "errorDes": errorDes,
        "responseCode": responseCode,
        // "txnTime": txnTime?.toIso8601String(),
        "field2": field2,
        "refId": refId,
        "txnId": txnId,
      };
}
