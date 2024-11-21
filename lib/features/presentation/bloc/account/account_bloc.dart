import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/domain/usecases/portfolio/accont_details.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../utils/app_constants.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/QRPaymentPdfDownloadRequest.dart';
import '../../../data/models/requests/account_inquiry_request.dart';
import '../../../data/models/requests/balance_inquiry_request.dart';
import '../../../data/models/requests/biometric_login_request.dart';
import '../../../data/models/requests/fund_transfer_payee_list_request.dart';
import '../../../data/models/requests/getBranchListRequest.dart';
import '../../../data/models/requests/getTxnCategoryList_request.dart';
import '../../../data/models/requests/get_account_name_ft_request.dart';
import '../../../data/models/requests/get_user_inst_request.dart';
import '../../../data/models/requests/portfolio_account_details_request.dart';
import '../../../data/models/requests/qr_payment_request.dart';
import '../../../data/models/requests/settings_tran_limit_request.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/usecases/biometric/biometric_login.dart';
import '../../../domain/usecases/fund_transfer/get_account_name_for_ft.dart';
import '../../../domain/usecases/fund_transfer/get_txn_category.dart';
import '../../../domain/usecases/home/account_inquiry.dart';
import '../../../domain/usecases/home/balance_inquiry.dart';
import '../../../domain/usecases/home/get_user_instrument.dart';

import '../../../domain/usecases/payee_management/fund_transfer/fund_transfer_payee_list.dart';
import '../../../domain/usecases/payee_management/get_bank_branch_list.dart';
import '../../../domain/usecases/qr_payment/qr_payment.dart';
import '../../../domain/usecases/qr_payment/qr_payment_pdf_download.dart';
import '../../../domain/usecases/settings/transaction_limit.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends BaseBloc<AccountEvent, BaseState<AccountState>> {
  final AccountInquiry? accountInquiry;
  final BalanceInquiry? balanceInquiry;
  final GetUserInstruments? getUserInstruments;
  final GetTranLimits? getTranLimits;
  final LocalDataSource? localDataSource;
  final PortfolioAccountDetails? portfolioAccountDetails;
  final BiometricLogin? biometricLogin;
  final QRPayment? qrPayment;
  final GetAcctNameForFT? getAcctNameForFT;
  final QRPaymentPdfDownload? qrPaymentPdfDownload;
  final GetTxnCategoryList getTxnCategoryList;
  final FundTransferPayeeList? fundTransferPayeeList;
  final GetBankBranchList? getBankBranchList;

  AccountBloc({
    this.balanceInquiry,
    this.accountInquiry,
    this.getUserInstruments,
    this.getTranLimits,
    this.localDataSource,
    this.portfolioAccountDetails,
    this.biometricLogin,
    this.qrPayment,
    this.getAcctNameForFT,
    this.qrPaymentPdfDownload,
    required this.fundTransferPayeeList,
    required this.getTxnCategoryList,
    required this.getBankBranchList,
  }) : super(InitialAccountState()) {
    on<GetAccountInquiryEvent>(_handleGetAccountInquiryEvent);
    on<GetBalanceInquiryEvent>(_handleGetBalanceInquiryEvent);
    on<GetUserInstrumentEvent>(_handleGetUserInstrumentEvent);
    on<GetTranLimitForFTEvent>(_getTranLimitForFTEvent);
    on<GetPortfolioAccDetailsEvent>(_onGetPortfolioAccDetailsEvent);
    on<BiometricFor2FALoginEvent>(_onBiometric2FAEvent);
    on<RequestBiometricPrompt2FAEvent>(_onRequestBiometricPrompt2FAEvent);
    on<QRPaymentEvent>(_onQRPaymentEvent);
    on<GetAccountNameFTEvent>(_onGetAccountNameForFTEvent);
    on<QRPaymentPdfDownloadEvent>(_onQRPaymentPdfDownloadEvent);
    on<GetTxnCategoryFTEvent>(_onGetTxnCategoryFTEvent);
    on<GetSavedPayeesForFTEvent>(_onGetSavedPayeesForFTEvent);
    on<GetBankBranchEvent>(_onGetBankBranchEvent);
  }


  ///QR payment pdf download
  Future<void> _onQRPaymentPdfDownloadEvent(
      QRPaymentPdfDownloadEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final result = await qrPaymentPdfDownload!(
      QrPaymentPdfDownloadRequest(
        messageType: kQRPayment,
        serviceCharge: event.serviceCharge,
        referenceNo: event.referenceNo,
        remarks: event.remarks,
         date: event.date,
        status: event.status,
        txnAmount: event.txnAmount,
        transactionId: event.transactionId
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
      } else {
        return QrPaymentPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return QrPaymentPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _handleGetAccountInquiryEvent(GetAccountInquiryEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());

    final response = await accountInquiry!(
      AccountInquiryRequest(
          messageType: kAccountInquiryRequestType, cif: event.cif),
    );
    emit(response.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return AccountInquiryFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountInquirySuccessState(data: r.data!.accounts);
    }));
  }

  Future<void> _handleGetBalanceInquiryEvent(GetBalanceInquiryEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());

    final response = await balanceInquiry!(
      BalanceInquiryRequest(
        messageType: kAccountInquiryRequestType,
        accountNumber: event.accountNumber,
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
        return BalanceInquiryFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return BalanceInquirySuccessState(
        balance: double.parse(r.data!.accountBalance!),
        accountNumber: r.data!.accountNumber,
      );
    }));
  }

  Future<void> _handleGetUserInstrumentEvent(GetUserInstrumentEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());

    final response = await getUserInstruments!(
      GetUserInstRequest(
        messageType: kGetUserInstrumentRequestType,
        requestType: event.requestType,
      ),
    );
    emit(response.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return GetUserInstrumentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==  APIResponse.SUCCESS || r.responseCode =="824"){
         return GetUserInstrumentSuccessState(
          getUserInstList: r.data!.userInstrumentsList);

      }else{
         return GetUserInstrumentFailedState(
            message: r.errorDescription ??r.responseDescription);
      }
     
    }));
  }

