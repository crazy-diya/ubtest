import 'package:union_bank_mobile/features/data/models/requests/card_management/card_txn_history_request.dart';

class CardTxnHistoryRequestEntity extends CardTxnHistoryRequest {
  final String? maskedCardNumber;
  final String? messageType;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;

  CardTxnHistoryRequestEntity({
    this.maskedCardNumber,
    this.messageType,
    this.txnMonthsFrom,
    this.txnMonthsTo,
  }) : super(
            maskedCardNumber: maskedCardNumber,
            messageType: messageType,
            txnMonthsFrom: txnMonthsFrom,
            txnMonthsTo: txnMonthsTo);
}
