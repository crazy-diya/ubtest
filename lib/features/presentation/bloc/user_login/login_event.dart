import '../base_event.dart';

abstract class LoginEvent extends BaseEvent {}

class MobileLoginEvent extends LoginEvent {
  final String? username;
  final String? password;

  MobileLoginEvent( {this.username, this.password,});
}

class MobileBioMetricPasswordEvent extends LoginEvent {
  final String? username;
  final String? password;

  MobileBioMetricPasswordEvent({this.username, this.password});
}

class BiometricLoginEvent extends LoginEvent{}

class CheckCredentialAvailability extends LoginEvent {}

class GetStepperValueEvent extends LoginEvent {}

class RequestBiometricPromptEvent extends LoginEvent{}

class GetImageEvent extends LoginEvent{}
