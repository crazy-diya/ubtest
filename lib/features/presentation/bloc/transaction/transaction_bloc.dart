import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_user_inst_request.dart';
import 'package:union_bank_mobile/features/domain/usecases/home/get_user_instrument.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/transaction_filter_pdf_download.dart';
import '../../../data/models/requests/transaction_filter_request.dart';
import '../../../data/models/requests/transaction_filtered_exce_download_request.dart';
import '../../../data/models/requests/transaction_history_pdf_download_request.dart';
import '../../../data/models/requests/transaction_pdf_download.dart';
import '../../../data/models/requests/transcation_details_request.dart';
import '../../../domain/usecases/excel_download/transaction_filter_excel_download.dart';
import '../../../domain/usecases/pdf_download/transaction_filter_pdf_download.dart';
import '../../../domain/usecases/pdf_download/transaction_status_pdf_download.dart';
import '../../../domain/usecases/transaction_details/transaction_details.dart';
import '../../../domain/usecases/transaction_history/filter_transaction_history.dart';
import '../../../domain/usecases/transaction_history/transaction_history_pdf.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc
    extends BaseBloc<TransactionEvent, BaseState<TransactionState>> {
  final TransactionDetails? transactionDetails;
  final TransactionHistoryFilter? transactionHistoryFilter;
  final TransactionHistoryPdfDownload? transactionHistoryPdfDownload;
  final TransactionStatusPdfDownload? transactionStatusPdfDownload;
  final TransactionFilterPdfDownload? transactionFilterPdfDownload;
  final TransactionFilterExcelDownload? transactionFilterExcelDownload;
  final GetUserInstruments getUserInstruments;

  TransactionBloc( {
    this.transactionDetails,
    this.transactionHistoryPdfDownload,
    this.transactionHistoryFilter,
    this.transactionStatusPdfDownload,
    this.transactionFilterPdfDownload,
    this.transactionFilterExcelDownload,
    required this.getUserInstruments,
  }) : super(InitialTransactionState()) {
    on<GetTransactionDetailsEventEvent>(_onGetTransactionDetailsEventEvent);
    on<TransactionFilterEvent>(_onTransactionFilterEvent);
    on<TransactionStatusPdfDownloadEvent>(_onTransactionStatusPdfDownloadEvent);
    on<TransactionDetailsPdfDownloadEvent>(
        _onTransactionDetailsPdfDownloadEvent);
    on<TransactionFilterPdfDownloadEvent>(_onTransactionFilterPdfDownloadEvent);
    on<TransactionFilterExcelDownloadEvent>(_onTransactionFilterExcelDownloadEvent);
     on<GetInstrumentTransactionEvent>( _onGetPaymentInstrumentTransactionEvent);
  }

  Future<void> _onTransactionFilterPdfDownloadEvent(
      TransactionFilterPdfDownloadEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionFilterPdfDownload!(
      TransactionFilteredPdfDownloadRequest(
          page: event.page,
          size: event.size,
          fromDate: event.fromDate,
          toDate: event.toDate,
          fromAmount: event.fromAmount,
          toAmount: event.toAmount,
          tranType: event.tranType,
          accountNo: event.accountNo,
          channel: event.channel,
          messageType: event.messageType),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionDetailsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionFilterPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onTransactionFilterExcelDownloadEvent(
      TransactionFilterExcelDownloadEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionFilterExcelDownload!(
      TransactionFilteredExcelDownloadRequest(
          page: event.page,
          size: event.size,
          fromDate: event.fromDate,
          toDate: event.toDate,
          fromAmount: event.fromAmount,
          toAmount: event.toAmount,
          tranType: event.tranType,
          accountNo: event.accountNo,
          channel: event.channel,
          messageType: event.messageType),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionFilterExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionFilterExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onGetTransactionDetailsEventEvent(
      GetTransactionDetailsEventEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionDetails!(
      TransactionDetailsRequest(
        messageType: kTransactionDetailsRequestType,
        page: event.page,
        size: event.size,
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionDetailsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionDetailsSuccessState(
        txnDetailList: r.data!.txnDetailList,
        count: r.data!.count,
        message: r.responseDescription,
      );
    }));
  }

  Future<void> _onTransactionStatusPdfDownloadEvent(
      TransactionStatusPdfDownloadEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionStatusPdfDownload!(
      TransactionStatusPdfRequest(
        messageType: event.messageType,
        transactionId: event.tranNum,
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionStatusPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionStatusPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onTransactionFilterEvent(TransactionFilterEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionHistoryFilter!(
      TransactionFilterRequest(
          accountNo: event.account,
          fromAmount: event.fromAmount == 0 ? null : event.fromAmount,
          fromDate: event.fromDate,
          toAmount: event.toAmount == 0 ? null : event.toAmount,
          toDate: event.toDate,
          tranType: event.tranType,
          page: event.page,
          size: event.size,
          channel: event.channel),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionFilterFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionFilterSuccessState(
        txnDetailListFiltered: r.data?.txnDetailListFiltered,
        count: r.data!.count,
        message: r.responseDescription,
      );
    }));
  }

  Future<void> _onTransactionDetailsPdfDownloadEvent(
      TransactionDetailsPdfDownloadEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());
    final result = await transactionHistoryPdfDownload!(
      TransactionHistoryPdfDownloadRequest(
        messageType: kTransactionDetailsDownloadRequestType,
        transactionId: event.transactionId,
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return TransactionDetailsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionPdfDownloadSuccessState(
        image: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

    Future<void> _onGetPaymentInstrumentTransactionEvent(
      GetInstrumentTransactionEvent event,
      Emitter<BaseState<TransactionState>> emit) async {
    emit(APILoadingState());

    final response = await getUserInstruments(
      GetUserInstRequest(
        messageType: kGetUserInstrumentRequestType,
        requestType: RequestTypes.ACTIVE.name,
      ),
    );
    emit(response.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
        return GetInstrumentTransactionFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "824") {
        return GetInstrumentTransactionSuccessState(
            getUserInstList: r.data!.userInstrumentsList);
      } else {
        return GetInstrumentTransactionFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }
}
