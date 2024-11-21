
import 'dart:convert';

import '../common/base_response.dart';

class ScheduleDateResponse extends Serializable{
  ScheduleDateResponse({
    this.dates,
  });

  List<String>? dates;

  factory ScheduleDateResponse.fromRawJson(String str) => ScheduleDateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleDateResponse.fromJson(Map<String, dynamic> json) => ScheduleDateResponse(
    dates: List<String>.from(json["dates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "dates": List<dynamic>.from(dates!.map((x) => x)),
  };
}
