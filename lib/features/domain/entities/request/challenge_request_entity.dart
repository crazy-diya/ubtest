
import '../../../data/models/requests/challenge_request.dart';

class ChallengeRequestEntity extends ChallengeRequest {
  final String? messageType;
  final String? deviceId;
  final String? otpType;
  final String? otpTranId;
  final List<int>? ids;
  final String? otp;
  final String? epicUserId;
  final String? smsOtp;
  final String? emailOtp;
  final String? justpayOtp;
  final String? id;
  final String? action;

  const ChallengeRequestEntity({
    this.otpType,
    this.messageType,
    this.otp,
    this.ids,
    this.otpTranId,
    this.deviceId,
    this.epicUserId,
    this.smsOtp,
    this.emailOtp,
    this.justpayOtp,
    this.id,
    this.action,
  }) : super(
          otpTranId: otpTranId,
          messageType: messageType,
          otpType: otpType,
          deviceId: deviceId,
          otp: otp,
          epicUserId: epicUserId,
          emailOtp: emailOtp,
          smsOtp: smsOtp,
          justpayOtp: justpayOtp,
          id: id,
          action: action,
    ids:ids,
        );
}
