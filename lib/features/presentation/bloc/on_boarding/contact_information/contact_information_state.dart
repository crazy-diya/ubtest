

import 'package:union_bank_mobile/features/data/models/common/justpay_payload.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_terms_response.dart';

import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../data/models/responses/just_pay_account_onboarding_response.dart';
import '../../../../data/models/responses/just_pay_challenge_id_response.dart';
import '../../base_state.dart';

abstract class ContactInformationState
    extends BaseState<ContactInformationState> {}

class InitialContactInformationState extends ContactInformationState {}

class ContactInformationLoadedState extends ContactInformationState {
  final WalletOnBoardingData? walletOnBoardingData;

  //
  ContactInformationLoadedState({this.walletOnBoardingData});
}

class ContactInformationSubmittedSuccessState extends ContactInformationState {
  final bool? isBackButtonClick;

  ContactInformationSubmittedSuccessState({this.isBackButtonClick});
}

class ContactInformationFailedState extends ContactInformationState {
  final String? message;

  ContactInformationFailedState({this.message});
}

class ContactInfoApiSuccessState extends ContactInformationState {}

class AccountVerificationSuccessState extends ContactInformationState {}

class AccountVerificationFailedState extends ContactInformationState {
  final String? message;

  AccountVerificationFailedState({this.message});
}

class CdbAccountVerificationSuccessState extends ContactInformationState {
  final String? code;
  final String? message;

  CdbAccountVerificationSuccessState({this.code, this.message});
}

class CdbAccountVerificationFailedState extends ContactInformationState {
  final String? message;

  CdbAccountVerificationFailedState({this.message});
}

class JustPayVerificationFailedState extends ContactInformationState {
  final String? message;
  final String? errorCode;

  JustPayVerificationFailedState({
    this.message,
    this.errorCode,
  });
}

class JustPayVerificationSuccessState extends ContactInformationState {
  final BaseResponse? baseResponse;
  final String? ResponseCode;
  final String? errorCode;
  final String? ResponseDescription;
  final String? errorDescription;


  JustPayVerificationSuccessState(
      {this.ResponseCode, this.errorCode, this.ResponseDescription, this.baseResponse,this.errorDescription});
}

class JustPayOnboardingSuccessState extends ContactInformationState {
  final BaseResponse? baseResponse;
  final JustPayAccountOnboardingResponse? justPayAccountOnboardingDto;
  final String? responseCode;
  JustPayOnboardingSuccessState({this.justPayAccountOnboardingDto,this.responseCode, this.baseResponse});
}

class JustPayOnboardingFailedState extends ContactInformationState {
  final String? message;
  final String? code;

  JustPayOnboardingFailedState({this.message,this.code,});
}

class JustPayChallengeIdSuccessState extends ContactInformationState {
  final JustPayChallengeIdResponse? justPayChallengeIdResponse;

  JustPayChallengeIdSuccessState({this.justPayChallengeIdResponse});
}

class JustPayChallengeIdFailedState extends ContactInformationState {
  final String? message;

  JustPayChallengeIdFailedState({this.message});
}


class JustPayTCSignSuccessState extends ContactInformationState {
  final BaseResponse? justPayTCSignResponse;

  JustPayTCSignSuccessState({this.justPayTCSignResponse});
}

class JustPayTCSignFailedState extends ContactInformationState {
  final String? message;

  JustPayTCSignFailedState({this.message});
}


class JustPaySDKCreateIdentitySuccessState extends ContactInformationState {
  final JustPayPayload? justPayPayload;

  JustPaySDKCreateIdentitySuccessState({this.justPayPayload});
}

class JustPaySDKCreateIdentityFailedState extends ContactInformationState {
  final String? message;

  JustPaySDKCreateIdentityFailedState({this.message});
}

class JustPaySDKTCSignSuccessState extends ContactInformationState {
  final JustPayPayload? justPayPayload;

  JustPaySDKTCSignSuccessState({this.justPayPayload});
}

class JustPaySDKTCSignFailedState extends ContactInformationState {
  final String? message;

  JustPaySDKTCSignFailedState({this.message});
}


class OnboardTermsLoadedState extends ContactInformationState {
  final TermsData? termsData;

  OnboardTermsLoadedState({this.termsData});
}

class OnboardTermsSubmittedState extends ContactInformationState {

}

class OnboardTermsFailedState extends ContactInformationState {
  final String? message;

  OnboardTermsFailedState({this.message});
}