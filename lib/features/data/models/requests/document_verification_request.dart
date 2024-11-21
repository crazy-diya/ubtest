// To parse this JSON data, do
//
//     final documentVerificationRequest = documentVerificationRequestFromJson(jsonString);

import 'dart:convert';

class DocumentVerificationRequest {
  DocumentVerificationRequest({
    this.selfie,
    this.icFront,
    this.icBack,
    this.billingProof,
    this.proofType
  });

  String? selfie;
  String? icFront;
  String? icBack;
  String? billingProof;
  String? proofType;

  factory DocumentVerificationRequest.fromRawJson(String str) => DocumentVerificationRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentVerificationRequest.fromJson(Map<String, dynamic> json) => DocumentVerificationRequest(
    selfie: json["selfie"],
    icFront: json["ic_front"],
    icBack: json["ic_back"],
    billingProof: json["billing_proof"],
    proofType: json["proofType"],
  );

  Map<String, dynamic> toJson() => {
    "selfie": selfie,
    "ic_front": icFront,
    "ic_back": icBack,
    "billing_proof": billingProof,
    "proofType": proofType,
  };
}
