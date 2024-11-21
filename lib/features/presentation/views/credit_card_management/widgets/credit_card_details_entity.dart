import '../../../../data/models/responses/card_management/card_detals_response.dart';

class CreditCardDetails {
  String? cardType;
  String? cardNumber;
  String? accountNumber;
  String? outstandingBalance;
  String? creditLimit;
  String? availableToSpentAmount;
  String? lastPaymentAmount;
  String? lastPaymentDate;
  String? pendingAuthorizationAmount;
  String? installmentPayableBalance;
  String? statementBalance;
  String? minimumPaymentDue;
  String? paymentDueDate;
  String? statementDate;
  String? totalLoyaltyPoints;
  String? name;
  String? cardStatus;
  String? cardLimit;
  String? bankCode;
  String? billedTotal;
  List<ResAddonDetail>? resAddonDetails;

  CreditCardDetails({
    this.cardType,
    this.cardNumber,
    this.accountNumber,
    this.outstandingBalance,
    this.creditLimit,
    this.availableToSpentAmount,
    this.lastPaymentAmount,
    this.lastPaymentDate,
    this.pendingAuthorizationAmount,
    this.installmentPayableBalance,
    this.statementBalance,
    this.minimumPaymentDue,
    this.paymentDueDate,
    this.statementDate,
    this.totalLoyaltyPoints,
    this.name,
    this.cardStatus,
    this.cardLimit,
    this.bankCode,
    this.resAddonDetails,
    this.billedTotal,
  });
}
