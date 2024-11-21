import 'package:union_bank_mobile/features/data/models/requests/security_question_request.dart';


class SecurityQuestionRequestEntity extends SecurityQuestionRequest {
  final String? messageType;
  final String? nic;


  const SecurityQuestionRequestEntity({this.messageType,this.nic}) : super(messageType: messageType,nic: nic);
}
