import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/common/justpay_payload.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_user_inst_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_challenge_id_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_terms_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/get_terms_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/just_pay_tc_sign_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/mail_count_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/terms_accept_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/home/get_mail_count.dart';
import 'package:union_bank_mobile/features/domain/usecases/home/get_user_instrument.dart';
import 'package:union_bank_mobile/features/domain/usecases/justpay/just_pay_challenge_id.dart';
import 'package:union_bank_mobile/features/domain/usecases/justpay/just_pay_tc_sign.dart';
import 'package:union_bank_mobile/features/domain/usecases/portfolio/lease_details.dart';
import 'package:union_bank_mobile/features/domain/usecases/terms/accept_terms_data.dart';
import 'package:union_bank_mobile/features/domain/usecases/terms/get_terms_data.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';

import '../../../data/models/requests/acc_tran_status_excel.dart';
import '../../../data/models/requests/acc_tran_status_pdf.dart';
import '../../../data/models/requests/account_statement_pdf_download.dart';
import '../../../data/models/requests/account_statements_excel_request.dart';
import '../../../data/models/requests/account_statements_request.dart';
import '../../../data/models/requests/account_tarnsaction_history_pdf_download_request.dart';

import '../../../data/models/requests/account_tran_excel_request.dart';
import '../../../data/models/requests/account_transaction_history_request.dart';
import '../../../data/models/requests/card_management/card_statement_pdf_download_request.dart';
import '../../../data/models/requests/card_taransaction_pdf.dart';
import '../../../data/models/requests/card_tran_excel_download.dart';
import '../../../data/models/requests/edit_nick_name_request.dart';
import '../../../data/models/requests/lease_history_excel.dart';
import '../../../data/models/requests/lease_history_pdf.dart';
import '../../../data/models/requests/lease_payment_history_request.dart';
import '../../../data/models/requests/loan_history_excel_request.dart';
import '../../../data/models/requests/loan_history_pdf_download.dart';
import '../../../data/models/requests/loan_history_request.dart';
import '../../../data/models/requests/notification_count_request.dart';
import '../../../data/models/requests/past_card_excel_download.dart';
import '../../../data/models/requests/past_card_statement_request.dart';
import '../../../data/models/requests/past_card_statements_pdf_download_request.dart';
import '../../../data/models/requests/portfolio_account_details_request.dart';
import '../../../data/models/requests/portfolio_cc_details_request.dart';
import '../../../data/models/requests/portfolio_loan_details_request.dart';
import '../../../data/models/requests/portfolio_user_fd_details_request.dart';
import '../../../data/models/requests/promotions_request.dart';
import '../../../data/models/requests/retrieve_profile_image_request.dart';
import '../../../data/models/requests/transcation_details_request.dart';

import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/usecases/Manage_Other_Bank/get_justpay_instrument_list.dart';
import '../../../domain/usecases/card_management/card_list.dart';
import '../../../domain/usecases/edit_profile/get_profile_image.dart';
import '../../../domain/usecases/excel_download/acc_tran_status_excel.dart';

