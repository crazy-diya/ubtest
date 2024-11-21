import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/fund_transfer_excel_dwnload_request.dart';
import '../../../data/models/requests/fund_transfer_pdf_download_request.dart';
import '../../../data/models/requests/fund_transfer_scheduling_request.dart';
import '../../../data/models/requests/get_all_schedule_fund_transfer_request.dart';
import '../../../data/models/requests/intra_fund_transfer_request.dart';
import '../../../data/models/requests/req_money_notification_history_request.dart';
import '../../../data/models/requests/transaction_limit_add_request.dart';
import '../../../data/models/requests/transaction_limit_request.dart';
import '../../../domain/usecases/biller_management/scheduling_bill_payment.dart';
import '../../../domain/usecases/fund_transfer/fund__transfer_excel_download.dart';
import '../../../domain/usecases/fund_transfer/fund_transfer_receipt_download.dart';
import '../../../domain/usecases/fund_transfer/get_all_schedule_ft.dart';
import '../../../domain/usecases/fund_transfer/intra_fund_transfer.dart';
import '../../../domain/usecases/fund_transfer/one_time_fund_transfer.dart';
import '../../../domain/usecases/fund_transfer/scheduling_fund_transfer.dart';
import '../../../domain/usecases/notifications/req_money_notification_status.dart';
import '../../../domain/usecases/transaction_details/transaction_limit.dart';
import '../../../domain/usecases/transaction_details/transaction_limit_add.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'fund_transfer_event.dart';
import 'fund_transfer_state.dart';

