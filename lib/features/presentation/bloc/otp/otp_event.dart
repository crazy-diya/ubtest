// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../base_event.dart';

abstract class OTPEvent extends BaseEvent {}

class OTPVerificationEvent extends OTPEvent {
  final String? otpTranId;
  final String? smsOtp;
  final String? otp;
  final String? otpType;
  final String? emailOtp;
  final String? justpayOtp;
  final String? id;
  final String? action;
  final List<int>? ids;

  OTPVerificationEvent({this.otpType, this.otpTranId,
    this.smsOtp,this.emailOtp,this.justpayOtp,this.otp,this.action,this.id , this.ids});
}

class RequestOTPEvent extends OTPEvent {
  final String? OtpType;

  RequestOTPEvent({this.OtpType});
}

class CardOTPVerificationEvent extends OTPEvent {
  final String? otp;
  final String? otpType;
  final String? accountNumber;
  final String? cardNumber;

  CardOTPVerificationEvent({
    this.otp,
    this.otpType,
    this.accountNumber,
    this.cardNumber,
  });

}

class OtherBankRequestEvent extends OTPEvent {
  final String? otpTranId;
  final int? resendAttempt;
  final int? countdownTime;
  final int? otpLength;
  final String? otpType;

  OtherBankRequestEvent({
    this.otpTranId,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.otpType,
  });

}
