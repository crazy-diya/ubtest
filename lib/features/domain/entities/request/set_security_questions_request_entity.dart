import '../../../data/models/requests/set_security_questions_request.dart';

class SetSecurityQuestionsEntity extends SetSecurityQuestionsRequest {
  final String? messageType;
  final List<AnswerList>? answerList;
  final String? isMigrated;

  SetSecurityQuestionsEntity({this.messageType, this.answerList,this.isMigrated})
      : super(messageType: messageType, answerList: answerList,isMigrated:isMigrated );
}
