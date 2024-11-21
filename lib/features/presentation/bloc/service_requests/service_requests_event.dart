
import '../base_event.dart';

abstract class ServiceRequestsEvent extends BaseEvent {}

class LoanRequestsFieldDataEvent extends ServiceRequestsEvent {}

class LoanRequestsSaveDataEvent extends ServiceRequestsEvent {
  final String? typeOfLoan;
  final String? loanAmount;
  final String? loanPeriod;
  final String? title;
  final String? fName;
  final String? lName;
  final String? nic;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? mobileNumber;
  final String? maritalStatus;
  final String? gender;
  final String? customerType;
  final String? companyName;
  final String? monthlyIncome;
  final String? id;
  final String? selectedFrontIdImage;
  final String? selectedBackIdImage;
  final String? selectedBankStatementsOneImage;
  final String? selectedBankStatementsTwoImage;
  final String? selectedSalaryConfirmationImage;

  LoanRequestsSaveDataEvent({
    this.maritalStatus,
    this.gender,
    this.customerType,
    this.companyName,
    this.selectedFrontIdImage,
    this.selectedBackIdImage,
    this.selectedBankStatementsOneImage,
    this.selectedBankStatementsTwoImage,
    this.selectedSalaryConfirmationImage,
    this.id,
    this.typeOfLoan,
    this.loanAmount,
    this.loanPeriod,
    this.monthlyIncome,
    this.title,
    this.fName,
    this.lName,
    this.nic,
    this.address1,
    this.address2,
    this.address3,
    this.mobileNumber,
  });
}

class CreditCardRequestsFieldDataEvent extends ServiceRequestsEvent {}

class CreditCardRequestsSaveEvent extends ServiceRequestsEvent {
  final String? title;
  final String? fName;
  final String? lName;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? maritalStatus;
  final String? genderStatus;
  final String? mobileNumber;
  final String? nic;
  final String? dob;
  final String? embossingName;

  CreditCardRequestsSaveEvent({
    this.address1,
    this.address2,
    this.address3,
    this.maritalStatus,
    this.genderStatus,
    this.mobileNumber,
    this.title,
    this.fName,
    this.lName,
    this.nic,
    this.dob,
    this.embossingName,
  });
}

class LeaseReqFieldDataEvent extends ServiceRequestsEvent {}

class LeaseReqSaveDataEvent extends ServiceRequestsEvent {
  final String? title;
  final String? fName;
  final String? lName;
  final String? nic;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? mobileNumber;
  final String? maritalStatus;
  final String? employerName;
  final String? employerDesignation;
  final String? monthlyIncome;
  final String? vehicleType;
  final String? makeAndModel;
  final String? yearOfManufacture;
  final String? registrationNo;
  final String? leaseTypeTenor;
  final String? amount;
  final String? gender;
  final String? empType;
  final String? selectedFrontIdImage;
  final String? selectedBackIdImage;
  final String? selectedBankStatementsOneImage;
  final String? selectedBankStatementsTwoImage;
  final String? selectedSalaryConfirmationImage;

  LeaseReqSaveDataEvent({
    this.title,
    this.fName,
    this.lName,
    this.nic,
    this.address1,
    this.address2,
    this.address3,
    this.mobileNumber,
    this.maritalStatus,
    this.employerName,
    this.employerDesignation,
    this.monthlyIncome,
    this.vehicleType,
    this.makeAndModel,
    this.yearOfManufacture,
    this.registrationNo,
    this.gender,
    this.selectedFrontIdImage,
    this.selectedBackIdImage,
    this.selectedBankStatementsOneImage,
    this.selectedBankStatementsTwoImage,
    this.selectedSalaryConfirmationImage,
    this.amount,
    this.leaseTypeTenor,
    this.empType,
  });
}

class ServiceReqHistoryEvent extends ServiceRequestsEvent {
  String? fromDate;
  String? toDate;
  String? requestType;

  ServiceReqHistoryEvent({
    this.fromDate,
    this.toDate,
    this.requestType,
  });
}

class LoanReqFieldEvent extends ServiceRequestsEvent {}

class ServiceReqHistoryFilteredEvent extends ServiceRequestsEvent {
  String? fromDate;
  String? toDate;
  String? requestType;

  ServiceReqHistoryFilteredEvent({
    this.fromDate,
    this.toDate,
    this.requestType,
  });
}

class DebitCardRequestsSaveEvent extends ServiceRequestsEvent {}

class DebitCardRequestsSaveDataEvent extends ServiceRequestsEvent {
  final String? cardCollectionBranch;
  final String? title;
  final String? fName;
  final String? lName;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? maritalStatus;
  final String? genderStatus;
  final String? mobileNumber;
  final String? nic;
  final String? motherName;
  final String? embossingName;
  final int? insID;

  DebitCardRequestsSaveDataEvent(
      {this.cardCollectionBranch,
      this.address1,
      this.address2,
      this.address3,
      this.maritalStatus,
      this.genderStatus,
      this.mobileNumber,
      this.motherName,
      this.title,
      this.fName,
      this.lName,
      this.nic,
      this.embossingName,
      this.insID});
}
//////new

class CheckBookRequestEvent extends ServiceRequestsEvent{
  String accountNumber;
  String collectionMethod;
  String branch;
  String address;
  int numberOfLeaves;
  String serviceCharge;

  CheckBookRequestEvent({
    required this.accountNumber,
    required this.collectionMethod,
    required this.branch,
    required this.address,
    required this.numberOfLeaves,
    required this.serviceCharge

  });

}


class FilterCheckBookEvent extends ServiceRequestsEvent{

  DateTime? fromDate;
  DateTime? toDate;
  String? accountNo;
  String? collectionMethod;


  FilterCheckBookEvent({

    this.fromDate,
    this.toDate,
    this.accountNo,
    this.collectionMethod,

  });

}

class FilterStatementEvent extends ServiceRequestsEvent{

  DateTime? fromDate;
  DateTime? toDate;
  String? accountNo;
  String? collectionMethod;


  FilterStatementEvent({

    this.fromDate,
    this.toDate,
    this.accountNo,
    this.collectionMethod,

  });

}

class ServiceChargeEvent extends ServiceRequestsEvent{
  String? messageType;

  ServiceChargeEvent({this.messageType});
}
