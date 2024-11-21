// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../data/models/requests/customer_reg_request.dart';
import '../../base_event.dart';

abstract class ContactInformationEvent extends BaseEvent {}

/// Get Personal Information
class GetContactInformationEvent extends ContactInformationEvent {}

/// Store Personal Information
class StoreContactInformationEvent extends ContactInformationEvent {
  final int? stepValue;
  final String? stepName;
  final CustomerRegistrationRequest? customerRegistrationRequest;
  final bool? isBackButtonClick;

  StoreContactInformationEvent(
      {this.customerRegistrationRequest,
      this.stepName,
      this.stepValue,
      this.isBackButtonClick});
}

class SubmitCusRegEvent extends ContactInformationEvent {
  String? mobileNo;
  String? obType;
  String? email;
  String? address1;
  String? address2;
  String? address3;
  int? city;
  bool? isAddSameAsNIC;

  SubmitCusRegEvent(
      {this.mobileNo,
      this.email,
      this.obType,
      this.address1,
      this.address2,
      this.address3,
      this.city,
      this.isAddSameAsNIC});
}

/// Store And Navigate
// class StoreContactInfoAndNavigateForwardEvent extends ContactInformationEvent {
//   final int stepValue;
//   final String stepName;
//
//   StoreContactInfoAndNavigateForwardEvent({this.stepValue, this.stepName});
// }

class ValidateAccountEvent extends ContactInformationEvent {
  final String? accountNumber;

  ValidateAccountEvent({this.accountNumber});
}

class ValidateUBAccountEvent extends ContactInformationEvent {
  final String? accountNumber;
  final String? obType;
  final String? referralCode;
  final String? nickName;
  final String? identificationType;
  final String? identificationNo;

  ValidateUBAccountEvent(
      {this.accountNumber,
      this.obType,
      this.referralCode,
      this.nickName,
      this.identificationType,
      this.identificationNo});
}

///JstPay Account Verification
class ValidateJustPayEvent extends ContactInformationEvent {
  final String? mobileNumber;
  final String? nic;
  final String? referralCode;
  final String? obType;
  final String? email;

  ValidateJustPayEvent(
      {this.mobileNumber,
      this.email,
      this.obType,
      this.nic,
      this.referralCode});
}

class JustPayAccountOnboardingEvent extends ContactInformationEvent {
  final String? fullName;
  final String? bankCode;
  final String? accountType;
  final String? accountNo;
  final String? nickName;
  final bool? enableAlert;

  JustPayAccountOnboardingEvent(
      {this.fullName,
      this.bankCode,
      this.accountType,
      this.accountNo,
      this.nickName,
      this.enableAlert});
}

class JustPayChallengeIdEvent extends ContactInformationEvent {
  final String? challengeReqDeviceId;
  final bool? isOnboarded;

  JustPayChallengeIdEvent({this.challengeReqDeviceId,this.isOnboarded});
}

class JustPayTCSignEvent extends ContactInformationEvent {
   final String? challengeId;
    final String? termAndCondition;

  JustPayTCSignEvent(
    {this.challengeId,
    this.termAndCondition}
  );
}

class JustPaySDKCreateIdentityEvent extends ContactInformationEvent {
   final String? challengeId;

  JustPaySDKCreateIdentityEvent(
    {this.challengeId,}
  );
}

class JustPaySDKTCSignEvent extends ContactInformationEvent {
    final String? termAndCondition;

  JustPaySDKTCSignEvent(
    {
    this.termAndCondition}
  );
}

class GetOnboardTermsEvent extends ContactInformationEvent {
  final String? termType;

  GetOnboardTermsEvent({this.termType});
}

class AcceptOnboardTermsEvent extends ContactInformationEvent {
  final int? termId;
  final String? acceptedDate;
  final String? justpayInstrumentId;
  final String? instrumentId;
  final String termType;

  AcceptOnboardTermsEvent({this.termId, this.acceptedDate,this.justpayInstrumentId,this.instrumentId,required this.termType});
}