///tran limits
  Future<void> _getTranLimitForFTEvent(
      GetTranLimitForFTEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final _result = await getTranLimits!(
        SettingsTranLimitRequest(
            messageType: kGetTxnDetailsReq,
            channelType: "MB"
        )
    );
    emit(_result.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return GetTransLimitForFTFailedState(
            message: ErrorHandler().mapFailureToMessage(l)
        );
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
      localDataSource?.setTxnLimits(r.data!.txnLimit!);
      return GetTransLimitForFTSuccessState(
          tranLimitDetails: r.data!.txnLimit,
          code: r.responseCode,
          message: r.responseDescription
      );
      }else{
        return GetTransLimitForFTFailedState(
            message: r.errorDescription??r.responseDescription
        );
      }
    }));
  }
  ///portfolio accounts
  Future<void> _onGetPortfolioAccDetailsEvent(
      GetPortfolioAccDetailsEvent event, Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final response = await portfolioAccountDetails!(
      PortfolioAccDetailsRequest(
        messageType: kaccountInqReqType,
      ),
    );
   emit( response.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
       return AccountDetailFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==  APIResponse.SUCCESS){
         return PortfolioAccountDetailsSuccessState(accDetails: r.data);

      }else{
        return AccountDetailFailState(
            errorMessage: r.errorDescription??r.responseDescription);
      }
     
    }));
  }

///2FA limits
  Future<void> _onBiometric2FAEvent(
      BiometricFor2FALoginEvent event, Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    await biometricLogin!(
      BiometricLoginRequest(
          messageType: kBiometricLoginRequestType,
          uniqueCode: AppConstants.BIOMETRIC_CODE),
    );
  }

