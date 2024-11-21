import 'dart:async';

// import 'package:fpdart/fpdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/features/data/models/common/justpay_payload.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_terms_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/get_terms_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/just_pay_tc_sign_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/terms_accept_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/justpay/just_pay_tc_sign.dart';
import 'package:union_bank_mobile/features/domain/usecases/terms/accept_terms_data.dart';
import 'package:union_bank_mobile/features/domain/usecases/terms/get_terms_data.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';

import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/account_verfication_request.dart';
import '../../../../data/models/requests/cdb_account_verfication_request.dart';
import '../../../../data/models/requests/customer_reg_request.dart';
import '../../../../data/models/requests/just_pay_account_onboarding_request.dart';
import '../../../../data/models/requests/just_pay_challenge_id_request.dart';
import '../../../../data/models/requests/just_pay_verfication_request.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/customer_reg_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/account_verification/account_verification.dart';
import '../../../../domain/usecases/cdb_account_verification/cdb_account_verification.dart';
import '../../../../domain/usecases/customer_registration/customer_registration.dart';
import '../../../../domain/usecases/justpay/just_pay_account_onboarding.dart';
import '../../../../domain/usecases/justpay/just_pay_challenge_id.dart';
import '../../../../domain/usecases/justpay/justPay_verification.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'contact_information_event.dart';
import 'contact_information_state.dart';

