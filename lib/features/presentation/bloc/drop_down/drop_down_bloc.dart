import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/domain/entities/request/recipient_category_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/recipient_type_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_category.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_types.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/getBranchListRequest.dart';
import '../../../data/models/requests/getTxnCategoryList_request.dart';
import '../../../data/models/requests/get_currency_list_request.dart';
import '../../../data/models/requests/get_fd_period_req.dart';
import '../../../data/models/requests/get_user_inst_request.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/usecases/calculators/get_currency_list.dart';
import '../../../domain/usecases/calculators/get_fd_period.dart';
import '../../../domain/usecases/fund_transfer/get_txn_category.dart';
import '../../../domain/usecases/home/get_user_instrument.dart';
import '../../../domain/usecases/payee_management/get_bank_branch_list.dart';
import '../../../domain/usecases/security_questions/get_security_questions.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'drop_down_event.dart';

part 'drop_down_state.dart';

class DropDownBloc extends BaseBloc<DropDownEvent, BaseState<DropDownState>> {
  final GetSecurityQuestions useCaseGetQuestions;
  final GetRecipientTypes? getRecipientTypes;
  final GetRecipientCategory? getRecipientCategory;
  final LocalDataSource localDataSource;
  final GetCurrencyList? getCurrencyList;
  final GetFDPeriod? getFDPeriod;
  final GetUserInstruments? getUserInstruments;
  final GetBankBranchList? getBankBranchList;
  final GetTxnCategoryList? getTxnCategoryList;


  DropDownBloc( 
      {required this.useCaseGetQuestions,
      this.getRecipientTypes,
      this.getRecipientCategory,
      required this.localDataSource,
      this.getCurrencyList,
      this.getFDPeriod,
      this.getUserInstruments,
        this.getBankBranchList,
        this.getTxnCategoryList,
      })
      : super(InitialDropDownState()) {
    on<GetSecurityQuestionDropDownEvent>(_getSecurityQuestionDropDown);
    on<GetTitleDropDownEvent>(_getTitleDropDownEvent);
    on<FilterEvent>(_getFilterEvent);
    on<GetPurposeOfAccountOpeningEvent>(_getPurposeOfAccountOpeningEvent);
    on<GetSourceOfFundsEvent>(_getSourceOfFundsEvent);
    on<GetTransactionModeEvent>(_getTransactionModeEvent);
    on<GetCityEvent>(_getCityEvent);
    on<GetEmployementTypeEvent>(_getEmployementTypeEvent);
    on<GetEmployementFieldEvent>(_getEmployementFieldEvent);
    on<GetDesignationEvent>(_getDesignationEvent);
    on<GetAnnualIncomenEvent>(_getAnnualIncomenEvent);
    on<GetLanguageEvent>(_getLanguageEvent);
    on<GetReligionEvent>(_getReligionEvent);
    on<GetAccountEvent>(_getAccountEvent);
    on<GetAmountRangeEvent>(_getAmountRangeEvent);
    on<GetTransTypeEvent>(_getTransTypeEvent);
    on<GetQuestions1DropDownEvent>(_getQuestions1DropDownEvent);
    on<GetQuestions2DropDownEvent>(_getQuestions2DropDownEvent);
    on<GetLanguageDropDownEvent>(_getLanguageDropDownEvent);
    on<GetAccountTypeDropDownEvent>(_getAccountTypeDropDownEvent);
    on<GetNationalityEvent>(_getNationalityEvent);
    on<GetCustomDropDownEvent>(_getCustomDropDownEvent);
    on<GetMonthEvent>(_getMonthEvent);
    on<GetYearEvent>(_getYearEvent);
    on<GetLeaseYearEvent>(_getLeaseYearEvent);
    on<GetInterestTypeEvent>(_getInterestTypeEvent);
    on<GetPurposeLoanEvent>(_getPurposeLoanEvent);
    on<GetPeriodEvent>(_getPeriodEvent);
    on<GetCurrencyEvent>(_getCurrencyEvent);
    on<GetFDTypeEvent>(_getFDTypeEvent);
    on<GetVehicleOptionEvent>(_getVehicleOptionEvent);

    on<GetVehicleTypeEvent>(_getVehicleTypeEvent);
    on<GetLeasePeriodEvent>(_getLeasePeriodEvent);
    on<GetLMaritalStatusEvent>(_getLMaritalStatusEvent);
    on<GetRecipientCategoryEvent>(_onGetRecipientCategoryDropDownEvent);
    on<GetRecipientTypesEvent>(_onGetRecipientTypeDropDownEvent);
    on<GetAccountsEvent>(_onGetAccountsEvent);
    on<GetBankDropDownEvent>(_getBankDropDownEvent);
    on<GetTxnCategoryDropDownEvent>(_getTxnCategoryDropDownEvent);
    on<GetBankBranchDropDownEvent>(_onGetBankBranchDropDownEvent);
    on<GetFTCatagoryEvent>(_getFTCatagoryEvent);
    on<GetFTFrequencyEvent>(_getFTFrequencyEvent);
    on<GetActiveCurrentAccountsDropDownEvent>(_getActiveCurrentAccountsDropDownEvent);
  }

