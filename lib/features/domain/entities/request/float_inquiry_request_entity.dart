// To parse this JSON data, do
//
//     final floatInqueryRequest = floatInqueryRequestFromJson(jsonString);


import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';

class FloatInquiryRequestEntity extends FloatInquiryRequest {
  FloatInquiryRequestEntity(
      {String? epicUserId,
      bool? checkAllAccount,
      String? accountNo,
      String? accountType})
      : super(
            epicUserId: epicUserId,
            checkAllAccount: checkAllAccount,
            accountNo: accountNo,
            accountType: accountType);
}
