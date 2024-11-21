// To parse this JSON data, do
//
//     final forgetPwCheckSecurityQuestionRequest = forgetPwCheckSecurityQuestionRequestFromJson(jsonString);

import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';

class ForgetPwCheckSecurityQuestionRequestEntity extends ForgetPwCheckSecurityQuestionRequest{

    ForgetPwCheckSecurityQuestionRequestEntity({
        List<Answer>? answers,
        String? identificationType,
        String? identificationNo,
        String? messageType,
    }) : super(
            answers: answers,
            identificationType: identificationType,
            identificationNo: identificationNo,
            messageType:messageType);
}