class FundTransferBloc
    extends BaseBloc<FundTransferEvent, BaseState<FundTransferState>> {
  final FundTransfer? fundTransfer;
  final OneTimeFundTransfer? oneTimeFundTransfer;
  final SchedulingFundTransfer? schedulingFundTransfer;
  final TransactionLimit? transactionLimit;
  final TransactionLimitAdd? transactionLimitAdd;
  final FundTransferPdfDownload? fundTransferPdfDownload;
  final GetAllScheduleFT? getAllScheduleFT;
  final FundTransferExcelDownload? fundTransferExcelDownload;
  final SchedulingBillPayment? schedulingBillPayment;
  final ReqMoneyNotificationStatus reqMoneyNotificationStatus;


  FundTransferBloc({
    this.transactionLimit,
    this.transactionLimitAdd,
    this.fundTransfer,
    this.oneTimeFundTransfer,
    this.schedulingFundTransfer,
    this.fundTransferPdfDownload,
    this.getAllScheduleFT,
    this.fundTransferExcelDownload,
    this.schedulingBillPayment,
    required this.reqMoneyNotificationStatus,
  }) : super(InitialFundTransferState()) {
    on<AddIntraFundTransferEvent>(_onAddIntraFundTransferEvent);
    // on<OneTimeFundTransferEvent>(_onOneTimeFundTransferEvent);
    on<SchedulingFundTransferEvent>(_onSchedulingFundTransferEvent);
    on<TransactionLimitEvent>(_onTransactionLimitEvent);
    on<TransactionLimitAddEvent>(_onTransactionLimitAddEvent);
    on<FundTransferReceiptDownloadEvent>(_onFundTransferReceiptDownloadEvent);
    on<GetAllScheduleFTEvent>(_onGetAllScheduleFTEvent);
    on<FundTransferExcelDownloadEvent>(_onFundTransferExcelDownloadEvent);
    // on<SchedulingBillPaymentEvent>(_onSchedulingBillPaymentEvent);
    on<ReqMoneyFundTranStatusEvent>(_reqMoneyNotificationStatus);
  }

  Future<void> _onAddIntraFundTransferEvent(
    AddIntraFundTransferEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());
    final _result = await fundTransfer!(
      IntraFundTransferRequest(
          messageType: kFundTranRequestType,
          transactionCategory: event.transactionCategory,
          instrumentId: event.instrumentId,
          toAccountName: event.toAccountName,
          toAccountNo: event.toAccountNo,
          toBankCode: event.toBankCode,
          amount: event.amount!.toStringAsFixed(2),
          remarks: event.remarks,
          email: event.beneficiaryEmail,
          mobile: event.beneficiaryMobileNo,
          reference: event.reference,
          isCreditCardPayment: event.isCreditCardPayment??false,
          tranType: event.tranType ?? "FT"),
    );

    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return IntraFundTransferFailedState(
          message: ErrorHandler().mapFailureToMessage(l),
          code: (l as ServerFailure).errorResponse.errorCode??'',
        );
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
      return IntraFundTransferSuccessState(
        responseDescription: r.responseDescription,
        intraFundTransferResponse: r.data,
      );

      }else{
         return IntraFundTransferFailedState(
          message:r.errorDescription??r.responseDescription,
          code: r.errorCode??r.responseCode,
           transactionReferenceNumber: r.transactionReferenceNumber
        );

      }
    }));
  }

  // Future<void> _onOneTimeFundTransferEvent(
  //   OneTimeFundTransferEvent event,
  //   Emitter<BaseState<FundTransferState>> emit,
  // ) async {
  //   emit(APILoadingState());

  //   final _result = await oneTimeFundTransfer!(
  //     OneTimeFundTransferRequest(
  //       messageType: "",
  //     ),
  //   );

  //   emit(_result.fold((l) {
  //     if (l is AuthorizedFailure) {
  //       return SessionExpireState();
  //     } else {
  //       return OneTimeFundTransferFailedState(
  //           message: ErrorHandler().mapFailureToMessage(l));
  //     }
  //   }, (r) {
  //     if(r.responseCode=="00"){
  //        return OneTimeFundTransferSuccessState();

  //     }else{
  //       return OneTimeFundTransferFailedState(
  //           message: r.errorDescription??r.responseDescription);

  //     }
     
  //   }));
  // }

  // Add other event handler methods here
  Future<void> _onSchedulingFundTransferEvent(
    SchedulingFundTransferEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());

    final _result = await schedulingFundTransfer!(SchedulingFundTransferRequest(
        messageType: kScheduleFtReqType,
        amount: event.amount!.toStringAsFixed(2),
        status: event.status,
        reference: event.reference,
        transCategory: event.transCategory,
        toBankCode: event.toBankCode,
        toAccountName: event.toAccountName,
        startDay: 0,
        scheduleType: event.scheduleType,
        scheduleTitle: event.scheduleTitle,
        scheduleSource: event.scheduleSource,
        paymentInstrumentId: event.paymentInstrumentId,
        // modifiedUser: event.modifiedUser,
        // beneficiaryEmail: event.beneficiaryEmail,
        // beneficiaryEmail: "kasunm@gmail.com",
        startDate: event.startDate,
        toAccountNo: event.toAccountNo,
        beneficiaryMobile: event.beneficiaryMobile,
        // createdUser: event.createdUser,
        endDate: event.endDate,
        failCount: event.failCount,
        frequency: event.frequency,
        tranType: event.tranType,
      remarks: event.remarks,
    ));

    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return SchedulingFundTransferFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode=="000"){
         return SchedulingFundTransferSuccessState(
        schedulingFundTransferResponse: r.data,
      );

      }else{
        return SchedulingFundTransferFailedState(
            message: r.errorDescription??r.responseDescription);

      }
     
    }));
  }

  // Future<void> _onSchedulingBillPaymentEvent(
  //     SchedulingBillPaymentEvent event,
  //     Emitter<BaseState<FundTransferState>> emit,
  //     ) async {
  //   emit(APILoadingState());

  //   final _result = await schedulingBillPayment!(ScheduleBillPaymentRequest(
  //     messageType: kScheduleFtReqType,
  //     amount: event.amount,
  //     status: event.status,
  //     reference: event.reference,
  //     transCategory: event.transCategory,
  //     toBankCode: event.toBankCode,
  //     toAccountName: event.toAccountName,
  //     startDay: 0,
  //     scheduleType: event.scheduleType,
  //     scheduleTitle: event.scheduleTitle,
  //     scheduleSource: event.scheduleSource,
  //     paymentInstrumentId: event.paymentInstrumentId,
  //     modifiedUser: event.modifiedUser,
  //    // beneficiaryEmail: event.beneficiaryEmail,
  //     beneficiaryEmail: event.beneficiaryEmail,
  //     startDate: event.startDate,
  //     toAccountNo: event.toAccountNo,
  //     beneficiaryMobile: event.beneficiaryMobile,
  //     createdDate: event.createdDate,
  //     createdUser: event.createdUser,
  //     endDate: event.endDate,
  //     failCount: event.failCount,
  //     frequency: event.frequency,
  //     modifiedDate: event.modifiedDate,
  //     tranType: event.tranType,
  //     remarks: event.remarks,
  //     billerId: event.billerId,
  //   ));

  //   emit(_result.fold((l) {
  //      if (l is AuthorizedFailure) {
  //       return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
  //     } else if (l is SessionExpire) {
  //       return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
  //     } else if (l is ConnectionFailure) {
  //       return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
  //     } else {
  //       return SchedulingBillPaymentFailedState(
  //           message: ErrorHandler().mapFailureToMessage(l));
  //     }
  //   }, (r) {
  //     if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "000") {
  //       return SchedulingBillPaymentSuccessState(
  //         scheduleBillPaymentResponse: r.data,
  //       );
  //     } else {
  //       return SchedulingBillPaymentFailedState(
  //           message: r.errorDescription ?? r.responseDescription);
  //     }
  //   }));
  // }

  Future<void> _onTransactionLimitEvent(
    TransactionLimitEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());

    final _result = await transactionLimit!(
      TransactionLimitRequest(
        messageType: kTxnDetailsRequestType,
        channelType: kChannelType,
      ),
    );

    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return TransactionLimitFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionLimitSuccessState(
        count: r.data!.count,
        txnLimitDetail: r.data!.txnLimitDetails,
      );
    }));
  }

  Future<void> _onTransactionLimitAddEvent(
    TransactionLimitAddEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());

    final _result = await transactionLimitAdd!(
      TransactionLimitAddRequest(
        messageType: kFundTranRequestType,
        code: event.code,
        channelType: event.channelType,
        maxAmountPerDay: event.maxAmountPerDay,
      ),
    );

    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return TransactionLimitAddFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TransactionLimitAddSuccessState(
        baseResponse: r,
      );
    }));
  }

  Future<void> _onFundTransferReceiptDownloadEvent(
    FundTransferReceiptDownloadEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());
    final result = await fundTransferPdfDownload!(
      FundTransferPdfDownloadRequest(
          transactionId: event.transactionId,
        transactionType: 'FT',
        messageType: event.messageType,
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
       }else {
        return FundTransferReceiptDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return FundTransferReceiptDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onGetAllScheduleFTEvent(
    GetAllScheduleFTEvent event,
    Emitter<BaseState<FundTransferState>> emit,
  ) async {
    emit(APILoadingState());
    final response = await getAllScheduleFT!(
      GetAllScheduleFtRequest(
        messageType: kGetAllScheduleFtReqType,
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
       }else {
        return GetAllScheduleFTFailedState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetAllScheduleFTSuccessState(
        scheduleFtList: r.data!.scheduleFtList,
      );
    }));
  }



  Future<void> _onFundTransferExcelDownloadEvent(
      FundTransferExcelDownloadEvent event,
      Emitter<BaseState<FundTransferState>> emit,
      ) async {
    emit(APILoadingState());
    final result = await fundTransferExcelDownload!(
      FundTransferExcelDownloadRequest(
        transactionId: event.transactionId,
        transactionType: 'FT',
        messageType: event.messageType,
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
       }else {
        return FundTransferExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return FundTransferExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }


  ///req money
  Future<void> _reqMoneyNotificationStatus(ReqMoneyFundTranStatusEvent event,
      Emitter<BaseState<FundTransferState>> emit) async {
    emit(APILoadingState());
    final _result = await reqMoneyNotificationStatus(
        ReqMoneyNotificationHistoryRequest(
          messageType: event.messageType,
          requestMoneyId: event.requestMoneyId,
          status: event.status,
          transactionStatus: event.transactionStatus,
          transactionId: event.transactionId
        ));

    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return ReqMoneyFundTranStatusFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ReqMoneyFundTranStatusSuccessState(
          id: r.data!.requestMoneyId,
          description: r.data!.description
      );
    }));
  }












}

// Future<void> _handleGetUserInstrumentForTransferEvent(GetUserInstrumentForTransferEvent event,
//     Emitter<BaseState<FundTransferState>> emit) async {
//   emit(APILoadingState());
//
//   final response = await getUserInstruments!(
//     GetUserInstRequest(
//       messageType: kGetUserInstrumentRequestType,
//       requestType: event.requestType,
//     ),
//   );
//   emit(response.fold((l) {
//     if (l is AuthorizedFailure) {
//       return SessionExpireState();
//     } else {
//       return GetUserInstrumentForTransferFailedState(
//           message: ErrorHandler().mapFailureToMessage(l));
//     }
//   }, (r) {
//     return GetUserInstrumentForTransferSuccessState(
//         getUserInstList: r.data!.userInstrumentsList);
//   }));
// }
