// // To parse this JSON data, do
// //
// //     final updateTxnLimitRequest = updateTxnLimitRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// UpdateTxnLimitRequest updateTxnLimitRequestFromJson(String str) => UpdateTxnLimitRequest.fromJson(json.decode(str));
//
// String updateTxnLimitRequestToJson(UpdateTxnLimitRequest data) => json.encode(data.toJson());
//
// class UpdateTxnLimitRequest {
//   String? messageType;
//   String? channelType;
//   List<TransactionLimit>? transactionLimits;
//
//   UpdateTxnLimitRequest({
//     this.messageType,
//     this.channelType,
//     this.transactionLimits,
//   });
//
//   factory UpdateTxnLimitRequest.fromJson(Map<String, dynamic> json) => UpdateTxnLimitRequest(
//     messageType: json["messageType"],
//     channelType: json["channelType"],
//     transactionLimits: List<TransactionLimit>.from(json["transactionLimits"].map((x) => TransactionLimit.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "channelType": channelType,
//     "transactionLimits": List<dynamic>.from(transactionLimits!.map((x) => x.toJson())),
//   };
// }
//
// class TransactionLimit {
//   String? transactionType;
//   int? maxAmountPerTran;
//   int? maxAmountPerDay;
//   int? twoFactorLimit;
//   bool? twoFactorEnable;
//
//   TransactionLimit({
//     this.transactionType,
//     this.maxAmountPerTran,
//     this.maxAmountPerDay,
//     this.twoFactorLimit,
//     this.twoFactorEnable,
//   });
//
//   factory TransactionLimit.fromJson(Map<String, dynamic> json) => TransactionLimit(
//     transactionType: json["transactionType"],
//     maxAmountPerTran: json["maxAmountPerTran"],
//     maxAmountPerDay: json["maxAmountPerDay"],
//     twoFactorLimit: json["twoFactorLimit"],
//     twoFactorEnable: json["twoFactorEnable"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "transactionType": transactionType,
//     "maxAmountPerTran": maxAmountPerTran,
//     "maxAmountPerDay": maxAmountPerDay,
//     "twoFactorLimit": twoFactorLimit,
//     "twoFactorEnable": twoFactorEnable,
//   };
// }

// To parse this JSON data, do
//
//     final updateTxnLimitRequest = updateTxnLimitRequestFromJson(jsonString);

import 'dart:convert';

UpdateTxnLimitRequest updateTxnLimitRequestFromJson(String str) => UpdateTxnLimitRequest.fromJson(json.decode(str));

String updateTxnLimitRequestToJson(UpdateTxnLimitRequest data) => json.encode(data.toJson());

class UpdateTxnLimitRequest {
  final String? messageType;
  final String? epicUserId;
  final String? channelType;
  final List<TransactionLimit>? transactionLimits;

  UpdateTxnLimitRequest({
    this.messageType,
    this.epicUserId,
    this.channelType,
    this.transactionLimits,
  });

  factory UpdateTxnLimitRequest.fromJson(Map<String, dynamic> json) => UpdateTxnLimitRequest(
    messageType: json["messageType"],
    epicUserId: json["epicUserId"],
    channelType: json["channelType"],
    transactionLimits: json["transactionLimits"] == null ? [] : List<TransactionLimit>.from(json["transactionLimits"]!.map((x) => TransactionLimit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "epicUserId": epicUserId,
    "channelType": channelType,
    "transactionLimits": transactionLimits == null ? [] : List<dynamic>.from(transactionLimits!.map((x) => x.toJson())),
  };
}

class TransactionLimit {
  final String? transactionType;
  final double? maxAmountPerTran;
  final double? maxAmountPerDay;
  final double? twoFactorLimit;
  final double? minAmountPerTran;
  final bool? twoFactorEnable;


  @override
  String toString() {
    return 'TransactionLimit{transactionType: $transactionType, maxAmountPerTran: $maxAmountPerTran, maxAmountPerDay: $maxAmountPerDay, twoFactorLimit: $twoFactorLimit, minAmountPerTran: $minAmountPerTran, twoFactorEnable: $twoFactorEnable}';
  }

  TransactionLimit({
    this.transactionType,
    this.maxAmountPerTran,
    this.maxAmountPerDay,
    this.twoFactorLimit,
    this.minAmountPerTran,
    this.twoFactorEnable,
  });

  factory TransactionLimit.fromJson(Map<String, dynamic> json) => TransactionLimit(
    transactionType: json["transactionType"],
    maxAmountPerTran: json["maxAmountPerTran"],
    maxAmountPerDay: json["maxAmountPerDay"],
    twoFactorLimit: json["twoFactorLimit"],
    minAmountPerTran: json["minAmountPerTran"],
    twoFactorEnable: json["twoFactorEnable"],
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "maxAmountPerTran": maxAmountPerTran,
    "maxAmountPerDay": maxAmountPerDay,
    "twoFactorLimit": twoFactorLimit,
    "minAmountPerTran": minAmountPerTran,
    "twoFactorEnable": twoFactorEnable,
  };
}
