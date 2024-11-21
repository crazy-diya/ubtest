// To parse this JSON data, do
//
//     final itransferGetThemeResponse = itransferGetThemeResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ItransferGetThemeResponse itransferGetThemeResponseFromJson(String str) => ItransferGetThemeResponse.fromJson(json.decode(str));

String itransferGetThemeResponseToJson(ItransferGetThemeResponse data) => json.encode(data.toJson());

class ItransferGetThemeResponse extends Serializable {
  ItransferGetThemeResponse({
    this.themes,
  });

  List<Theme>? themes;

  factory ItransferGetThemeResponse.fromJson(Map<String, dynamic> json) => ItransferGetThemeResponse(
    themes: List<Theme>.from(json["themes"].map((x) => Theme.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "themes": List<dynamic>.from(themes!.map((x) => x.toJson())),
  };
}

class Theme {
  Theme({
    this.id,
    this.themeName,
    this.themeImageUrl,
    this.themeExpDays,
  });

  int? id;
  String? themeName;
  String? themeImageUrl;
  int? themeExpDays;

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
    id: json["id"],
    themeName: json["themeName"],
    themeImageUrl: json["themeImageUrl"],
    themeExpDays: json["themeExpDays"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "themeName": themeName,
    "themeImageUrl": themeImageUrl,
    "themeExpDays": themeExpDays,
  };
}
