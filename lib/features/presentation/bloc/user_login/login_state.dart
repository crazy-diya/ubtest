
import '../../../data/models/responses/mobile_login_response.dart';
import '../base_state.dart';

abstract class LoginState extends BaseState<LoginState> {}

class InitialLoginState extends LoginState {}

class MobileLoginFailedState extends LoginState {
  final String? message;
  final String? errorCode;

  MobileLoginFailedState({this.message,this.errorCode});
}

class MobileLoginAPIFailedState extends LoginState {
  final String? message;
  final String? errorCode;

  MobileLoginAPIFailedState({this.message,this.errorCode,});
}

class MobileLoginSuccessState extends LoginState {
  final MobileLoginResponse? mobileLoginResponse;
  final String? responseCode;
  final String? responseDescription;

  MobileLoginSuccessState( {this.mobileLoginResponse, this.responseCode, this.responseDescription});
}

class MobileBioMetricPasswordSuccessState extends LoginState {
  final MobileLoginResponse? mobileLoginResponse;
  final String? responseCode;
  final String? responseDescription;

  MobileBioMetricPasswordSuccessState({this.mobileLoginResponse, this.responseCode, this.responseDescription});
}

class GetLoginCredentials extends LoginState {
  final bool? isAvailable;
  final String? username;

  GetLoginCredentials({this.isAvailable, this.username});
}

class StepperValueLoadedState extends LoginState {
  final String? routeString;
  final String? stepperName;
  final int? stepperValue;
  final bool? initialLaunchDone;

  StepperValueLoadedState(
      {this.routeString,
      this.stepperValue,
      this.stepperName,
      this.initialLaunchDone});
}

class BiometricPromptSuccessState extends LoginState{}

class GetImageApiFailState extends LoginState{}

class GetImageApiSuccessState extends LoginState{}