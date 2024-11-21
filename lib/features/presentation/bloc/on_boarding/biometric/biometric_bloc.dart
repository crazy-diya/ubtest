import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/domain/entities/request/password_validation_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/password_validation/password_validation.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../../core/network/network_config.dart';
import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/biometric_enable_request.dart';
import '../../../../data/models/requests/cheque_book_request.dart';
import '../../../../data/models/requests/sr_statement_request.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/biometric/enable_biometric.dart';
import '../../../../domain/usecases/service_requests/cheque_book_field.dart';
import '../../../../domain/usecases/service_requests/sr_statement.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'biometric_event.dart';
import 'biometric_state.dart';

class BiometricBloc extends BaseBloc<BiometricEvent, BaseState<BiometricState>> {
  final LocalDataSource? appSharedData;
  final EnableBiometric? enableBiometric;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;
  final PasswordValidation? passwordValidation;
  final ChequeBookField? checkBookField;
  final SrStatement? srStatement;

  BiometricBloc( {
    this.appSharedData,
    this.enableBiometric,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.passwordValidation,
    this.srStatement,
    this.checkBookField
  }) : super(InitialBiometricState()) {
    on<EnableBiometricEvent>(_enableBiometricEvent);
    on<SaveUserEvent>(_saveUserEvent);
    on<RequestBiometricPromptEvent>(_requestBiometricPromptEvent);
    on<PasswordValidationEvent>(_passwordValidationEvent);
    on<CheckBookPasswordRequestEvent>(_mapCheckBookPasswordRequestEvent);
    on<StatementRequestEvent>(_mapStatementRequestEvent);
  }

  Future<void> _enableBiometricEvent(
      EnableBiometricEvent event, Emitter<BaseState<BiometricState>> emit) async {
    emit(APILoadingState());
    final result = await enableBiometric!(
      BiometricEnableRequest(
          messageType: kEnableBiometricRequestType,
          enableBiometric: event.shouldEnableBiometric),
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
      }else {
        return EnableBiometricFailedState(
            error: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (event.shouldEnableBiometric == true) {
        appSharedData!.setBiometric(r.data!.uniqueCode);
        AppConstants.BIOMETRIC_CODE = r.data!.uniqueCode;
        return EnableBiometricSuccessState();
      } else {
        appSharedData!.clearBiometric();
        AppConstants.BIOMETRIC_CODE = null;
        return DisableBiometricSuccessState();
      }
    }));
  }

  Future<void> _saveUserEvent(
      SaveUserEvent event, Emitter<BaseState<BiometricState>> emit) async {
    emit(APILoadingState());
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Store the Wallet Data
      final _result = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperName: KYCStep.SCHEDULEVERIFY.toString(),
            stepperValue: KYCStep.SCHEDULEVERIFY.getStep(),
            walletUserData: result
                .getOrElse(
                  (l) => null,
            )!
                .walletUserData,
          ),
        ),
      );

      _result.fold((l) {
        if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
          return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        }else {
        emit(SaveUserFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }

      }, (r) {
        emit(SaveUserSuccessState());
      });
    } else {
      emit(SaveUserFailedState(
         ));
    }
  }

  void _requestBiometricPromptEvent(
      RequestBiometricPromptEvent event, Emitter<BaseState<BiometricState>> emit) {
    emit(BiometricPromptSuccessState());
  }

Future<void> _passwordValidationEvent(
      PasswordValidationEvent event, Emitter<BaseState<BiometricState>> emit) async {
    emit(APILoadingState());

    final result = await passwordValidation!(
      PasswordValidationRequestEntity(messageType: kPasswordValidationRequestType,password: event.password!.toBase64())
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
      }else {
         return PasswordValidationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.data?.status =="SUCCESS"){
       return PasswordValidationSuccessState(
        status: r.data?.status,
        message: r.data?.message
      );
      }else {
        return PasswordValidationFailedState(
            message:  r.data?.message);
      }
    }));
  }

  ///cheque book password bloc///

  Future<void> _mapCheckBookPasswordRequestEvent(CheckBookPasswordRequestEvent event,
      Emitter<BaseState<BiometricState>> emit) async {
    emit(APILoadingState());
    final _result = await checkBookField!(
      ChequeBookRequest(
        // messageType: kUpdateProfileDetails,
          accountNumber: event.accountNumber,
          collectionMethod: event.collectionMethod,
          branch: event.branch,
          address: event.address,
          numberOfLeaves: event.numberOfLeaves,
          serviceCharge: event.serviceCharge),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return CheckBookRequestPasswordFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS) {
        // localDataSource?.setLoginName(event.uName);
        // localDataSource?.setUserName(event.uName);
        // AppConstants.profileData.mobileNo = event.mobile;
        // AppConstants.profileData.email = event.email;
        // AppConstants.profileData.userName = event.uName;
        // AppConstants.profileData.name = event.name;
        // AppConstants.profileData.fName = event.cName;
        return CheckBookRequestPasswordSuccessState(
          code: r.data!.id.toString(),
        );
      } else {
        return CheckBookRequestPasswordFailedState(
            message: r.errorDescription ?? r.errorDescription);
      }
    }));
  }


  Future<void> _mapStatementRequestEvent(StatementRequestEvent event,
      Emitter<BaseState<BiometricState>> emit) async {
    emit(APILoadingState());
    final _result = await srStatement!(
      SrStatementRequest(
        // messageType: kUpdateProfileDetails,
          accountNumber: event.accountNumber,
          collectionMethod: event.collectionMethod,
          branch: event.branch,
          address: event.address,
          numberOfLeaves: event.numberOfLeaves,
          startDate: event.startDate,
          endDate: event.endDate,
          serviceCharge: event.serviceCharge),
    );
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return StatementRequestFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS) {
        // localDataSource?.setLoginName(event.uName);
        // localDataSource?.setUserName(event.uName);
        // AppConstants.profileData.mobileNo = event.mobile;
        // AppConstants.profileData.email = event.email;
        // AppConstants.profileData.userName = event.uName;
        // AppConstants.profileData.name = event.name;
        // AppConstants.profileData.fName = event.cName;
        return StatementRequestSuccessState(
          code: r.data!.id.toString(),
        );
      } else {
        return StatementRequestFailedState(
            message: r.errorDescription ?? r.errorDescription);
      }
    }));
  }







}







