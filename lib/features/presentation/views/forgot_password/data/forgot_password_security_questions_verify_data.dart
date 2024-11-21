// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';

class ForgotPasswordSecurityQuestionsVerifyData {
  List<CommonDropDownResponse>? allDropDownData;
  String? identificatioNum;
  String? selectedIdType;
  ForgotPasswordSecurityQuestionsVerifyData({
    this.allDropDownData,
    this.identificatioNum,
    this.selectedIdType,
  });

}