///QR Payment
  Future<void> _onQRPaymentEvent(QRPaymentEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());

    final response = await qrPayment!(
      QrPaymentRequest(
        customerUtilityCommision: null,
        deviceType: 1,
        dynamicQRdata: ["UBGO"],
        instrumentId: event.instrumentId,
        lankaQRcode: event.lankaQRcode,
        mcc: event.mcc ?? "",
        messageType: kQRPayment,
        midNo: "145789521",
        paymentMode: "MERCHANT_QR",
        serviceCharge: 30,
        serviceChargeCalculated: false,
        tidNo: event.tidNo ?? "0000",
        txnAmount:  double.parse(event.txnAmount!).toStringAsFixed(2),
        referenceNo: event.referenceNo,
        remarks: event.remarks,
        merchantAccountName: event.merchantName,
        merchantAccountNo: event.merchantAccountNumber,
      ),
    );
    emit(response.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return QRPaymentFailState();
      }
    }, (r) {
      if (r.responseCode == "0000" || r.responseCode ==APIResponse.SUCCESS) {
        return QRPaymentSuccessState(qrPaymentResponse: r.data);
      } else {
        return QRPaymentFailState
        (errorMessage: r.errorDescription??r.responseDescription,
        errorCode: r.errorCode??r.responseCode,qrPaymentResponse:  r.data);
      }
    }));
  }

  Future<void> _onRequestBiometricPrompt2FAEvent(RequestBiometricPrompt2FAEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(BiometricPromptFor2FASuccessState());
  }

  ///get account name
  Future<void> _onGetAccountNameForFTEvent(
      GetAccountNameFTEvent event, Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final response = await getAcctNameForFT!(
      GetAcctNameFtRequest(
        messageType: kFundTranRequestType,
        accountNo: event.accountNo
      ),
    );
    emit(response.fold((l) {
       if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }  else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }else {
        return FtGetNameFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS||r.responseCode=="836"){
        return FtGetNameSuccessState(acctName: r.data!.accountName);

      }else {
        return  FtGetNameFailState(
          errorCode: r.errorCode??r.errorDescription,
          errorMessage: r.errorDescription??r.responseDescription);
      }
      
    }));
  }


  Future<void> _onGetTxnCategoryFTEvent(GetTxnCategoryFTEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final result = await getTxnCategoryList(
        GetTxnCategoryRequest(
      messageType: kGetTxnDetailsReq,
      channelType: "MB",
    ));
    emit(
      result.fold(
            (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is SessionExpire) {
            return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }  else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
            return GetTxnCategoryFTFailState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return GetTxnCategoryFTSuccessState(
              data: r.data?.ftTxnCategoryResponseDtos
                  ?.map((e) => CommonDropDownResponse(
                  description: e.category,
                  code: e.id.toString(),
                ),
              ).toList());
        },
      ),
    );
  }


  Future<void> _onGetSavedPayeesForFTEvent(GetSavedPayeesForFTEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final response = await fundTransferPayeeList!(
      FundTransferPayeeListRequest(
        //messageType: "kFundTransferPayeeManagement",
        messageType: "payeeReq",
      ),
    );
    response.fold((l) {
      if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        emit(GetSavedPayeeForFTFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
        emit(GetSavedPayeesForFTSuccessState(
            savedPayees:r.data!.payeeDataResponseDtoList));
      }else{
        emit(GetSavedPayeeForFTFailedState(
            message: r.errorDescription??r.responseDescription));

      }
    });
  }


  Future<void> _onGetBankBranchEvent(
      GetBankBranchEvent event,
      Emitter<BaseState<AccountState>> emit) async {
    emit(APILoadingState());
    final result = await getBankBranchList!(GetBankBranchListRequest(
      messageType: kMessageTypeGetBankBranches,
      bankCode: event.bankCode,
    ));
    emit(
      result.fold(
            (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is SessionExpire) {
            return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
            return GetbranchFailState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return GetbranchSuccessState(
              data: r.data?.branchList
                  ?.map((e) => CommonDropDownResponse(
                  description: e.branchName,
                  code: e.branchCode,
                ),
              ).toList());
        },
      ),
    );
  }


}
