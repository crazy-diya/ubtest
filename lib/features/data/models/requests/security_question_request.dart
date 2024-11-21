// To parse this JSON data, do
//
//     final cityRequest = cityRequestFromJson(jsonString);


import 'package:equatable/equatable.dart';


class SecurityQuestionRequest extends Equatable {
  const SecurityQuestionRequest({
    this.messageType,
    this.nic,
  });

  final String? messageType;
  final String? nic;

  factory SecurityQuestionRequest.fromJson(Map<String, dynamic> json) => SecurityQuestionRequest(
        messageType: json["messageType"],
        nic: json["nic"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "nic": nic,
      };

  @override
  List<Object?> get props => [messageType,nic];
}
