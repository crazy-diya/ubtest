import '../../../../data/models/requests/set_security_questions_request.dart';
import '../../base_event.dart';

abstract class SecurityQuestionsEvent extends BaseEvent {}

/// Get Schedule Information
class SetSecurityQuestionsEvent extends SecurityQuestionsEvent {
  final List<AnswerList> answerList;
  final String isMigrated; 

  SetSecurityQuestionsEvent(this.answerList, this.isMigrated);
}

class SaveSecurityQuestionsEvent extends SecurityQuestionsEvent {}

class GetSecurityQuestionSECDropDownEvent extends SecurityQuestionsEvent {
  String? nic;
  GetSecurityQuestionSECDropDownEvent({
    this.nic,
  });
}
