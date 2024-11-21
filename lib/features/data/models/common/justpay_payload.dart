// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JustPayPayload {
  bool? isSuccess;
  String? data;
  int? code;
  JustPayPayload({this.isSuccess, this.data, this.code});

  factory JustPayPayload.fromRawJson(String str) => JustPayPayload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JustPayPayload.fromJson(Map<String, dynamic> json) => JustPayPayload(
    data: json["data"],
    isSuccess: json["isSuccess"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "isSuccess": isSuccess,
    "code": code,
  };

  @override
  String toString() => 'JustPayPayload(isSuccess: $isSuccess, data: $data, code: $code)';
}
