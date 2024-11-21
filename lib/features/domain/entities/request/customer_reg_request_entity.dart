import '../../../data/models/requests/customer_reg_request.dart';

// ignore: must_be_immutable
class CustomerRegistrationRequestEntity extends CustomerRegistrationRequest {
  CustomerRegistrationRequestEntity(
      {this.messageType,
      this.obType,
      this.title,
      this.initials,
      this.initialsInFull,
      this.lastName,
      this.nationality,
      this.gender,
      this.language,
      this.religion,
      this.nic,
      this.dateOfBirth,
      this.mobileNo,
      this.email,
      this.maritalStatus,
      this.perAddress})
      : super(
          title: title,
          initials: initials,
          initialsInFull: initialsInFull,
          lastName: lastName,
          nationality: nationality,
          gender: gender,
          language: language,
          religion: religion,
          nic: nic,
          dateOfBirth: dateOfBirth,
          mobileNo: mobileNo,
          email: email,
          maritalStatus: maritalStatus,
          perAddress: perAddress,
          messageType: messageType,
          obType: obType,
        );

  final String? messageType;
  final String? obType;
  final String? title;
  final String? initials;
  final String? initialsInFull;
  final String? lastName;
  final String? nationality;
  final String? gender;
  final String? language;
  final String? religion;
  final String? nic;
  final String? dateOfBirth;
  final String? mobileNo;
  final String? email;
  final String? maritalStatus;
  final List<PerAddress>? perAddress;
}
