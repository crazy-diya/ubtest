import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:union_bank_mobile/features/data/models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_credit_limit_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_detals_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_e_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_last_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_list_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_lost_stolen_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_pin_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_txn_history_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_view_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_activation_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_credit_limit_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_details_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_e_statement_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_last_statement_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_lost_stolen_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_pin_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/card_view_statement_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_activation.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_credit_limit.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_details.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_e_statement.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_last_statement.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_list.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_lost_stolen.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_pin.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_txn_history.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_view_statement.dart';

import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/card_management/card_txn_history_request.dart';
import '../../../data/models/requests/card_taransaction_pdf.dart';
import '../../../data/models/requests/card_tran_excel_download.dart';
import '../../../data/models/requests/getBranchListRequest.dart';
import '../../../data/models/requests/get_user_inst_request.dart';
import '../../../data/models/requests/portfolio_account_details_request.dart';
import '../../../data/models/requests/settings_tran_limit_request.dart';
import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../../data/models/responses/card_management/loyalty_points/loyalty_redeem_response.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../data/models/responses/get_user_inst_response.dart';
import '../../../data/models/responses/settings_tran_limit_response.dart';
import '../../../domain/usecases/biometric/biometric_login.dart';
import '../../../domain/usecases/card_management/loyalty_points/card_loyalty.dart';
import '../../../domain/usecases/card_management/loyalty_points/loyalty_redeem.dart';
import '../../../domain/usecases/excel_download/card_transaction_excel.dart';
import '../../../domain/usecases/home/get_user_instrument.dart';
import '../../../domain/usecases/payee_management/get_bank_branch_list.dart';
import '../../../domain/usecases/pdf_download/card_transaction_pdf.dart';
import '../../../domain/usecases/portfolio/accont_details.dart';
import '../../../domain/usecases/settings/transaction_limit.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'credit_card_management_event.dart';

part 'credit_card_management_state.dart';

