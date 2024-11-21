

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

RecipientCategoryResponse recipientCategoryResponseFromJson(String str) => RecipientCategoryResponse.fromJson(json.decode(str));

String recipientCategoryResponseToJson(RecipientCategoryResponse data) => json.encode(data.toJson());

class RecipientCategoryResponse extends Serializable{
    final List<RecipientCategoryData>? responseRecipientCategories;

    RecipientCategoryResponse({
        this.responseRecipientCategories,
    });

    factory RecipientCategoryResponse.fromJson(Map<String, dynamic> json) => RecipientCategoryResponse(
        responseRecipientCategories: json["responseRecipientCategories"] == null ? [] : List<RecipientCategoryData>.from(json["responseRecipientCategories"]!.map((x) => RecipientCategoryData.fromJson(x))),
    );

    @override
      Map<String, dynamic> toJson() => {
        "responseRecipientCategories": responseRecipientCategories == null ? [] : List<dynamic>.from(responseRecipientCategories!.map((x) => x.toJson())),
    };
}

class RecipientCategoryData {
    final String? categoryCode;
    final String? categoryName;

    RecipientCategoryData({
        this.categoryCode,
        this.categoryName,
    });

    factory RecipientCategoryData.fromJson(Map<String, dynamic> json) => RecipientCategoryData(
        categoryCode: json["categoryCode"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "categoryCode": categoryCode,
        "categoryName": categoryName,
    };
}
