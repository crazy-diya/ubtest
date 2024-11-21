import '../../../data/models/requests/emp_detail_request.dart';


class EmpDetailsRequestEntity extends EmpDetailRequest {
  EmpDetailsRequestEntity({this.isTaxPayerUs, this.purposeOfAcc, this.empType, this.filedOfEmp, this.designationUiValue, this.designation, this.nameOfEmp, this.addressOfEmp, this.annualIncome, this.marketingRefCode, this.sourceOfIncome, this.expectedTransactionMode, this.anticipatedDepositPerMonth, this.isPoliticallyExposed, this.isInvolvedInPolitics, this.isPositionInParty, this.isMemberOfInst,this.messageType}) : super(
      isInvolvedInPolitics: isInvolvedInPolitics,
      isPoliticallyExposed: isPoliticallyExposed,
      anticipatedDepositPerMonth: anticipatedDepositPerMonth,
      expectedTransactionMode: expectedTransactionMode,
      sourceOfIncome: sourceOfIncome,
      marketingRefCode: marketingRefCode,
      annualIncome: annualIncome,
      addressOfEmp: addressOfEmp,
      nameOfEmp: nameOfEmp,
      designation: designation,
      designationUiValue: designationUiValue,
      filedOfEmp: filedOfEmp,
      empType: empType,
      purposeOfAcc: purposeOfAcc,
      isTaxPayerUs: isTaxPayerUs,
      messageType: messageType,
      isPositionInParty:isPositionInParty,
      isMemberOfInst: isMemberOfInst,
  );


  final String? messageType;
  final String? isTaxPayerUs;
  final String? purposeOfAcc;
  final String? empType;
  final String? filedOfEmp;
  final String? designationUiValue;
  final int? designation;
  final String? nameOfEmp;
  final AddressOfEmp? addressOfEmp;
  final String? annualIncome;
  final String? marketingRefCode;
  final String? sourceOfIncome;
  final String? expectedTransactionMode;
  final String? anticipatedDepositPerMonth;
  final String? isPoliticallyExposed;
  final String? isInvolvedInPolitics;
  final String? isPositionInParty;
  final String? isMemberOfInst;
}