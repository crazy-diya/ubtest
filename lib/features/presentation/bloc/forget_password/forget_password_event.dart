// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';

abstract class ForgetPasswordEvent extends BaseEvent {}

class CheckNicAccountNumReqEvent extends ForgetPasswordEvent {
  final String? accountNumber;
  final String? identificationType;
  final String? identificationNo;
  CheckNicAccountNumReqEvent({
    this.accountNumber, 
    this.identificationType,
    this.identificationNo});
}
class CheckUsernameIdentityReqEvent extends ForgetPasswordEvent {
  final String? username;
  final String? identificationType;
  final String? identificationNo;

  CheckUsernameIdentityReqEvent({
    this.username,
    this.identificationType,
    this.identificationNo
  });
 
}
class CheckSQAnswerReqEvent extends ForgetPasswordEvent {
  final List<Answer>? answers;
  final String? identificationType;
  final String? identificationNo;
  CheckSQAnswerReqEvent({
    this.answers,
    this.identificationType,
    this.identificationNo
  });
 }

 class ForgotPwResetReqEvent extends ForgetPasswordEvent {
  final String? newPassword;
  final String? confirmPassword;
  ForgotPwResetReqEvent({
    this.newPassword,
    this.confirmPassword
  });
 }

