import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/domain/entities/request/biometric_login_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/mobile_login_request_entity.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_string.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../domain/usecases/biometric/biometric_login.dart';
import '../../../domain/usecases/epicuser_id/save_epicuser_id.dart';
import '../../../domain/usecases/login/mobile_login.dart';
import '../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, BaseState<LoginState>> {
  final MobileLogin? mobileLogin;
  final BiometricLogin? biometricLogin;
  final LocalDataSource? localDataSource;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final SetEpicUserID? setEpicUserID;
  LoginBloc({
    this.mobileLogin,
    this.localDataSource,
    this.getWalletOnBoardingData,
    this.biometricLogin,
    this.setEpicUserID,
  }) : super(InitialLoginState()) {
    on<MobileLoginEvent>(_onMobileLoginEvent);
    // on<MobileBioMetricPasswordEvent>(_onMobileBioMetricPasswordEvent);
    on<BiometricLoginEvent>(_onBiometricLoginEvent);
    on<CheckCredentialAvailability>(_onCheckCredentialAvailability);
    on<GetStepperValueEvent>(_onGetStepperValueEvent);
    on<RequestBiometricPromptEvent>(_onRequestBiometricPromptEvent);
  }

  Future<void> _onMobileLoginEvent(
      MobileLoginEvent event, Emitter<BaseState<LoginState>> emit) async {
    emit(APILoadingState());
    if (event.username!.isEmpty) {
      emit(MobileLoginFailedState(message: AppString.emptyUsername));
    } else if (event.password!.isEmpty) {
      emit(MobileLoginFailedState(message: AppString.password));
    } else {
      final _result = await mobileLogin!(
        MobileLoginRequestEntity(
          messageType: kMobileLoginRequestType,
          username: event.username?.trim(),
          password: event.password?.trim().toBase64(), 
        ),
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
          return MobileLoginAPIFailedState(
              errorCode: (l as ServerFailure).errorResponse.errorCode,
              message: ErrorHandler().mapFailureToMessage(l));
        }
      }, (r) {
        // AppConstants.FIRST_NAME=r.data!.firstName;
        if (r.errorCode == "dbp-364") {
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        } else if (r.errorCode == "840") {
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        }else if (r.errorCode == "820") {
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        }else if (r.errorCode == "845") {
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        }else if (r.errorCode == "841") {
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        } else if (r.responseCode == "841"){
          return MobileLoginAPIFailedState(
              errorCode: r.responseCode, message: r.responseDescription);
        }else if (r.errorCode == "dbp-456"){
          return MobileLoginAPIFailedState(
              errorCode: r.errorCode, message: r.errorDescription);
        }else if (r.responseCode == "dbp-353"){
          return MobileLoginAPIFailedState(
              errorCode: r.responseCode, message: r.responseDescription);
        }else if (r.responseCode == "dbp-456"){
          return MobileLoginAPIFailedState(
              errorCode: r.responseCode, message: r.responseDescription);
        } else {
          localDataSource?.setEpicUserId(r.epicUserID!);
          localDataSource!.setAccessToken(r.data!.accessToken);
          localDataSource!.setRefreshToken(r.data!.refreshToken);
          localDataSource!.setMigratedFlag(r.data?.isMigrated??"");
          return MobileLoginSuccessState(
              mobileLoginResponse: r.data,
              responseCode: r.responseCode,
              responseDescription: r.responseDescription,
              );
        }
        
      }));
    }
  }

  Future<void> _onBiometricLoginEvent(
      BiometricLoginEvent event, Emitter<BaseState<LoginState>> emit) async {
    emit(APILoadingState());
    final _result = await biometricLogin!(
      BiometricLoginRequestEntity(
          messageType: kBiometricLoginRequestType,
          uniqueCode: AppConstants.BIOMETRIC_CODE),
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
        return MobileLoginAPIFailedState(
            errorCode: (l as ServerFailure).errorResponse.errorCode??'',
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.errorCode == "dbp-364") {
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      } else if (r.errorCode == "840") {
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      }else if (r.errorCode == "820") {
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      }else if (r.errorCode == "845") {
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      }else if (r.errorCode == "841") {
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      } else if (r.responseCode == "841"){
        return MobileLoginAPIFailedState(
            errorCode: r.responseCode, message: r.responseDescription);
      }else if (r.errorCode == "dbp-456"){
        return MobileLoginAPIFailedState(
            errorCode: r.errorCode, message: r.errorDescription);
      }else if (r.responseCode == "dbp-353"){
        return MobileLoginAPIFailedState(
            errorCode: r.responseCode, message: r.responseDescription);
      }else if (r.responseCode == "dbp-456"){
          return MobileLoginAPIFailedState(
              errorCode: r.responseCode, message: r.responseDescription);
      } else {
        localDataSource?.setEpicUserId(r.epicUserID!);
        localDataSource!.setAccessToken(r.data!.accessToken);
        localDataSource!.setRefreshToken(r.data!.refreshToken);
        localDataSource!.setMigratedFlag(r.data?.isMigrated??"");
        return MobileLoginSuccessState(
          mobileLoginResponse: r.data,
          responseCode: r.responseCode,
          responseDescription: r.responseDescription);
        }
    }));
  }

  Future<void> _onCheckCredentialAvailability(CheckCredentialAvailability event,
      Emitter<BaseState<LoginState>> emit) async {
    final availability = await localDataSource!.hasUsername();
        if (availability) {
      final username = await localDataSource!.getUsername();
      emit(GetLoginCredentials(isAvailable: true, username: username));
    } else {
      emit(GetLoginCredentials(isAvailable: false, username: null));
    }
  }

  Future<void> _onGetStepperValueEvent(
      GetStepperValueEvent event, Emitter<BaseState<LoginState>> emit) async {
    final availability = await localDataSource!.hasUsername();
        if (availability) {
      final username = await localDataSource!.getUsername();
      emit(GetLoginCredentials(isAvailable: true, username: username));
    } else {
      emit(GetLoginCredentials(isAvailable: false));
         }
  }

  Future<void> _onRequestBiometricPromptEvent(RequestBiometricPromptEvent event,
      Emitter<BaseState<LoginState>> emit) async {
    emit(BiometricPromptSuccessState());
  }

}
