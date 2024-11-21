

import '../../../../data/models/responses/card_management/card_list_response.dart';

class CardTxnDetails {
    final String? currentOutstandingBalance;
    final String? maskedPrimaryCardNumber;
    final String? cmsAccNo;
    final String? minAmtDue;
    final String? availableBalance;
    final String? pymtDueDate;
    final String? cardTypeWithDesc;
    final String? cardStatusWithDesc;
    final String? cashLimit;
    final String? cardCustomerName;
    final List<CardResLast5Txn>? last5Txns;
    final String? creditLimit;
    final bool? isPrimary;
    final String? unBilledAmount;
    final String? lastPaidAmount;
    final String? lastPaidDate;
    final String? billedTransactionValue;
    final String? cardExpiryDate;
    final String? statementDate;
    final String? utilizedBalance;
    final String? displayFlag;
    final String? currency;


    CardTxnDetails({
        this.currentOutstandingBalance,
        this.maskedPrimaryCardNumber,
        this.cmsAccNo,
        this.minAmtDue,
        this.availableBalance,
        this.pymtDueDate,
        this.cardTypeWithDesc,
        this.cardStatusWithDesc,
        this.cashLimit,
        this.cardCustomerName,
        this.last5Txns,
        this.creditLimit,
        this.isPrimary, 
        this.unBilledAmount,
        this.lastPaidAmount,
        this.lastPaidDate,
        this.billedTransactionValue,
        this.cardExpiryDate,
        this.statementDate,
        this.utilizedBalance,
        this.displayFlag,
        this.currency,
    });
}