class CreditCardManagementBloc extends BaseBloc<CreditCardManagementEvent,
    BaseState<CreditCardManagementState>> {
  final PortfolioAccountDetails? portfolioAccountDetails;
  final CardList cardList;
  final CardActivation cardActivation;
  final CardCreditLimit cardCreditLimit;
  final CardDetails cardDetails;
  final CardEStatement cardEStatement;
  final CardLastStatement cardLastStatement;
  final CardLostStolen cardLostStolen;
  final CardPin cardPin;
  final CardTxnHistory cardTxnHistory;
  final GetBankBranchList getBankBranchList;
  final CardViewStatement cardViewStatement;
  final CardLoyaltyVouchers cardLoyaltyVouchers;
  final CardDLoyaltyRedeem cardDLoyaltyRedeem;
  final GetTranLimits? getTranLimits;
  final LocalDataSource? localDataSource;
  final BiometricLogin biometricLogin;
  final GetUserInstruments getUserInstruments;
  final CardTransactionPdfDownload cardtransactionPdfDownload;
  final CardTransactionExcelDownload cardTransactionExcelDownload;

  CreditCardManagementBloc(
      {required this.cardActivation,
      required this.cardCreditLimit,
      required this.cardDLoyaltyRedeem,
      required this.cardDetails,
      required this.cardEStatement,
      required this.cardLastStatement,
      required this.cardLostStolen,
      required this.cardPin,
      required this.cardTxnHistory,
      required this.cardViewStatement,
      required this.cardList,
      required this.getBankBranchList,
      required this.cardLoyaltyVouchers,
      required this.getTranLimits,
      required this.localDataSource,
      required this.biometricLogin,
      required this.getUserInstruments,
      required this.cardtransactionPdfDownload,
      required this.cardTransactionExcelDownload,
      required this.portfolioAccountDetails})
      : super(CreditCardManagementInitial()) {
    on<GetPortfolioAccDetailsCreditCardEvent>(_onGetPortfolioAccDetailsEvent);

    on<GetCardListEvent>(_onGetCardListEvent);
    on<GetCardDetailsEvent>(_onGetCardDetailsEvent);
    on<GetCardActivationEvent>(_onGetCardActivationEvent);
    on<GetCardCreditLimitEvent>(_onGetCardCreditLimitEvent);
    on<GetCardEStatementEvent>(_onGetCardEStatementEvent);
    on<GetCardLastStatementEvent>(_onGetCardLastStatementEvent);
    on<GetCardLostStolenEvent>(_onGetCardLostStolenEvent);
    on<GetCardPinEvent>(_onGetCardPinEvent);
    on<GetCardTxnHistoryEvent>(_onGetCardTxnHistoryEvent);
    on<GetCardViewStatementEvent>(_onGetCardViewStatementEvent);
    on<GetPayeeBankBranchEventForCard>(_onGetBankBranchEventForCard);
    on<GetCardLoyaltyVouchersEvent>(_onGetCardLoyaltyVouchersEvent);
    on<GetCardLoyaltyRedeemEvent>(_onGetCardLoyaltyRedeemEvent);
    on<GetTranLimitForCardEvent>(_getTranLimitForCardEvent);
    on<RequestBiometricPrompt2FACardEvent>(_onRequestBiometricPrompt2FACardEvent);
    on<GetUserInstrumentForCardEvent>(_handleGetUserInstrumentForCardEvent);
    on<CCTransactionPdfDownloadEvent>(_onCCTransactionPdfDownloadEvent);
    on<CCTransactionExcelDownloadEvent>(_onCCTransactionExcelDownloadEvent);
  }

  Future<void> _onGetPortfolioAccDetailsEvent(
      GetPortfolioAccDetailsCreditCardEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final response = await portfolioAccountDetails!(
      PortfolioAccDetailsRequest(
        messageType: kaccountInqReqType,
      ),
    );
    emit(response.fold((l) {
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
        return PortfolioAccountDetailsCreditCardFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS) {
        return PortfolioAccountDetailsCreditCardSuccessState(
            accDetails: r.data);
      } else {
        return PortfolioAccountDetailsCreditCardFailState(
            errorMessage: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _onGetCardListEvent(GetCardListEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
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
        return GetCardListFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardListLoadedState(cardListResponse: r.data , resCode: r.responseCode);
      } else {
        return GetCardListLoadedState(resCode: r.responseCode , resDescription: r.responseDescription);
      }
    }));
  }

  Future<void> _onGetCardDetailsEvent(GetCardDetailsEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardDetails(CardDetailsRequestEntity(
      messageType: kcardDetailsReq,
      maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
    ));

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
        return GetCardDetailsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardDetailsSuccessState(cardDetailsResponse: r.data , resCode: r.responseCode);
      } else {
      return GetCardDetailsSuccessState(resDescription: r.responseDescription , resCode: r.responseCode);
      }
    }));
  }

  Future<void> _onGetCardActivationEvent(GetCardActivationEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardActivation(CardActivationRequestEntity(
      messageType: kcardActReq,
      maskedCardNumber: event.maskedCardNumber,
    ));

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
        return GetCardActivationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetCardActivationSuccessState(message: r.responseDescription);
    }));
  }

  Future<void> _onGetCardCreditLimitEvent(GetCardCreditLimitEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardCreditLimit(CardCreditLimitRequestEntity(
      messageType: kcardAddOnLimitReq,
      maskedAddonCardNumber: event.maskedAddonCardNumber,
      addonCashLimitPerc: event.addonCashLimitPerc,
      addonCrLimitPerc: event.addonCrLimitPerc,
    ));

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
        return GetCardCreditLimitFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardCreditLimitSuccessState(cardCreditLimitResponse: r.data , resCode: r.responseCode);
      } else{
        return GetCardCreditLimitSuccessState(resDescription: r.responseDescription , resCode: r.responseCode);
      }
    }));
  }

  Future<void> _onGetCardEStatementEvent(GetCardEStatementEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardEStatement(CardEStatementRequestEntity(
      messageType: kcardStModeReq,
      maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
      isGreenStatement: event.isGreenStatement,
    ));

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
        return GetCardEStatementFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        try {
        } on Exception catch (e, s) {
          print(s);
        }
        return GetCardEStatementSuccessState(cardEStatementResponse: r.data , resCode: r.responseCode);
      } else {
        return GetCardEStatementSuccessState(resDescription: r.responseDescription , resCode: r.responseCode);
      }
    }));
  }

  Future<void> _onGetCardLastStatementEvent(GetCardLastStatementEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardLastStatement(CardLastStatementRequestEntity(
      messageType: kcardLastStatementReq,
      maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
    ));

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
        return GetCardLastStatementFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetCardLastStatementSuccessState(
          cardLastStatementResponse: r.data);
    }));
  }

  Future<void> _onGetCardLostStolenEvent(GetCardLostStolenEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardLostStolen(CardLostStolenRequestEntity(
      messageType: kcardLostOrStolenReq,
      maskedCardNumber: event.maskedCardNumber,
      reissueRequest: event.reissueRequest,
      isBranch: event.isBranch,
      branchCode: event.branchCode
    ));

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
        return GetCardLostStolenFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardLostStolenSuccessState(cardLostStolenResponse: r.data , resCode: r.responseCode);
      } else {
        return GetCardLostStolenSuccessState(resDescription: r.responseDescription , resCode: r.responseCode);
      }
    }));
  }

  Future<void> _onGetCardPinEvent(GetCardPinEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardPin(CardPinRequestEntity(
      messageType: kcardPinGenReq,
      maskedCardNumber: event.maskedCardNumber,
      pinChangeReason: event.pinChangeReason,
    ));

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
        return GetCardPinFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardPinSuccessState(cardPinResponse: r.data , resCode: r.responseCode);
      } else {
        return GetCardPinSuccessState(resCode: r.responseCode , resDescription: r.responseDescription);
      }

    }));
  }

  Future<void> _onGetCardTxnHistoryEvent(GetCardTxnHistoryEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardTxnHistory(
        CardTxnHistoryRequest(
      messageType: kcardTxnHistoryReq,
      maskedCardNumber: event.maskedCardNumber,
      txnMonthsFrom: event.txnMonthsFrom,
      txnMonthsTo: event.txnMonthsTo,
            page: event.page,
            size: event.size,
            fromAmount: event.fromAmount,
            toAmount: event.toAmount,
            status: event.status,
            billingStatus: event.billingStatus
    ));

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
        return GetCardTxnHistoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == "00"){
        return GetCardTxnHistorySuccessState(cardTxnHistoryResponse: r.data);
      } else {
        return GetCardTxnHistoryFailedState(
            message: r.responseDescription);
      }

    }));
  }

  Future<void> _onGetCardViewStatementEvent(GetCardViewStatementEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardViewStatement(CardViewStatementRequestEntity(
      messageType: kcardViewStatementReq,
      maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
      billMonth: event.billMonth,
    ));

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
        return GetCardViewStatementFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetCardViewStatementSuccessState(
          cardViewStatementResponse: r.data);
    }));
  }

  Future<void> _onGetBankBranchEventForCard(
      GetPayeeBankBranchEventForCard event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await getBankBranchList(GetBankBranchListRequest(
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
          }
          else {
            return GetPayeeBranchFaildStateForCard(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return GetPayeeBranchSuccessStateForCard(
              data: r.data?.branchList
                  ?.map((e) => CommonDropDownResponse(
                description: e.branchName,
                key: e.branchCode,
              ),
              ).toList());
        },
      ),
    );
  }


  FutureOr<void> _onGetCardLoyaltyVouchersEvent(GetCardLoyaltyVouchersEvent event, Emitter<BaseState<CreditCardManagementState>> emit)async {
    emit(APILoadingState());
    final result =
    await cardLoyaltyVouchers(const CommonRequestEntity(messageType: kcardLostOrStolenReq));

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
        return GetCardListFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetCardLoyaltyVouchersLoadedState(cardLoyaltyVouchersResponse: r.data);
    }));
  }

  FutureOr<void> _onGetCardLoyaltyRedeemEvent(GetCardLoyaltyRedeemEvent event, Emitter<BaseState<CreditCardManagementState>> emit) async{
    emit(APILoadingState());
    final result =
        await cardDLoyaltyRedeem(CardLoyaltyRedeemRequest(
          messageType: kcardLoyaltyRedeemnReq,
          maskedPrimaryCardNumber: event.maskedPrimaryCardNumber,
          redeemPoints: event.redeemPoints,
          sendToAddressFlag: event.sendToAddressFlag,
          collectBranch: event.collectBranch,
          redeemOptions: event.redeemOptions,
        ));

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
        return GetCardLoyaltyRedeemFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
     if( r.responseCode == "00"){
       return GetCardLoyaltyRedeemSuccessState(cardLoyaltyRedeemResponse: r.data);
     }else{
       return GetCardLoyaltyRedeemFailedState(
           message: "Card Loyalty Redeem Failed");
     }

    }));
  }


  ///tran limits
  Future<void> _getTranLimitForCardEvent(
      GetTranLimitForCardEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
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
        return GetTransLimitForCardFailedState(
            message: ErrorHandler().mapFailureToMessage(l)
        );
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
        localDataSource?.setTxnLimits(r.data!.txnLimit!);
        return GetTransLimitForCardSuccessState(
            tranLimitDetails: r.data!.txnLimit,
            code: r.responseCode,
            message: r.responseDescription
        );
      }else{
        return GetTransLimitForCardFailedState(
            message: r.errorDescription??r.responseDescription
        );
      }
    }));
  }


  Future<void> _onRequestBiometricPrompt2FACardEvent(RequestBiometricPrompt2FACardEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(BiometricPromptFor2FACardSuccessState());
  }


  Future<void> _handleGetUserInstrumentForCardEvent(GetUserInstrumentForCardEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());

    final response = await getUserInstruments(
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
        return GetUserInstrumentForCardFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==  APIResponse.SUCCESS || r.responseCode =="824"){
        return GetUserInstrumentForCardSuccessState(
            getUserInstList: r.data!.userInstrumentsList);

      }else{
        return GetUserInstrumentForCardFailedState(
            message: r.errorDescription ??r.responseDescription);
      }

    }));
  }


  ///download card history pdf report
  Future<void> _onCCTransactionPdfDownloadEvent(
      CCTransactionPdfDownloadEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardtransactionPdfDownload(
      CardTransactionPdfRequest(
          messageType: kcardTransactionHistory,
        maskedCardNumber: event.maskedCardNumber,
        txnMonthsFrom: event.txnMonthsFrom,
        txnMonthsTo: event.txnMonthsTo,
        fromAmount: event.fromAmount,
        toAmount: event.toAmount,
        status: event.status,
        billingStatus: event.billingStatus
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
        return CCTransactionPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CCTransactionPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }


  ///download card history excel report
  Future<void> _onCCTransactionExcelDownloadEvent(
      CCTransactionExcelDownloadEvent event,
      Emitter<BaseState<CreditCardManagementState>> emit) async {
    emit(APILoadingState());
    final result = await cardTransactionExcelDownload(
      CardTransactionExcelRequest(
          messageType: kcardTransactionHistoryXLSheet,
          maskedCardNumber: event.maskedCardNumber!,
          txnMonthsFrom: event.txnMonthsFrom,
          txnMonthsTo: event.txnMonthsTo,
          fromAmount: event.fromAmount,
          toAmount: event.toAmount,
          status: event.status,
          billingStatus: event.billingStatus
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
        return CCTransactionExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CCTransactionExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

}
