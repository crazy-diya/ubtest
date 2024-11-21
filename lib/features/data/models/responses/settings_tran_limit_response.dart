
import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

SettingsTranLimitResponse settingsTranLimitResponseFromJson(String str) => SettingsTranLimitResponse.fromJson(json.decode(str));

String settingsTranLimitResponseToJson(SettingsTranLimitResponse data) => json.encode(data.toJson());

class SettingsTranLimitResponse extends Serializable{
    final List<TranLimitDetails>? txnLimit;

    SettingsTranLimitResponse({
        this.txnLimit,
    });

    factory SettingsTranLimitResponse.fromJson(Map<String, dynamic> json) => SettingsTranLimitResponse(
        txnLimit: json["txnLimit"] == null ? [] : List<TranLimitDetails>.from(json["txnLimit"]!.map((x) => TranLimitDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "txnLimit": txnLimit == null ? [] : List<dynamic>.from(txnLimit!.map((x) => x.toJson())),
    };
}

class TranLimitDetails {
    final String? transactionType;
    final bool? enabledTwoFactorLimit;
    final String? maxUserAmountPerDay;
    final String? maxUserAmountPerTran;
    final String? minUserAmountPerTran;
    final String? twoFactorLimit;
    final String? maxGlobalLimitPerDay;
    final String? maxGlobalLimitPerTran;
    final String? minGlobalLimitPerTran;
    final String? globalTwoFactorLimit;
    final String? description;
    final String? serviceCharge;

    TranLimitDetails({
        this.transactionType,
        this.enabledTwoFactorLimit,
        this.maxUserAmountPerDay,
        this.maxUserAmountPerTran,
        this.minUserAmountPerTran,
        this.twoFactorLimit,
        this.maxGlobalLimitPerDay,
        this.maxGlobalLimitPerTran,
        this.minGlobalLimitPerTran,
        this.globalTwoFactorLimit,
        this.description,
        this.serviceCharge,
    });

    factory TranLimitDetails.fromJson(Map<String, dynamic> json) => TranLimitDetails(
        transactionType: json["transactionType"],
        enabledTwoFactorLimit: json["enabledTwoFactorLimit"],
        maxUserAmountPerDay: json["maxUserAmountPerDay"]??json["maxGlobalLimitPerDay"],
        maxUserAmountPerTran: json["maxUserAmountPerTran"]??json["maxGlobalLimitPerTran"],
        minUserAmountPerTran: json["minUserAmountPerTran"]??json["minGlobalLimitPerTran"],
        twoFactorLimit: json["twoFactorLimit"]?? json["globalTwoFactorLimit"],
        maxGlobalLimitPerDay: json["maxGlobalLimitPerDay"],
        maxGlobalLimitPerTran: json["maxGlobalLimitPerTran"],
        minGlobalLimitPerTran: json["minGlobalLimitPerTran"],
        globalTwoFactorLimit: json["globalTwoFactorLimit"],
        description: json["description"],
        serviceCharge: json["serviceCharge"],
    );

    Map<String, dynamic> toJson() => {
        "transactionType": transactionType,
        "enabledTwoFactorLimit": enabledTwoFactorLimit,
        "maxUserAmountPerDay": maxUserAmountPerDay,
        "maxUserAmountPerTran": maxUserAmountPerTran,
        "minUserAmountPerTran": minUserAmountPerTran,
        "twoFactorLimit": twoFactorLimit,
        "maxGlobalLimitPerDay": maxGlobalLimitPerDay,
        "maxGlobalLimitPerTran": maxGlobalLimitPerTran,
        "minGlobalLimitPerTran": minGlobalLimitPerTran,
        "globalTwoFactorLimit": globalTwoFactorLimit,
        "description": description,
        "serviceCharge": serviceCharge,
    };
}


