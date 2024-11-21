// // To parse this JSON data, do
// //
// //     final justPayChallengeIdRequest = justPayChallengeIdRequestFromJson(jsonString);

// import 'dart:convert';

// JustPayChallengeIdRequest justPayChallengeIdRequestFromJson(String str) => JustPayChallengeIdRequest.fromJson(json.decode(str));

// String justPayChallengeIdRequestToJson(JustPayChallengeIdRequest data) => json.encode(data.toJson());

// class JustPayChallengeIdRequest {
//   JustPayChallengeIdRequest({
//     this.messageType,
//     this.fromBankCode,
//     this.challengeReqDeviceId,
//   });

//   String? messageType;
//   String? fromBankCode;
//   String? challengeReqDeviceId;

//   factory JustPayChallengeIdRequest.fromJson(Map<String, dynamic> json) => JustPayChallengeIdRequest(
//     messageType: json["messageType"],
//     fromBankCode: json["fromBankCode"],
//     challengeReqDeviceId: json["challengeReqDeviceId"],
//   );

//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "fromBankCode": fromBankCode,
//     "challengeReqDeviceId": challengeReqDeviceId,
//   };
// }





// To parse this JSON data, do
//
//     final justPayChallengeIdRequest = justPayChallengeIdRequestFromJson(jsonString);

import 'dart:convert';

JustPayChallengeIdRequest justPayChallengeIdRequestFromJson(String str) => JustPayChallengeIdRequest.fromJson(json.decode(str));

String justPayChallengeIdRequestToJson(JustPayChallengeIdRequest data) => json.encode(data.toJson());

class JustPayChallengeIdRequest {
    final String? messageType;
    final String? fromBankCode;
    final String? challengeReqDeviceId;
    final bool? isOnboarded;

    JustPayChallengeIdRequest({
        this.messageType,
        this.fromBankCode,
        this.challengeReqDeviceId,
        this.isOnboarded,
    });

    factory JustPayChallengeIdRequest.fromJson(Map<String, dynamic> json) => JustPayChallengeIdRequest(
        messageType: json["messageType"],
        fromBankCode: json["fromBankCode"],
        challengeReqDeviceId: json["challengeReqDeviceId"],
        isOnboarded: json["isOnboarded"],
    );

    Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "fromBankCode": fromBankCode,
        "challengeReqDeviceId": challengeReqDeviceId,
        "isOnboarded": isOnboarded,
    };
}

