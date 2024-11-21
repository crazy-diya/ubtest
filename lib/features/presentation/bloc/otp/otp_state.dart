import '../../../data/models/responses/add_just_pay_instruements_response.dart';
import '../../../data/models/responses/otp_response.dart';

import '../base_state.dart';

abstract class OTPState extends BaseState<OTPState> {}

class InitialOTPState extends OTPState {}

class OTPVerificationSuccessState extends OTPState {
  final String? id;

  OTPVerificationSuccessState({this.id});
}

class OTPVerificationFailedState extends OTPState {
  final String? message;
  final String? code;

  OTPVerificationFailedState({this.message,this.code});
}

class OTPRequestSuccessState extends OTPState {
  final OtpResponse? otpResponse;

  OTPRequestSuccessState({this.otpResponse});
}

class OTPRequestFailedState extends OTPState {
  final String? code;
  final String? message;

  OTPRequestFailedState({this.message,this.code});
}

class JustPayOTPRequestSuccessState extends OTPState {
  final AddJustPayInstrumentsResponse? addJustPayInstrumentsResponse;

  JustPayOTPRequestSuccessState({this.addJustPayInstrumentsResponse});
}

class JustPayOTPRequestFailedState extends OTPState {
  final String? code;
  final String? message;

  JustPayOTPRequestFailedState({this.message,this.code});
}