class ContactInformationBloc extends BaseBloc<ContactInformationEvent,
    BaseState<ContactInformationState>> {
  final LocalDataSource? appSharedData;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;
  final CustomerRegistration? customerRegistration;
  final AccountVerification? accountVerification;
  final AppValidator? appValidator;
  final CDBAccountVerification? cdbAccountVerification;
  final JustPayVerification? justPayVerification;
  final JustPayAccountOnboarding? justPayAcoountOnboarding;
  final JustPayChallengeId? justPayChallengeId;
  final JustPayTCSign? justPayTCSign;
  final GetTermsData? useCaseGetTerms;
  final AcceptTermsData? useCaseAcceptTerms;

  ContactInformationBloc( {
    this.appSharedData,
    this.justPayChallengeId,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.customerRegistration,
    this.appValidator,
    this.accountVerification,
    this.cdbAccountVerification,
    this.justPayVerification,
    this.justPayAcoountOnboarding,
    this.justPayTCSign,
    this.useCaseGetTerms, 
    this.useCaseAcceptTerms,
  }) : super(InitialContactInformationState()) {
    on<StoreContactInformationEvent>(_onStoreContactInformationEvent);
    on<GetContactInformationEvent>(_onGetContactInformationEvent);
    on<ValidateAccountEvent>(_onValidateAccountEvent);
    on<ValidateUBAccountEvent>(_onValidateCdbAccountEvent);
    on<SubmitCusRegEvent>(_onVSubmitCusRegEvent);
    on<ValidateJustPayEvent>(_onValidateJustPayEvent);
    on<JustPayAccountOnboardingEvent>(_onJustPayAccountOnboardingEvent);
    on<JustPayChallengeIdEvent>(_onJustPayChallengeIdEvent);
    on<JustPayTCSignEvent>(_onJustPayTCSignEvent);

    //Just Pay SDK
    on<JustPaySDKCreateIdentityEvent>(_onJustPaySDKCreateIdentity);
    on<JustPaySDKTCSignEvent>(_onJustPaySDKTCSignEvent);
    on<GetOnboardTermsEvent>(_onGetTermsEvent);
    on<AcceptOnboardTermsEvent>(_onAcceptTermsEvent);
     
  }

  void _onStoreContactInformationEvent(
    StoreContactInformationEvent event,
    Emitter<BaseState<ContactInformationState>> emit,
  ) async {
    // Get the Wallet Data
    final result = await getWalletOnBoardingData!(
      const WalletParams(walletOnBoardingDataEntity: null),
    );

    // Check if result is (right)
    if (result.isRight()) {
      // Set the New Values
      final WalletOnBoardingData walletOnBoardingData =
          result.getOrElse((l) => null)!;
      walletOnBoardingData.walletUserData!.customerRegistrationRequest!
          .mobileNo = event.customerRegistrationRequest!.mobileNo;
      walletOnBoardingData.walletUserData!.customerRegistrationRequest!.email =
          event.customerRegistrationRequest!.email;
      walletOnBoardingData.walletUserData!.customerRegistrationRequest!
          .perAddress = event.customerRegistrationRequest!.perAddress;

      // Store the Wallet Data
      final savedResult = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperValue: event.stepValue,
            stepperName: event.stepName,
            walletUserData: walletOnBoardingData.walletUserData,
          ),
        ),
      );

      emit(savedResult.fold(
        (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return ContactInformationFailedState(
                message: "Failed to load data");
          }
        },
        (r) => ContactInformationSubmittedSuccessState(
            isBackButtonClick: event.isBackButtonClick),
      ));
    } else {
      emit(ContactInformationFailedState(message: "Failed to load data"));
    }
  }

  void _onGetContactInformationEvent(
    GetContactInformationEvent event,
    Emitter<BaseState<ContactInformationState>> emit,
  ) async {
    final result = await getWalletOnBoardingData!(
      const WalletParams(walletOnBoardingDataEntity: null),
    );

    emit(result.fold(
      (l){
      if (l is AuthorizedFailure) {
            return AuthorizedFailureState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
            return ContactInformationFailedState(message: "Failed to load data");
          }},
      (response) =>
          ContactInformationLoadedState(walletOnBoardingData: response),
    ));
  }

  void _onValidateAccountEvent(
    ValidateAccountEvent event,
    Emitter<BaseState<ContactInformationState>> emit,
  ) async {
    final result = await accountVerification!(
      AccountVerificationRequest(
        accountNo: event.accountNumber,
        messageType: kAccountVerificationRequestType,
      ),
    );

    emit(result.fold(
      (l) {
        if (l is AuthorizedFailure) {
          return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is SessionExpire) {
          return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ConnectionFailure) {
          return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ServerFailure) {
          return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        }
        else {
          return AccountVerificationFailedState(
              message: ErrorHandler().mapFailureToMessage(l));
        }
      },
      (r) => AccountVerificationSuccessState(),
    ));
  }

  void _onValidateCdbAccountEvent(
    ValidateUBAccountEvent event,
    Emitter<BaseState<ContactInformationState>> emit,
  ) async {
    emit(APILoadingState());

    final result = await cdbAccountVerification!(
      CdbAccountVerificationRequest(
          accountNo: event.accountNumber,
          messageType: KAccountOnboardReq,
          referralCode: event.referralCode,
          obType: event.obType,
          nickName: event.nickName,
          identificationType: event.identificationType,
          identificationNo: event.identificationNo),
    );

    emit(result.fold(
      (l) {
        if (l is AuthorizedFailure) {
          return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is SessionExpire) {
          return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ConnectionFailure) {
          return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ServerFailure) {
          return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        }
        else {
          return CdbAccountVerificationFailedState(
              message: ErrorHandler().mapFailureToMessage(l));
        }
      },
      (r) => CdbAccountVerificationSuccessState(
        code: r.errorCode ?? r.responseCode,
        message: r.errorDescription ?? r.responseDescription,
      ),
    ));
  }

  Future<void> _onVSubmitCusRegEvent(SubmitCusRegEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    if (!appValidator!.validateEmail(event.email!)) {
      emit(ContactInformationFailedState(message: AppString.validEmail));
      return;
    } else if (!appValidator!.validateMobileNumber(event.mobileNo!)) {
      emit(ContactInformationFailedState(message: AppString.validMobile));
      return;
    }

    // Get the Wallet Data
    emit(APILoadingState());
    final result = await (getWalletOnBoardingData!(
            const WalletParams(walletOnBoardingDataEntity: null))
        as FutureOr<Either<Failure, WalletOnBoardingData>>);
    final obj = result.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is Failure) {
      emit(ContactInformationFailedState(message: "Failed to load data"));
    } else {
      // Send Customer Reg Request
      final WalletOnBoardingData data = obj as WalletOnBoardingData;

      final apiResult = await customerRegistration!(CustomerRegParams(
          customerRegistrationRequestEntity: CustomerRegistrationRequestEntity(
              obType: ObType.NUO.name,
              //data.walletUserData.customerRegistrationRequest.obType,
              messageType:
                  data.walletUserData!.customerRegistrationRequest!.messageType,
              title: data.walletUserData!.customerRegistrationRequest!.title
                  .getTitle(),
              initials:
                  data.walletUserData!.customerRegistrationRequest!.initials,
              initialsInFull: data
                  .walletUserData!.customerRegistrationRequest!.initialsInFull,
              lastName:
                  data.walletUserData!.customerRegistrationRequest!.lastName,
              nationality:
                  data.walletUserData!.customerRegistrationRequest!.nationality,
              gender: data.walletUserData!.customerRegistrationRequest!.gender,
              language: data
                  .walletUserData!.customerRegistrationRequest!.language
                  .getLanguage(),
              religion: data
                  .walletUserData!.customerRegistrationRequest!.religion
                  .getReligion(),
              nic: data.walletUserData!.customerRegistrationRequest!.nic,
              dateOfBirth:
                  data.walletUserData!.customerRegistrationRequest!.dateOfBirth,
              mobileNo: event.mobileNo,
              email: event.email,
              maritalStatus: data
                  .walletUserData!.customerRegistrationRequest!.maritalStatus,
              perAddress: [
            PerAddress(
                addressLine1: event.address1,
                addressLine2: event.address2,
                addressLine3: event.address3,
                city: event.city,
                equalityWithNic: event.isAddSameAsNIC)
          ]
              // perAddress:
              //     data.walletUserData.customerRegistrationRequest.perAddress,
              )));

      emit(apiResult.fold((l) {
        if (l is AuthorizedFailure) {
          return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is SessionExpire) {
          return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ConnectionFailure) {
          return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ServerFailure) {
          return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        }
        else {
          return ContactInformationFailedState(
              message: ErrorHandler().mapFailureToMessage(l));
        }
      }, (r) {
        return ContactInfoApiSuccessState();
      }));
    }
  }

  Future<void> _onValidateJustPayEvent(ValidateJustPayEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
    final result = await justPayVerification!(
      JustPayVerificationRequest(
        obType: event.obType,
        messageType: kJustPayVerifyRequestType,
        nic: event.nic,
        referralCode: event.referralCode,
        mobileNo: event.mobileNumber,
        email: event.email,
      ),
    );
    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return JustPayVerificationFailedState(
            errorCode: (l as ServerFailure).errorResponse.errorCode,
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS){
        
      return JustPayVerificationSuccessState(
        ResponseCode: r.responseCode,
        errorCode: r.errorCode,
        ResponseDescription: r.responseDescription,
        errorDescription: r.errorDescription
      );

      }else{
        return JustPayVerificationFailedState(
            errorCode: r.errorCode??r.responseCode,
            message: r.errorDescription??r.responseDescription);
      }
    }));
  }

  Future<void> _onJustPayAccountOnboardingEvent(
      JustPayAccountOnboardingEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
    final result = await justPayAcoountOnboarding!(
      JustPayAccountOnboardingRequest(
        messageType: kOtpMessageTypeAccountOnboardingReq,
        accountNo: event.accountNo,
        accountType: event.accountType,
        bankCode: event.bankCode,
        fullName: event.fullName,
        nickName: event.nickName,
        enableAlert: event.enableAlert,
        obType: ObType.JUSTPAY.name,
      ),
    );
    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return JustPayOnboardingFailedState(
          message: ErrorHandler().mapFailureToMessage(l),
          code: (l as ServerFailure).errorResponse.errorCode??'',
        );
      }
    }, (r) {
      if(r.responseCode == APIResponse.SUCCESS){
        
      return JustPayOnboardingSuccessState(
        justPayAccountOnboardingDto: r.data,
      );

      }else{
        return JustPayOnboardingFailedState(
          message: r.errorDescription??r.responseDescription,
          code: r.errorCode??r.responseCode,
        );
      }
    }));
  }

  Future<void> _onJustPayChallengeIdEvent(JustPayChallengeIdEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
    final result = await justPayChallengeId!(
      JustPayChallengeIdRequest(
        messageType: kAccountOnboardReq,
        fromBankCode: AppConstants.ubBankCode.toString(),
        challengeReqDeviceId: event.challengeReqDeviceId,
        isOnboarded: event.isOnboarded
      )
    );
    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return JustPayChallengeIdFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS || r.responseCode =="823"){ 
      return JustPayChallengeIdSuccessState(
        justPayChallengeIdResponse: r.data,
      );
      }else{
          return JustPayChallengeIdFailedState(
            message: r.errorDescription??r.responseDescription);
      }
    }));
  }

   Future<void> _onJustPayTCSignEvent(JustPayTCSignEvent event, Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
    final challengeId = await appSharedData?.getChallengeId();
    final result = await justPayTCSign!(
      JustpayTCSignRequestEntity(
        messageType: kAccountOnboardReq,
        challengeId: AppConstants.challangeID != "" ? AppConstants.challangeID : challengeId,
        termAndCondition: event.termAndCondition,
      ),
    );
    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return JustPayTCSignFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
      return JustPayTCSignSuccessState(
        justPayTCSignResponse: r, 
      );
      }else{
         return JustPayTCSignFailedState(
            message: r.errorDescription??r.responseDescription);

      }
    }));
  }

  /* ------------------------------ Just Pay Sdk ------------------------------ */

  Future<void> _onJustPaySDKCreateIdentity(JustPaySDKCreateIdentityEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
   final JustPayPayload justPayPayload =  await PlatformServices.justPayCreateIdentity(event.challengeId!); 
    
    if(justPayPayload.isSuccess==true) {
      appSharedData?.setChallengeId(event.challengeId!);
      AppConstants.challangeID = event.challengeId!;
      emit(JustPaySDKCreateIdentitySuccessState(justPayPayload: justPayPayload));
    }else{
      emit(JustPaySDKCreateIdentityFailedState(message: justPayPayload.code.toString()));
    }
  }

  Future<void> _onJustPaySDKTCSignEvent(JustPaySDKTCSignEvent event,
      Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
   final JustPayPayload justPayPayload =  await PlatformServices.justPaySignedTerms(event.termAndCondition!); 
    
    if(justPayPayload.isSuccess==true) {
      emit(JustPaySDKTCSignSuccessState(justPayPayload: justPayPayload));
    }else{
      emit(JustPaySDKTCSignFailedState(message: justPayPayload.code.toString()));
    }
  }

  Future<void> _onGetTermsEvent(
      GetOnboardTermsEvent event, Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());
    final result = await useCaseGetTerms!(
      GetTermsRequestEntity(
        messageType: kMessageTypeTermsAndConditionsGetReq,
        termType: event.termType,
      ),
    );

    emit(result.fold((l) {
     if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
       return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
     }
     else {
        return OnboardTermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      final TermsData? termsData = r.data!.data;
      return OnboardTermsLoadedState(termsData: termsData);
    }));
  }

  Future<void> _onAcceptTermsEvent(
      AcceptOnboardTermsEvent event, Emitter<BaseState<ContactInformationState>> emit) async {
    emit(APILoadingState());

    await storeWalletOnBoardingData!(
      Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.PERSONALINFO.toString(),
              stepperValue: KYCStep.PERSONALINFO.getStep())),
    );

    final result = await useCaseAcceptTerms!(
      TermsAcceptRequestEntity(
        justpayInstrumentId: event.justpayInstrumentId,
        termId: event.termId,
        acceptedDate: event.acceptedDate,
        messageType: kMessageTypeTermsAndConditionsAcceptReq,
        termType: event.termType,
        instrumentId: event.instrumentId
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return OnboardTermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return OnboardTermsSubmittedState();
    }));
  }
}
