// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../base_event.dart';

abstract class BiometricEvent extends BaseEvent {}

class EnableBiometricEvent extends BiometricEvent {
  final bool? shouldEnableBiometric;

  EnableBiometricEvent({this.shouldEnableBiometric});
}

class SaveUserEvent extends BiometricEvent {}

class RequestBiometricPromptEvent extends BiometricEvent {}

class PasswordValidationEvent extends BiometricEvent {
  String? password;
  PasswordValidationEvent({
    this.password,
  });
}
class CheckBookPasswordRequestEvent extends BiometricEvent{

  String accountNumber;
  String collectionMethod;
  String branch;
  String address;
  int numberOfLeaves;
  String? serviceCharge;

  CheckBookPasswordRequestEvent({
    required this.accountNumber,
    required this.collectionMethod,
    required this.branch,
    required this.address,
    required this.numberOfLeaves,
    this.serviceCharge
  });

}
class StatementRequestEvent extends BiometricEvent{

  String? accountNumber;
  String? collectionMethod;
  String? branch;
  String? address;
  int? numberOfLeaves;
  String? serviceCharge;
  DateTime? startDate;
  DateTime? endDate;

  StatementRequestEvent({
     this.accountNumber,
     this.collectionMethod,
     this.branch,
     this.address,
     this.numberOfLeaves,
    this.serviceCharge,
    this.startDate,
    this.endDate,
  });

}
