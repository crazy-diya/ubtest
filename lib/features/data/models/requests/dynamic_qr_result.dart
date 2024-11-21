import 'dart:convert';

DynamicQrResult dynamicQrResultFromJson(String str) =>
    DynamicQrResult.fromJson(json.decode(str));

String dynamicQrResultToJson(DynamicQrResult data) =>
    json.encode(data.toJson());

class DynamicQrResult {
  DynamicQrResult({
    this.instrumentToken,
    this.tid,
    this.mid,
    this.merchantName,
    this.merchantAddress,
    this.bankCode,
    this.encryptedQr,
    this.referenceId,
    this.amount,
    this.billNumber,
    this.consumerId,
    this.loyaltyNumber,
    this.mobileNumber,
    this.purpose,
    this.storeId,
    this.isStaticQr,
    this.mcc,
  });

  String? instrumentToken;
  String? tid;
  String? mid;
  String? merchantName;
  String? merchantAddress;
  String? bankCode;
  String? encryptedQr;
  String? referenceId;
  double? amount;
  String? billNumber;
  String? consumerId;
  String? loyaltyNumber;
  String? mobileNumber;
  String? purpose;
  String? storeId;
  bool? isStaticQr;
  String? mcc;

  factory DynamicQrResult.fromJson(Map<String, dynamic> json) =>
      DynamicQrResult(
        instrumentToken: json["instrumentToken"],
        tid: json["tid"],
        mid: json["mid"],
        merchantName: json["merchantName"],
        merchantAddress: json["merchantAddress"],
        bankCode: json["bankCode"],
        encryptedQr: json["encryptedQR"],
        referenceId: json["referenceId"],
        amount: json["amount"].toDouble(),
        billNumber: json["billNumber"],
        consumerId: json["consumerId"],
        loyaltyNumber: json["loyaltyNumber"],
        mobileNumber: json["mobileNumber"],
        purpose: json["purpose"],
        storeId: json["storeId"],
        isStaticQr: json["isStaticQR"],
        mcc: json["mcc"],
      );

  Map<String, dynamic> toJson() => {
        "instrumentToken": instrumentToken,
        "tid": tid,
        "mid": mid,
        "merchantName": merchantName,
        "merchantAddress": merchantAddress,
        "bankCode": bankCode,
        "encryptedQR": encryptedQr,
        "referenceId": referenceId,
        "amount": amount,
        "billNumber": billNumber,
        "consumerId": consumerId,
        "loyaltyNumber": loyaltyNumber,
        "mobileNumber": mobileNumber,
        "purpose": purpose,
        "storeId": storeId,
        "isStaticQR": isStaticQr,
        "mcc": mcc,
      };
}
