// To parse this JSON data, do
//
//     final floatInqueryRequest = floatInqueryRequestFromJson(jsonString);

import 'dart:convert';

FloatInquiryRequest floatInquiryRequestFromJson(String str) => FloatInquiryRequest.fromJson(json.decode(str));

String floatInquiryRequestToJson(FloatInquiryRequest data) => json.encode(data.toJson());

class FloatInquiryRequest {
    final String? epicUserId;
    final bool? checkAllAccount;
    final String? accountNo;
    final String? accountType;

    FloatInquiryRequest({
        this.epicUserId,
        this.checkAllAccount,
        this.accountNo,
        this.accountType,
    });

    factory FloatInquiryRequest.fromJson(Map<String, dynamic> json) => FloatInquiryRequest(
        epicUserId: json["epicUserId"],
        checkAllAccount: json["checkAllAccount"],
        accountNo: json["accountNo"],
        accountType: json["accountType"],
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "checkAllAccount": checkAllAccount,
        "accountNo": accountNo,
        "accountType": accountType,
    };
}
