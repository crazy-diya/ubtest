import 'package:union_bank_mobile/features/data/models/responses/get_user_inst_response.dart';

import '../../../data/models/responses/transcation_details_response.dart';

import '../base_state.dart';

abstract class TransactionState extends BaseState<TransactionState> {}

class InitialTransactionState extends TransactionState {}

class TransactionDetailsFailedState extends TransactionState {
  final String? message;
  final String? code;

  TransactionDetailsFailedState({this.message, this.code});
}

class TransactionDetailsSuccessState extends TransactionState {
  final List<TxnDetailList>? txnDetailList;
  final int? count;
  final String? message;

  TransactionDetailsSuccessState({
    this.txnDetailList,
    this.count,
    this.message,
  });
}



class TransactionStatusPdfDownloadSuccessState extends TransactionState {
  final String? document;
  final bool? shouldOpen;

  TransactionStatusPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class TransactionStatusPdfDownloadFailedState extends TransactionState {
  final String? message;

  TransactionStatusPdfDownloadFailedState({this.message});
}




class TransactionFilterFailedState extends TransactionState {
  final String? message;
  final String? code;

  TransactionFilterFailedState({this.message, this.code});
}

class TransactionFilterSuccessState extends TransactionState {
  final List<TxnDetailList>? txnDetailListFiltered;
  final int? count;
  final String? message;

  TransactionFilterSuccessState({
     this.txnDetailListFiltered,
    this.count,
    this.message,
  });
}





class TransactionPdfDownloadSuccessState extends TransactionState{
final String? image;
final bool? shouldOpen;

  TransactionPdfDownloadSuccessState({this.image,this.shouldOpen,});
}

class TransactionDetailsPdfDownloadFailedState extends TransactionState {
  final String? message;
  final String? code;

  TransactionDetailsPdfDownloadFailedState({this.message,this.code,});
}

class TransactionFilterPdfDownloadSuccessState extends TransactionState {
  final String? document;
  final bool? shouldOpen;

  TransactionFilterPdfDownloadSuccessState({this.document,this.shouldOpen,});
}

class TransactionFilterPdfDownloadFailedState extends TransactionState {
  final String? message;
  final String? code;

  TransactionFilterPdfDownloadFailedState({this.message,this.code});
}

class TransactionFilterExcelDownloadSuccessState extends TransactionState {
  final String? document;
  final bool? shouldOpen;

  TransactionFilterExcelDownloadSuccessState({this.document,this.shouldOpen,});
}

class TransactionFilterExcelDownloadFailedState extends TransactionState {
  final String? message;
  final String? code;

  TransactionFilterExcelDownloadFailedState({this.message,this.code});
}

class GetInstrumentTransactionSuccessState extends TransactionState {
  final List<UserInstruments>? getUserInstList;

  GetInstrumentTransactionSuccessState({this.getUserInstList});
}
class GetInstrumentTransactionFailedState extends TransactionState {
  final String? message;

  GetInstrumentTransactionFailedState({this.message});
}




