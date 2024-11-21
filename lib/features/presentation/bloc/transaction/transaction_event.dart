import '../base_event.dart';

abstract class TransactionEvent extends BaseEvent {}

/// Get Transaction Details
class GetTransactionDetailsEventEvent extends TransactionEvent {
  final int? page;
  final int? size;

  GetTransactionDetailsEventEvent({this.page, this.size});
}

class TransactionFilterEvent extends TransactionEvent {
  final int? page;
  final int? size;
  final double? fromAmount;
  final double? toAmount;
  final String? fromDate;
  final String? toDate;
  final String? tranType;
  final String? account;
  final String? channel;

  TransactionFilterEvent(
      {this.channel,
      this.page,
      this.account,
      this.size,
      this.fromAmount,
      this.fromDate,
      this.toAmount,
      this.toDate,
      this.tranType});
}

///PDF
class TransactionDetailsPdfDownloadEvent extends TransactionEvent {
  final String? transactionId;
  final bool shouldOpen;

  TransactionDetailsPdfDownloadEvent({
    this.transactionId,
    this.shouldOpen = false,
  });
}

class TransactionFilterPdfDownloadEvent extends TransactionEvent {
  final int? page;
  final int? size;
  final String? fromDate;
  final String? toDate;
  final double? fromAmount;
  final double? toAmount;
  final String? tranType;
  final String? accountNo;
  final String? channel;
  final String? messageType;
  final bool shouldOpen;

  TransactionFilterPdfDownloadEvent({
    this.page,
    this.size,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.tranType,
    this.accountNo,
    this.channel,
    this.messageType,
    this.shouldOpen = false,
  });
}

class TransactionFilterExcelDownloadEvent extends TransactionEvent {
  final int? page;
  final int? size;
  final String? fromDate;
  final String? toDate;
  final double? fromAmount;
  final double? toAmount;
  final String? tranType;
  final String? accountNo;
  final String? channel;
  final String? messageType;
  final bool shouldOpen;

  TransactionFilterExcelDownloadEvent({
    this.page,
    this.size,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.tranType,
    this.accountNo,
    this.channel,
    this.messageType,
    this.shouldOpen = false,
  });
}

class TransactionStatusPdfDownloadEvent extends TransactionEvent {
  final String? tranNum;
  final String? messageType;

  final int? page;
  final int? size;
  final bool? shouldOpen;

  TransactionStatusPdfDownloadEvent({
    this.tranNum,
    this.messageType,
    this.page,
    this.size,
    this.shouldOpen = false,
  });
}

class GetInstrumentTransactionEvent extends TransactionEvent {
}