import '../../../domain/usecases/excel_download/account_statement_excel_download.dart';
import '../../../domain/usecases/excel_download/account_transaction_excel.dart';
import '../../../domain/usecases/excel_download/card_transaction_excel.dart';
import '../../../domain/usecases/excel_download/lease_history_excel_download.dart';
import '../../../domain/usecases/excel_download/loan_history_excelDownload.dart';
import '../../../domain/usecases/excel_download/past_card_excel_download.dart';
import '../../../domain/usecases/notifications/notification_count.dart';
import '../../../domain/usecases/pdf_download/acc_transaction_pdf_download.dart';
import '../../../domain/usecases/pdf_download/acc_transaction_status_pdf.dart';
import '../../../domain/usecases/pdf_download/account_statements_pdf_download.dart';
import '../../../domain/usecases/pdf_download/card_transaction_pdf.dart';
import '../../../domain/usecases/pdf_download/lease_history_pdf.dart';
import '../../../domain/usecases/pdf_download/loan_history_pdf_download.dart';
import '../../../domain/usecases/pdf_download/past_card_statements_pdf_download.dart';
import '../../../domain/usecases/portfolio/accont_details.dart';
import '../../../domain/usecases/portfolio/account_statements.dart';
import '../../../domain/usecases/portfolio/account_transactions.dart';
import '../../../domain/usecases/portfolio/card_statement_pdf_download.dart';
import '../../../domain/usecases/portfolio/cc_details.dart';
import '../../../domain/usecases/portfolio/edit_nick_name.dart';
import '../../../domain/usecases/portfolio/fd_details.dart';
import '../../../domain/usecases/portfolio/lease_payment_history.dart';
import '../../../domain/usecases/portfolio/loan_details.dart';
import '../../../domain/usecases/portfolio/loan_history.dart';
import '../../../domain/usecases/portfolio/past_card_statements.dart';
import '../../../domain/usecases/promotion/get_promotions.dart';
import '../../../domain/usecases/transaction_details/transaction_details.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc
    extends BaseBloc<PortfolioEvent, BaseState<PortfolioState>> {
  final PortfolioAccountDetails? portfolioAccountDetails;
  final PortfolioCCDetails? portfolioCCDetails;
  final PortfolioLoanDetails? portfolioLoanDetails;
  final PortfolioFDDetails? portfolioFDDetails;
  final TransactionDetails? transactionDetails;
  final PortfolioLeaseDetails? portfolioLeaseDetails;
  final GetPromotions? getPromotions;
  final EditNickName? editNickName;
  final PastCardStatesments? pastCardStatements;
  final LoanHistory? loanHistory;
  final LeaseHistory? leaseHistory;
  final AccountStatements? accountStatements;
  final AccountTransactions? accountTransactions;

  final AccountStatementsPdfDownload? accountStatementsPdfDownload;
  final AccountTransactionExcelDownload? accountTransactionExcelDownload;
  final CardTransactionExcelDownload? cardTransactionExcelDownload;
  final CardTransactionPdfDownload? cardtransactionPdfDownload;
  final AccountTranStatusExcelDownload? accountTranStatusExcelDownload;
  final AccountTransactionsPdfDownload? accountTransactionsPdfDownload;

  final AccountSatementsXcelDownload? accountSatementsXcelDownload;
  final LoanHistoryExcelDownloadDownload? loanHistoryExcelDownloadDownload;
  final LoanHistoryPdfDownload? loanHistoryPdfDownload;
  final LeaseHistoryPdfDownload? leaseHistoryPdfDownload;
  final LeaseHistoryExcelDownload? leaseHistoryExcelDownload;
  final PastCardStatemntsPdfDownload? pastCardStatemntsPdfDownload;
  final AccountTransactionStatusPdfDownload?
      accountTransactionStatusPdfDownload;
  final PastCardExcelDownload? pastCardExcelDownload;
  final GetProfileImage? getProfileImage;
  final GetMailCount? getMailCount;
  final CountNotification countNotification;
  final GetJustpayPaymentInstrument getJustpayPaymentInstrument;

  final GetTermsData? useCaseGetTerms;
  final AcceptTermsData? useCaseAcceptTerms;

  final GetUserInstruments? getUserInstruments;

  final LocalDataSource? appSharedData;
  final JustPayChallengeId? justPayChallengeId;
  final JustPayTCSign? justPayTCSign;
  final CardList cardList;
  final CardStatementPDFDownload cardStatementPDFDownload;

  PortfolioBloc(
      {this.portfolioAccountDetails,
      this.portfolioCCDetails,
      this.portfolioLoanDetails,
      this.portfolioFDDetails,
      this.transactionDetails,
      this.portfolioLeaseDetails,
      this.getPromotions,
      this.editNickName,
      this.pastCardStatements,
      this.loanHistory,
      this.leaseHistory,
      this.accountStatements,
      this.accountTransactions,
      this.accountStatementsPdfDownload,
      this.pastCardStatemntsPdfDownload,
      this.loanHistoryPdfDownload,
      this.accountSatementsXcelDownload,
      this.accountTransactionsPdfDownload,
      this.cardtransactionPdfDownload,
      this.cardTransactionExcelDownload,
      this.accountTransactionExcelDownload,
      this.loanHistoryExcelDownloadDownload,
      this.accountTransactionStatusPdfDownload,
      this.pastCardExcelDownload,
      this.leaseHistoryPdfDownload,
      this.leaseHistoryExcelDownload,
      this.accountTranStatusExcelDownload,
      this.getProfileImage,
      this.getMailCount,
      this.useCaseGetTerms,
      this.useCaseAcceptTerms,
      this.getUserInstruments,
      this.appSharedData,
      this.justPayChallengeId,
      this.justPayTCSign,
      required this.getJustpayPaymentInstrument,
      required this.cardList,
      required this.cardStatementPDFDownload,
      required this.countNotification})
      : super(InitialPortfolioState()) {
    on<GetAccDetailsEvent>(_onGetAccDetailsEvent);
    on<GetCCDetailsEvent>(_onGetCCDetailsEvent);
    on<GetLoanDetailsEvent>(_onGetLoanDetailsEvent);
    on<GetFDDetailsEvent>(_onGetFDDetailsEvent);
    on<GetHomeTransactionDetailsEvent>(_onGetHomeTransactionDetailsEvent);
    on<GetLeaseDetailsEvent>(_onGetLeaseDetailsEvent);
    on<GetHomePromotionsEvent>(_onGetHomePromotionsEvent);
    on<EditNicknameEvent>(_onEditNicknameEvent);
    on<PastCardStatementEvent>(_onPastCardStatementEventt);
    on<LoanHistoryEvent>(_onLoanHistoryEvent);
    on<LeaseHistoryEvent>(_onLeaseHistoryEvent);
    on<AccountStatementsEvent>(_onAccountStatementsEvent);
    on<AccountTransactionsEvent>(_onAccountTransactionsEvent);
    on<AccountStatementsPdfDownloadEvent>(_onAccountStatementsPdfDownloadEvent);
    on<AccountTransactionStatusExcelDownloadEvent>(
        _onAccountTransactionStatusExcelDownloadEvent);
    on<AccountSatementsXcelDownloadEvent>(_onAccountSatementsXcelDownloadEvent);
    on<CardTransactionPdfDownloadEvent>(_onCardTransactionPdfDownloadEvent);
    on<CardTransactionExcelDownloadEvent>(_onCardTransactionExcelDownloadEvent);
    on<LoanHistoryPdfDownloadEvent>(_onLoanHistoryPdfDownloadEvent);
    on<LeaseHistoryPdfDownloadEvent>(_onLeaseHistoryPdfDownloadEvent);
    on<LeaseHistoryExcelDownloadEvent>(_onLeaseHistoryExcelDownloadEvent);
    on<LoanHistoryExcelDownloadEvent>(_onLoanHistoryExcelDownloadEvent);
    on<AccountTransactionExcelDownloadEvent>(
        _onAccountTransactionExcelDownloadEvent);
    on<PastCardStatementsPdfDownloadEvent>(
        _onPastCardStatementsPdfDownloadEvent);
    on<AccountTransactionPdfDownloadEvent>(
        _onAccountTransactionPdfDownloadEvent);
    on<PastCardExcelDownloadEvent>(_onPastCardExcelDownloadEvent);
    on<AccountTransactionStatusPdfDownloadEvent>(
        _onAccountTransactionStatusPdfDownloadEvent);
    on<GetProfileImageEvent>(_onGetProfileImageEvent);
    on<GetMailCountEvent>(_onGetMailCountEvent);
    on<CountNotificationsForHomeEvent>(_countNotificationForHomeEvent);
    on<GetJustpayInstrumentPortfolioEvent>(
        _onGetPaymentInstrumentPortfolioEvent);

    on<GetHomeTermsEvent>(_onHomeGetTermsEvent);
    on<HomeAcceptTermsEvent>(_onHomeAcceptTermsEvent);
    on<GetCreditCardEvent>(_onGetCreditCardEvent);

    //Just Pay
    on<JustPayHomeChallengeIdEvent>(_onJustPayChallengeIdEvent);
    on<JustPayHomeTCSignEvent>(_onJustPayTCSignEvent);
    on<JustPayHomeSDKCreateIdentityEvent>(_onJustPaySDKCreateIdentity);
    on<JustPayHomeSDKTCSignEvent>(_onJustPaySDKTCSignEvent);
    on<CardSTPdfDownloadEvent>(_onCardSTPdfDownloadEvent);
  }

  Future<void> _onEditNicknameEvent(
      EditNicknameEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await editNickName!(
      EditNickNamerequest(
          messageType: event.messageType,
          nickName: event.nickName,
          instrumentId: event.instrumentId,
          instrumentType: event.instrumentType),
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
        return EditNickNameFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "836" || r.responseCode == APIResponse.SUCCESS) {
        return EditNickNameSuccessState(message: r.responseDescription);
      } else {
        return EditNickNameFailState(
            errorMessage: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onGetAccDetailsEvent(
      GetAccDetailsEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await portfolioAccountDetails!(
      PortfolioAccDetailsRequest(
        messageType: kaccountInqReqType,
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
        emit(AccountDetailFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if (r.responseCode == "844" || r.responseCode == APIResponse.SUCCESS) {
        emit(AccountDetailsSuccessState(accDetails: r.data));
      } else {
        emit(AccountDetailFailState(
            errorMessage: r.errorDescription ?? r.responseDescription));
      }
    });
  }

  ///TODO:have to change card

  Future<void> _onGetCCDetailsEvent(
      GetCCDetailsEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await portfolioCCDetails!(
      PortfolioCcDetailsRequest(
        messageType: kAccDetailsRequestType,
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
        emit(CCDetailsFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      emit(CCDetailsSuccessState(portfolioCcDetailsResponse: r.data));
    });
  }


  ///changed card details
  Future<void> _onGetCreditCardEvent(GetCreditCardEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result =
    await cardList(const CommonRequestEntity(messageType: kcardSummaryReq));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is SessionExpire) {
        return SessionExpireState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is ServerFailure) {
        return ServerFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else {
        return GetCreditCardListFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCreditCardSuccessState(cardListResponse: r.data , resCode: r.responseCode);
      } else {
        return GetCreditCardSuccessState(resCode: r.responseCode , resDescription: r.responseDescription);
      }
    }));
  }

  Future<void> _onGetLoanDetailsEvent(GetLoanDetailsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await portfolioLoanDetails!(
      PortfolioLoanDetailsRequest(
        messageType: kAccDetailsRequestType,
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
        emit(CCDetailsFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if (r.responseCode == "845" || r.responseCode == APIResponse.SUCCESS) {
        emit(LoanDetailsSuccessState(portfolioLoanDetailsResponse: r.data));
      } else {
        emit(CCDetailsFailState(
            errorMessage: r.errorDescription ?? r.responseDescription));
      }
    });
  }

  Future<void> _onGetFDDetailsEvent(
      GetFDDetailsEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await portfolioFDDetails!(
      PortfolioUserFdDetailsRequest(
        messageType: kPortfolioRequest,
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
        emit(CCDetailsFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      emit(FDDetailsSuccessState(portfolioUserFdDetailsResponse: r.data));
    });
  }

  Future<void> _onGetHomeTransactionDetailsEvent(
      GetHomeTransactionDetailsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
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
      }else {
        return HomeTransactionDetailsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return HomeTransactionDetailsSuccessState(
        txnDetailList: r.data!.txnDetailList,
        count: r.data!.count,
        message: r.responseDescription,
      );
    }));
  }

  Future<void> _onGetLeaseDetailsEvent(GetLeaseDetailsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await portfolioLeaseDetails!(
      PortfolioLoanDetailsRequest(
        messageType: kPortfolioRequest,
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
        emit(CCDetailsFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      emit(LeaseDetailsSuccessState(portfolioLeaseDetailsResponse: r.data));
    });
  }

  Future<void> _onGetHomePromotionsEvent(GetHomePromotionsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await getPromotions!(PromotionsRequest(
        messageType: kGetPromotionsRequestType, isHome: "true"));

    if (_result.isRight()) {
      emit(_result.fold(
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
                return HomePromotionsFailedState(
                  message: ErrorHandler().mapFailureToMessage(l));
            }
            },
        (r) => HomePromotionsSuccessState(promotions: r.data!.promotionList),
      ));
    } else {
      emit(HomePromotionsFailedState(
      ));
    }
  }

  Future<void> _onPastCardStatementEventt(PastCardStatementEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await pastCardStatements!(PastCardStatementsrequest(
      maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
        billMonth: event.billMonth,
        messageType: "cardTxnHistoryReq"));

    if (_result.isRight()) {
      emit(_result.fold(
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
          return PastCardStatementsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
            }},
        (r) =>
            r.responseCode == "00" ?
            PastCardStatementsSuccessState(
                statements: r.data?.primaryTxnDetails)
                :
            PastCardStatementsFailedState(
              message: r.responseDescription,
              errorCode: r.responseCode
            ),
      ));
    } else {
      emit(PastCardStatementsFailedState(
      ));
    }
  }


  Future<void> _onLoanHistoryEvent(
      LoanHistoryEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await loanHistory!(LoanHistoryrequest(
        accountNo: event.accountNo,
        messageType: event.messageType,
        page: event.page,
        size: event.size));

    if (_result.isRight()) {
      emit(_result.fold(
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
          return LoanHistoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));}},
        (r) => LoanHistorySuccessState(
            history: r.data!.loanHistoryResponseDtos, count: r.data?.count),
      ));
    } else {
      emit(LoanHistoryFailedState(
      ));
    }
  }

  Future<void> _onLeaseHistoryEvent(
      LeaseHistoryEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await leaseHistory!(LeaseHistoryrequest(
        accountNo: event.accountNo,
        messageType: event.messageType,
        page: event.page,
        size: event.size));

    // if (_result.isRight()) {
    emit(_result.fold(
        (l)  {
          if (l is AuthorizedFailure) {
              return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is SessionExpire) {
              return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ConnectionFailure) {
              return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
          return LeaseHistoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));}}, (r) {
      if (r.responseCode == APIResponse.SUCCESS) {
        return LeaseHistorySuccessState(
            leaseHistory: r.data!.leaseHistoryResponseDtos,
            count: r.data?.count);
      } else {
        return LeaseHistoryFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onAccountStatementsEvent(AccountStatementsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await accountStatements!(AccountStatementsrequest(
        accountType: event.accountType,
        accountNo: event.accountNo,
        messageType: event.messageType,
        page: event.page,
        size: event.size,
        fromDate: event.fromDate,
        toDate: event.toDate,
        status: event.status,
        fromAmount: event.fromAmount,
        toAmount: event.toAmount));

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
        return AccountStatementsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "851" ||
          r.responseCode == APIResponse.SUCCESS ||
          r.responseCode == "01") {
        return AccountStatementsSuccessState(
            firstTxnDate: r.data?.firstTxnDate,
            lastTxnDate: r.data!.lastTxnDate,
            accStatements: r.data!.statementResponseDtos,
            count: r.data!.count,
            totalCreditAmount: r.data!.totalCreditAmount?.toDouble(),
            totalDebitAmount: r.data!.totalDebitAmount?.toDouble());
      } else if (r.responseCode == "01" || r.errorCode == "01") {
        return AccountStatementsFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
      return AccountStatementsFailedState(
          message: r.errorDescription ?? r.responseDescription);
    }));
  }

  Future<void> _onAccountTransactionsEvent(AccountTransactionsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountTransactions!(AccountTransactionHistorysrequest(
      accountType: event.accountType,
      accountNo: event.accountNo,
      messageType: "portfolioRequest",
      page: event.page,
      size: event.size,
    ));

    // if (result.isRight()) {
    emit(result.fold(
        (l){
          if (l is AuthorizedFailure) {
              return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is SessionExpire) {
              return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ConnectionFailure) {
              return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
          return AccountTransactionsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));}}, (r) {
      if (r.responseCode == "852" ||
          r.responseCode == APIResponse.SUCCESS ||
          r.responseCode == "cbs-01" ||
          r.responseCode == "01") {
        return AccountTransactionsSuccessState(
            accountTransactions: r.data!.recentTransactionList,
            count: r.data!.count,
            totalCreditAmount: r.data!.totalCrAmount,
            totalDebitAmount: r.data!.totalDrAmount);
      } else {
        return AccountTransactionsFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onAccountStatementsPdfDownloadEvent(
      AccountStatementsPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountStatementsPdfDownload!(
      AccountStatementPdfDownloadRequest(
        messageType: kaccountStatementHistoryDownload,
        page: event.page,
        size: event.size,
        accountNo: event.accountNo,
        accountType: event.accountType,
        fromDate: event.fromDate,
        toDate: event.toDate,
        fromAmount: event.fromAmount,
        toAmount: event.toAmount,
        status: event.status,
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
        return AccountStatementsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "000") {
        return AccountStatementsPdfDownloadSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen,
        );
      } else {
        return AccountStatementsPdfDownloadFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onLoanHistoryExcelDownloadEvent(
      LoanHistoryExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await loanHistoryExcelDownloadDownload!(
      LoanHistoryExcelRequest(
          messageType: kloanPaymentHistoryXLSheetDownload,
          loanNo: event.loanNumber!),
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
        return LoanHistoryExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LoanHistoryExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onLeaseHistoryPdfDownloadEvent(
      LeaseHistoryPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await leaseHistoryPdfDownload!(
      LeaseHistoryPdfRequest(
          messageType: kleasePaymentHistoryDownload,
          leaseNo: event.leaseNumber!),
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
        return LeaseHistoryPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeaseHistoryPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onLeaseHistoryExcelDownloadEvent(
      LeaseHistoryExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await leaseHistoryExcelDownload!(
      LeaseHistoryExcelRequest(
          messageType: kLeasePaymentHistoryXLSheetDownload,
          leaseNo: event.leaseNumber!),
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
        return LeaseHistoryPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeaseHistoryPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onAccountTransactionExcelDownloadEvent(
      AccountTransactionExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountTransactionExcelDownload!(
      AccountTransactionExcelRequest(
        messageType: kTransactionHistoryXLSheetDownload,
        accountNo: event.accountNumber!,
        accountType: event.accountType!,
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
        return AccountTransactionExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountTransactionExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onCardTransactionExcelDownloadEvent(
      CardTransactionExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await cardTransactionExcelDownload!(
      CardTransactionExcelRequest(
          messageType: kcardTransactionHistoryXLSheet,
          maskedCardNumber: event.cardNumber!),
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
        return CardTransactionExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CardTransactionExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onCardTransactionPdfDownloadEvent(
      CardTransactionPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await cardtransactionPdfDownload!(
      CardTransactionPdfRequest(
          messageType: kcardTransactionHistory, maskedCardNumber: event.cardNumber!),
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
        return CardTransactionPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CardTransactionPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onAccountTransactionStatusExcelDownloadEvent(
      AccountTransactionStatusExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountTranStatusExcelDownload!(
      AccTranStatusExcelDownloadRequest(
          messageType: kTransactionStatusXLSheetDownload,
          paidFromAccountName: event.paidFromAccountName,
          paidToAccountNo: event.paidFromAccountNo,
          paidFromAccountNo: event.paidToAccountNo,
          paidToAccountName: event.paidFromAccountNo,
          amount: event.amount,
          serviceCharge: event.serviceCharge,
          transactionCategory: event.transactionCategory,
          remarks: event.remarks,
          beneficiaryEmail: event.beneficiaryEmail,
          beneficiaryMobileNo: event.beneficiaryMobileNo,
          dateAndTime: event.dateAndTime,
          referenceId: event.referenceId),
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
        return AccountTransactionStatusExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountTransactionStatusExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onAccountTransactionPdfDownloadEvent(
      AccountTransactionPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountTransactionsPdfDownload!(
      AccountTransactionsPdfDownloadRequest(
        messageType: kTxnDetailsReq,
        accountNo: event.accountNumber,
        accountType: event.accountType,
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
        return AccountTransactionPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "000" || r.responseCode == APIResponse.SUCCESS) {
        return AccountTransactionPdfDownloadSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen,
        );
      } else {
        return AccountTransactionPdfDownloadFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onAccountSatementsXcelDownloadEvent(
      AccountSatementsXcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountSatementsXcelDownload!(
      AccountSatementsXcelDownloadRequest(
        messageType: kAccountStatementXLSheetHistoryDownload,
        accountNo: event.accountNo,
        accountType: event.accountType,
        fromDate: event.fromDate,
        toDate: event.toDate,
        fromAmount: event.fromAmount,
        toAmount: event.toAmount,
        status: event.status,
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
        return AccountSatementsXcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountSatementsXcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onLoanHistoryPdfDownloadEvent(LoanHistoryPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await loanHistoryPdfDownload!(
      LoanHistoryPdfRequest(
        messageType: kLoanPaymentHistoryDownload,
        accountNo: event.accountNumber,
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
        return AccountStatementsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountStatementsPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onPastCardExcelDownloadEvent(PastCardExcelDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await pastCardExcelDownload!(
      PastCardExcelDownloadRequest(
          messageType: kPastCardStatementXLSheetDownload,
          maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
          billMonth: event.billMonth),
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
        return AccountStatementsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return AccountStatementsPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onPastCardStatementsPdfDownloadEvent(
      PastCardStatementsPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await pastCardStatemntsPdfDownload!(
      PastcardStatementstPdfDownloadRequest(
        messageType: kPastCardStatementHistoryDownload,
        year: event.year,
        month: event.month,
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
        return PastCardStatementsPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return PastCardStatementsPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

  Future<void> _onAccountTransactionStatusPdfDownloadEvent(
      AccountTransactionStatusPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await accountTransactionStatusPdfDownload!(
      AccTranStatusPdfDownloadRequest(
          messageType: kTransactionStatus,
          paidFromAccountName: event.paidFromAccountName,
          paidToAccountNo: event.paidToAccountNo,
          paidFromAccountNo: event.paidFromAccountNo,
          paidToAccountName: event.paidToAccountName,
          amount: event.amount,
          serviceCharge: event.serviceCharge,
          transactionCategory: event.transactionCategory,
          remarks: event.remarks,
          beneficiaryEmail: event.beneficiaryEmail,
          beneficiaryMobileNo: event.beneficiaryMobileNo,
          dateAndTime: event.dateAndTime,
          referenceId: event.referenceId),
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
        return AccountTransactionStatusPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "000") {
        return AccountTransactionStatusPdfDownloadSuccessState(
          document: r.data!.document,
          shouldOpen: event.shouldOpen,
        );
      } else {
        return AccountTransactionStatusPdfDownloadFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  // GetProfileImage
  Future<void> _onGetProfileImageEvent(GetProfileImageEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    final _result = await getProfileImage!(
      RetrieveProfileImageRequest(
        imageKey: event.imageKey,
        imageType: AppConstants.IMAGE_TYPE,
        messageType: kGetProfilePic,
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
        return GetProfileImageFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetProfileImageSuccessState(
        retrieveProfileImageResponse: r.data,
      );
    }));
  }

  Future<void> _onGetMailCountEvent(
      GetMailCountEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    final result = await getMailCount!(
      MailCountRequestEntity(page: 0, size: 0),
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
        return GetMailCountFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      AppConstants.unreadMailCount.add(r.data?.totalUnread ?? 0);
      return GetMailCountSuccessState(
        mailCountResponse: r.data,
      );
    }));
  }

  Future<void> _countNotificationForHomeEvent(
      CountNotificationsForHomeEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final _result = await countNotification(NotificationCountRequest(
        readStatus: event.readStatus,
        notificationType: event.notificationType));

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
        return CountNotificationForHomeFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CountNotificationForHomeSuccessState(
          allNotificationCount: r.data!.allNotificationCount,
          tranNotificationCount: r.data!.tranNotificationCount,
          noticesNotificationCount: r.data!.noticesNotificationCount,
          promoNotificationCount: r.data!.promoNotificationCount);
    }));
  }

/* --------------------------- Get Home Instrument -------------------------- */

  Future<void> _onGetPaymentInstrumentPortfolioEvent(
      GetJustpayInstrumentPortfolioEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final response = await getUserInstruments!(
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
      }else {
        return GetPaymentInstrumentPortfolioFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "824") {
        return GetPaymentInstrumentPortfolioSuccessState(
            getUserInstList: r.data!.userInstrumentsList);
      } else {
        return GetPaymentInstrumentPortfolioFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

/* ---------------------- JustPay Term & Condition Bloc --------------------- */

  Future<void> _onHomeGetTermsEvent(
      GetHomeTermsEvent event, Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await useCaseGetTerms!(
      GetTermsRequestEntity(
        messageType: kMessageTypeTermsAndConditionsGetReq,
        termType: ObType.justPay.name,
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
        return JustpayTermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      final TermsData? termsData = r.data!.data;
      return JustpayTermsLoadedState(termsData: termsData);
    }));
  }

  Future<void> _onHomeAcceptTermsEvent(HomeAcceptTermsEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());

    final result = await useCaseAcceptTerms!(
      TermsAcceptRequestEntity(
        termId: event.termId,
        acceptedDate: event.acceptedDate,
        messageType: kMessageTypeTermsAndConditionsAcceptReq,
        termType: event.termType
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
        return JustpayTermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return JustpayTermsSubmittedState();
    }));
  }

/* --------------------------------- JustPay -------------------------------- */

  Future<void> _onJustPayChallengeIdEvent(JustPayHomeChallengeIdEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await justPayChallengeId!(JustPayChallengeIdRequest(
        messageType: kAccountOnboardReq,
        fromBankCode: AppConstants.ubBankCode.toString(),
        challengeReqDeviceId: event.challengeReqDeviceId,
        isOnboarded: event.isOnboarded));
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
        return JustPayHomeChallengeIdFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "823") {
        return JustPayHomeChallengeIdSuccessState(
          justPayChallengeIdResponse: r.data,
        );
      } else {
        return JustPayHomeChallengeIdFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onJustPayTCSignEvent(JustPayHomeTCSignEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final challengeId = await appSharedData?.getChallengeId();
    final result = await justPayTCSign!(
      JustpayTCSignRequestEntity(
        messageType: kAccountOnboardReq,
        challengeId: AppConstants.challangeID != "" ? AppConstants.challangeID : challengeId,
        termAndCondition: event.termAndCondition,
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
        return JustPayHomeTCSignFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS) {
        return JustPayHomeTCSignSuccessState(
          justPayTCSignResponse: r,
        );
      } else {
        return JustPayHomeTCSignFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  /* ------------------------------ Just Pay Sdk ------------------------------ */

  Future<void> _onJustPaySDKCreateIdentity(
      JustPayHomeSDKCreateIdentityEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final JustPayPayload justPayPayload =
        await PlatformServices.justPayCreateIdentity(event.challengeId!);

    if (justPayPayload.isSuccess == true) {
      appSharedData?.setChallengeId(event.challengeId!);
      AppConstants.challangeID = event.challengeId!;
      emit(JustPayHomeSDKCreateIdentitySuccessState(
          justPayPayload: justPayPayload));
    } else {
      emit(JustPayHomeSDKCreateIdentityFailedState(
          message: justPayPayload.code.toString()));
    }
  }

  Future<void> _onJustPaySDKTCSignEvent(JustPayHomeSDKTCSignEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final JustPayPayload justPayPayload =
        await PlatformServices.justPaySignedTerms(event.termAndCondition!);

    if (justPayPayload.isSuccess == true) {
      emit(JustPayHomeSDKTCSignSuccessState(justPayPayload: justPayPayload));
    } else {
      emit(JustPayHomeSDKTCSignFailedState(
          message: justPayPayload.code.toString()));
    }
  }


  ///Past Card statement pdf download
  Future<void> _onCardSTPdfDownloadEvent(
      CardSTPdfDownloadEvent event,
      Emitter<BaseState<PortfolioState>> emit) async {
    emit(APILoadingState());
    final result = await cardStatementPDFDownload(
      CardStateentPdfDownloadRequest(
        messageType: kPastCardStatementHistoryDownload,
        maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
        billMonth: event.billMonth,
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
        return CardSTPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CardSTPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }




}
