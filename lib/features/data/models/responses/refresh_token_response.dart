// To parse this JSON data, do
//
//     final refreshTokenResponse = refreshTokenResponseFromJson(jsonString);

import 'dart:convert';

RefreshTokenResponse refreshTokenResponseFromJson(String str) => RefreshTokenResponse.fromJson(json.decode(str));

String refreshTokenResponseToJson(RefreshTokenResponse data) => json.encode(data.toJson());

class RefreshTokenResponse {
    final String? accessToken;
    final String? refreshToken;
    final int? tokenExpiresIn;

    RefreshTokenResponse({
        this.accessToken,
        this.refreshToken,
        this.tokenExpiresIn,
    });

    factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => RefreshTokenResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        tokenExpiresIn: json["tokenExpiresIn"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "tokenExpiresIn": tokenExpiresIn,
    };
}