  Future<void> _getTitleDropDownEvent(GetTitleDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kTitleList));
  }

  Future<void> _getFilterEvent(
      FilterEvent event, Emitter<BaseState<DropDownState>> emit) async {
    final List<CommonDropDownResponse> dropDownData = event.dropDownData;
    if (event.searchText == "") {
      emit(DropDownDataLoadedState(data: dropDownData));
    }
    List<CommonDropDownResponse> filteredList;
    filteredList = dropDownData
        .where((element) => element.description!
            .toLowerCase()
            .startsWith(event.searchText.toLowerCase())).toSet()
        .toList();
    emit(DropDownFilteredState(data: filteredList));
  }

  Future<void> _getQuestions1DropDownEvent(GetQuestions1DropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kQuestionsList1));
  }

  Future<void> _getQuestions2DropDownEvent(GetQuestions2DropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kQuestionsList2));
  }

  Future<void> _getBankDropDownEvent(GetBankDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kBankList));
  }

  Future<void> _getActiveCurrentAccountsDropDownEvent(GetActiveCurrentAccountsDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kActiveCurrentAccountList));
  }

  Future<void> _getTxnCategoryDropDownEvent(GetTxnCategoryDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await getTxnCategoryList!(GetTxnCategoryRequest(
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
          } else if (l is ServerFailure) {
             return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
           }else {
            return DropDownFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return DropDownDataLoadedState(
              data: r.data?.ftTxnCategoryResponseDtos
                  ?.map(
                    (e) => CommonDropDownResponse(
                  description: e.category,
                  code: e.id.toString(),
                ),
              )
                  .toList());
        },
      ),
    );
  }

  Future<void> _onGetBankBranchDropDownEvent(
      GetBankBranchDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
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
            return DropDownFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return DropDownDataLoadedState(
              data: r.data?.branchList
                  ?.map(
                    (e) => CommonDropDownResponse(
                  description: e.branchName,
                      code: e.branchCode,
                ),
              )
                  .toList());
        },
      ),
    );
  }

  Future<void> _getSecurityQuestionDropDown(
      GetSecurityQuestionDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await useCaseGetQuestions( SecurityQuestionRequestEntity(
        messageType: kMessageTypeSecurityQuestionReq,
        nic: event.nic));
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
            return DropDownFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
              if(r.responseCode == APIResponse.SUCCESS || r.responseCode == "dbp-319") {
                return DropDownDataLoadedState(
              data: r.data?.data
                  ?.map(
                    (e) => CommonDropDownResponse(
                  description: e.secQuestion,
                  id: e.id,
                ),
              )
                  .toList());
              }else{
                return DropDownFailedState(
                message: r.errorDescription??r.responseDescription);

              }
        },
      ),
    );
  }

  Future<void> _getAccountTypeDropDownEvent(GetAccountTypeDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kAccountTypeList));
  }

  Future<void> _getLanguageDropDownEvent(GetLanguageDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kLanguageList2));
  }

  Future<void> _getCustomDropDownEvent(GetCustomDropDownEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: event.dataList));
  }

  Future<void> _onGetRecipientCategoryDropDownEvent(GetRecipientCategoryEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final String epicUserId = localDataSource.getEpicUserId() ?? "";
    final result = await getRecipientCategory!(
        RecipientCategoryRequestEntity(epicUserId: epicUserId));

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
        return DropDownFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data?.responseRecipientCategories
              ?.map(
                (e) => CommonDropDownResponse(
                  description: e.categoryName,
                  code: e.categoryCode
                ),
              )
              .toList());
    }));
  }

   Future<void> _onGetRecipientTypeDropDownEvent(GetRecipientTypesEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await getRecipientTypes!(
        RecipientTypeRequestEntity(recipientCode: event.recipientCode));

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
        return DropDownFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data?.responseRecipientTypeList
              ?.map(
                (e) => CommonDropDownResponse(
                  description: e.typeName,
                  code: e.typeCode,
                  key: e.email
                ),
              )
              .toList());
    }));
  }

  Future<void> _getPurposeOfAccountOpeningEvent(
      GetPurposeOfAccountOpeningEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kPurposeOfAccountOpeningList));
  }

  Future<void> _getSourceOfFundsEvent(GetSourceOfFundsEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kSourceOfFundsList));
  }

  Future<void> _getTransactionModeEvent(GetTransactionModeEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kTransactionModeList));
  }

  Future<void> _getCityEvent(
      GetCityEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kCityList));
  }

  Future<void> _getEmployementTypeEvent(GetEmployementTypeEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kEmployementTypeList));
  }

  Future<void> _getEmployementFieldEvent(GetEmployementFieldEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kEmployementFieldList));
  }

  Future<void> _getDesignationEvent(
      GetDesignationEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kDesignationList));
  }

  Future<void> _getAnnualIncomenEvent(GetAnnualIncomenEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kAnnualIncomenList));
  }

  Future<void> _getLanguageEvent(
      GetLanguageEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kLanguageList));
  }

  Future<void> _getReligionEvent(
      GetReligionEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kReligionList));
  }

  Future<void> _getNationalityEvent(
      GetNationalityEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: kNationalityList));
  }

  Future<void> _getMonthEvent(
      GetMonthEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kMonthList));
  }

  Future<void> _getYearEvent(
      GetYearEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kYearList));
  }
  Future<void> _getLeaseYearEvent(
      GetLeaseYearEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kLeaseYearList));
  }

  Future<void> _getInterestTypeEvent(GetInterestTypeEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kInterestTypeList));
  }

  Future<void> _getPurposeLoanEvent(
      GetPurposeLoanEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kPurposeLoanList));
  }

  // Future<void> _getPeriodEvent(
  //     GetPeriodEvent event, Emitter<BaseState<DropDownState>> emit) async {
  //   emit(DropDownDataLoadedState(data: AppConstants.kPeriodList));
  // }

  Future<void> _getPeriodEvent(
      GetPeriodEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await getFDPeriod!(
        GetFdPeriodRequest(messageType: "getFDCalculator"));

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
        return DropDownFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data!.data!
              .map(
                (e) => CommonDropDownResponse(
              code: e.timePeriod,
              description: e.description,
            ),
          )
              .toList());
    }));
  }






  Future<void> _onGetAccountsEvent(
      GetAccountsEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await getUserInstruments!(
        GetUserInstRequest(messageType: "userInstrumentReq",requestType: "ACTIVE"));

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
        return DropDownFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data!.userInstrumentsList
              ?.map(
                (e) => CommonDropDownResponse(
              code: e.accountNo,
              description: e.nickName,
            ),
          )
              .toList());
    }));
  }







  // Future<void> _getCurrencyEvent(
  //     GetCurrencyEvent event, Emitter<BaseState<DropDownState>> emit) async {
  //   emit(DropDownDataLoadedState(data: AppConstants.kCurrencyList));
  // }

  Future<void> _getCurrencyEvent(
      GetCurrencyEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(APILoadingState());
    final result = await getCurrencyList!(
        GetCurrencyListRequest(messageType: "getCurrency"));

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
        return DropDownFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data!.data!
              .map(
                (e) => CommonDropDownResponse(
                  code: e.currencyCode,
                  description: e.currencyDescription,
                ),
              )
              .toList());
    }));
  }

  Future<void> _getFDTypeEvent(
      GetFDTypeEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kFDTypeList));
  }

  Future<void> _getVehicleOptionEvent(GetVehicleOptionEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kVehicleList));
  }

  Future<void> _getVehicleTypeEvent(
      GetVehicleTypeEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kVehicleTypeList));
  }

  Future<void> _getLeasePeriodEvent(
      GetLeasePeriodEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kLeasePeriodList));
  }

  Future<void> _getLMaritalStatusEvent(GetLMaritalStatusEvent event,
      Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kMaritalStatusList));
  }

  Future<void> _getAccountEvent(
      GetAccountEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kAccountList));
  }

  Future<void> _getAmountRangeEvent(
      GetAmountRangeEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kAmountRangeList));
  }

  Future<void> _getTransTypeEvent(
      GetTransTypeEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kGetTransTypeList));
  }
  Future<void> _getFTCatagoryEvent(
      GetFTCatagoryEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kGetFTCatagoryList));
  }
  Future<void> _getFTFrequencyEvent(
      GetFTFrequencyEvent event, Emitter<BaseState<DropDownState>> emit) async {
    emit(DropDownDataLoadedState(data: AppConstants.kGetFTFrequencyList));
  }
}
