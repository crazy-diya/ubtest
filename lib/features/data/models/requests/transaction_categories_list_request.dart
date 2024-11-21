import 'dart:convert';

TransactionCategoriesListRequest transactionCategoriesListRequestFromJson(String str) => TransactionCategoriesListRequest.fromJson(json.decode(str));

String transactionCategoriesListRequestToJson(TransactionCategoriesListRequest data) => json.encode(data.toJson());

class TransactionCategoriesListRequest {
  TransactionCategoriesListRequest({
     this.messageType,
  });
  String? messageType;


  factory TransactionCategoriesListRequest.fromJson(Map<String, dynamic> json) => TransactionCategoriesListRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
