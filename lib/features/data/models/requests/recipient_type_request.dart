// To parse this JSON data, do
//
//     final recipientTypeRequest = recipientTypeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

String recipientTypeRequestToJson(RecipientTypeRequest data) => json.encode(data.toJson());

class RecipientTypeRequest extends Equatable{
    final String? recipientCode;

    const RecipientTypeRequest({
        this.recipientCode,
    });

    Map<String, dynamic> toJson() => {
        "recipientCode": recipientCode,
    };
    
      @override
      List<Object?> get props => [recipientCode];
}
