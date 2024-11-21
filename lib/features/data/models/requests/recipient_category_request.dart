// To parse this JSON data, do
//
//     final recipientTypeRequest = recipientTypeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

String recipientTypeRequestToJson(RecipientCategoryRequest data) => json.encode(data.toJson());

class RecipientCategoryRequest extends Equatable{
    final String? epicUserId;

    const RecipientCategoryRequest({
        this.epicUserId,
    });

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
    };
    
      @override
      List<Object?> get props => [epicUserId];
}
