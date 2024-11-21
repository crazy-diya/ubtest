import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_utils.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/cheque_book_filter_request.dart';
import '../../../data/models/requests/cheque_book_request.dart';
import '../../../data/models/requests/credit_card_req_field_data_request.dart';
import '../../../data/models/requests/credit_card_req_save_request.dart';
import '../../../data/models/requests/debit_card_req_field_data_request.dart';
import '../../../data/models/requests/debit_card_save_data_request.dart';
import '../../../data/models/requests/lease_req_field_data_request.dart';
import '../../../data/models/requests/lease_req_save_data_request.dart';
import '../../../data/models/requests/loan_req_field_data_request.dart';
import '../../../data/models/requests/loan_requests_field_data_request.dart';
import '../../../data/models/requests/loan_requests_submit_request.dart';
import '../../../data/models/requests/service_req_history_request.dart';
import '../../../data/models/requests/sr_service_charge_request.dart';
import '../../../data/models/requests/sr_statement_history_request.dart';
import '../../../domain/usecases/service_requests/cheque_book_field.dart';
import '../../../domain/usecases/service_requests/credit_card_req_field_data.dart';
import '../../../domain/usecases/service_requests/credit_card_req_save.dart';
import '../../../domain/usecases/service_requests/debit_card_req_field_data.dart';
import '../../../domain/usecases/service_requests/debit_card_save_field_data.dart';
import '../../../domain/usecases/service_requests/filtered_list_cheque_book.dart';
import '../../../domain/usecases/service_requests/history.dart';
import '../../../domain/usecases/service_requests/lease_req_field_data.dart';
import '../../../domain/usecases/service_requests/lease_req_save_data.dart';
import '../../../domain/usecases/service_requests/loan_req_f.dart';
import '../../../domain/usecases/service_requests/loan_req_field_data.dart';
import '../../../domain/usecases/service_requests/loan_req_save_data.dart';
import '../../../domain/usecases/service_requests/service_req_filtered_list.dart';
import '../../../domain/usecases/service_requests/sr_service_charge.dart';
import '../../../domain/usecases/service_requests/statement_history.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'service_requests_event.dart';
import 'service_requests_state.dart';

class ServiceRequestsBloc
    extends BaseBloc<ServiceRequestsEvent, BaseState<ServiceRequestsState>> {
  final LoanRequestsFieldData? loanRequestsFieldData;
  final LoanRequestsSaveData? loanRequestsSaveData;
  final CreditCardReqFieldData? creditCardReqFieldData;
  final CreditCardReqSave? creditCardReqSave;
  final LeaseReqFieldData? leaseReqFieldData;
  final LeaseReqSaveData? leaseReqSaveData;
  final ServiceReqHistory? serviceReqHistory;
  final LoanReqField? loanReqField;
  final ServiceReqFilteredList? serviceReqFilteredList;
  final DebitCardCardReqFieldData? debitCardCardReqFieldData;
  final DebitCardSaveFieldData? debitCardSaveFieldData;
  final ChequeBookField? checkBookField;
  final FilteredListChequeBook? filteredListChequeBook;
  final LocalDataSource? localDataSource;
  final SrStatementHistory? srStatementHistory;
  final SrServiceCharge? serviceCharge;

  ServiceRequestsBloc(
      {this.loanReqField,
      this.loanRequestsFieldData,
      this.loanRequestsSaveData,
      this.creditCardReqFieldData,
      this.creditCardReqSave,
      this.leaseReqFieldData,
      this.leaseReqSaveData,
      this.serviceReqHistory,
      this.serviceReqFilteredList,
      this.debitCardCardReqFieldData,
      this.debitCardSaveFieldData,
      this.checkBookField,
      this.localDataSource,
      this.srStatementHistory,
      this.serviceCharge,
      this.filteredListChequeBook})
      : super(InitialServiceRequestsState()) {
    on<LoanRequestsFieldDataEvent>(_mapLoanRequestsFieldDataEvent);
    on<LoanRequestsSaveDataEvent>(_mapLoanRequestsSaveDataEvent);
    on<CreditCardRequestsFieldDataEvent>(_mapCreditCardRequestsFieldDataEvent);
    on<CreditCardRequestsSaveEvent>(_mapCreditCardRequestsSaveEvent);
    on<LeaseReqFieldDataEvent>(_mapLeaseReqFieldDataEvent);
    on<LeaseReqSaveDataEvent>(_mapLeaseReqSaveDataEvent);
    on<ServiceReqHistoryEvent>(_mapServiceReqHistoryEvent);
    on<LoanReqFieldEvent>(_mapLoanReqFieldEvent);
    on<ServiceReqHistoryFilteredEvent>(_mapServiceReqHistoryFilteredEvent);
    on<DebitCardRequestsSaveEvent>(_mapDebitCardRequestsSaveEvent);
    on<DebitCardRequestsSaveDataEvent>(_mapDebitCardRequestsSaveDataEvent);
    on<CheckBookRequestEvent>(_mapChequeBookRequestsEvent);
    on<FilterCheckBookEvent>(_mapFilterCheckBookEvent);
    on<FilterStatementEvent>(_mapFilterStatementkEvent);
    on<ServiceChargeEvent>(_mapServiceChargeEvent);
  }

  Future<void> _mapLoanRequestsFieldDataEvent(LoanRequestsFieldDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await loanRequestsFieldData!(
      LoanRequestsFieldDataRequest(
        messageType: kLoanRequestFieldDataRequestType,
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
        return LoanReqFieldDataFailedState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      return LoanReqFieldDataSuccessState(
        loanRequestFieldDataResponse: r.data,
      );
    }));
  }

  Future<void> _mapLoanRequestsSaveDataEvent(LoanRequestsSaveDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    List<ImageListLoan> imageList = [];
    imageList.add(ImageListLoan(
        name: 'NICF',
        image: event.selectedFrontIdImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedFrontIdImage!).readAsBytesSync()))));
    imageList.add(ImageListLoan(
        name: 'NICB',
        image: event.selectedBackIdImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBackIdImage!).readAsBytesSync()))));
    imageList.add(ImageListLoan(
        name: 'BANKF',
        image: event.selectedBankStatementsOneImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBankStatementsOneImage!)
                    .readAsBytesSync()))));
    imageList.add(ImageListLoan(
        name: 'BANKB',
        image: event.selectedBankStatementsTwoImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBankStatementsTwoImage!)
                    .readAsBytesSync()))));
    imageList.add(ImageListLoan(
        name: 'SALARY',
        image: event.selectedSalaryConfirmationImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedSalaryConfirmationImage!)
                    .readAsBytesSync()))));
    final _result = await loanRequestsSaveData!(LoanRequestsSubmitRequest(
      messageType: kLoanReqSaveRequestType,
      title: event.title,
      addressLine1: event.address1,
      addressLine2: event.address2,
      addressLine3: event.address3,
      firstName: event.fName,
      lastName: event.lName,
      loanAmount: event.loanAmount,
      loanTypeTenor: event.id,
      mobileNo: event.mobileNumber,
      monthlyIncome: event.monthlyIncome,
      nic: event.nic,
      gender: event.gender,
      maritalStatus: event.maritalStatus,
      company: event.companyName,
      empType: event.customerType,
      imageList: imageList,
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
      }
      else {
        return LoanReqSavedDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LoanReqSaveDataSuccessState(loanRequestsSubmitResponse: r.data);
    }));
  }

  Future<void> _mapCreditCardRequestsFieldDataEvent(
      CreditCardRequestsFieldDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await creditCardReqFieldData!(
      CreditCardReqFieldDataRequest(
        messageType: kCreditCardReqSaveRequestType,
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
        return CreditCardReqFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return CreditCardReqFieldDataSuccessState(
          creditCardReqFieldDataResponse: r.data);
    }));
  }

  Future<void> _mapCreditCardRequestsSaveEvent(
      CreditCardRequestsSaveEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await creditCardReqSave!(CreditCardReqSaveRequest(
        messageType: kCreditCardRequestSaveRequestType,
        title: event.title,
        firstName: event.fName,
        lastName: event.lName,
        nic: event.nic,
        mobileNo: event.mobileNumber,
        addressLine3: event.address1,
        addressLine2: event.address2,
        addressLine1: event.address1,
        gender: event.genderStatus,
        maritalStatus: event.maritalStatus,
        dob: event.dob,
        embossingName: event.embossingName));
    emit(_result.fold((l) {
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
        return CreditCardReqSaveFailedState(
            message: ErrorHandler().mapFailureToMessage(l),
            code: (l as ServerFailure).errorResponse.errorCode ?? '');
      }
    }, (r) {
      return CreditCardReqSaveSuccessState(message: r.errorDescription);
    }));
  }

  Future<void> _mapLeaseReqFieldDataEvent(LeaseReqFieldDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await leaseReqFieldData!(
      LeaseReqFieldDataRequest(
        messageType: kLeaseRequestFieldRequestType,
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
        return LeaseReqFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeaseReqFieldDataSuccessState(leaseReqFieldDataResponse: r.data);
    }));
  }

  Future<void> _mapLeaseReqSaveDataEvent(LeaseReqSaveDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    List<ImageList> imageList = [];
    imageList.add(ImageList(
        name: 'NICF',
        image: event.selectedFrontIdImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedFrontIdImage!).readAsBytesSync()))));
    imageList.add(ImageList(
        name: 'NICB',
        image: event.selectedBackIdImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBackIdImage!).readAsBytesSync()))));
    imageList.add(ImageList(
        name: 'BANKF',
        image: event.selectedBankStatementsOneImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBankStatementsOneImage!)
                    .readAsBytesSync()))));
    imageList.add(ImageList(
        name: 'BANKB',
        image: event.selectedBankStatementsTwoImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedBankStatementsTwoImage!)
                    .readAsBytesSync()))));
    imageList.add(ImageList(
        name: 'SALARY',
        image: event.selectedSalaryConfirmationImage == null
            ? ""
            : AppUtils.convertBase64(base64Encode(
                File(event.selectedSalaryConfirmationImage!)
                    .readAsBytesSync()))));
    final _result = await leaseReqSaveData!(LeaseReqSaveDataRequest(
        messageType: kLeaseRequestSaveRequestType,
        title: event.title,
        firstName: event.fName,
        lastName: event.lName,
        nic: event.nic,
        addressLine1: event.address1,
        addressLine2: event.address2,
        addressLine3: event.address3,
        mobileNo: event.mobileNumber,
        maritalStatus: event.maritalStatus,
        gender: event.gender,
        employerName: event.employerName,
        employeeDesignation: event.employerDesignation,
        monthlyIncome: event.monthlyIncome,
        vehicleType: event.vehicleType,
        makeAndModel: event.makeAndModel,
        yearOfManufacture: event.yearOfManufacture,
        regNo: event.registrationNo,
        imageList: imageList,
        amount: event.amount,
        leaseTypeTenor: event.leaseTypeTenor,
        empType: event.employerDesignation));
    emit(_result.fold((l) {
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
        return LeaseReqSaveDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LeaseReqSaveDataSuccessState(message: r.errorDescription);
    }));
  }

  Future<void> _mapServiceReqHistoryEvent(ServiceReqHistoryEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await serviceReqHistory!(
      ServiceReqHistoryRequest(
        messageType: kServiceReqHistoryRequestType,
        fromDate: event.fromDate,
        requestType: event.requestType,
        toDate: event.toDate,
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
        return ServiceReqHistoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ServiceReqHistorySuccessState(
        reqList: r.data!.requestList,
        message: r.responseDescription,
      );
    }));
  }

  Future<void> _mapLoanReqFieldEvent(LoanReqFieldEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await loanReqField!(
      LoanReqFieldDataRequest(
        messageType: kLoanRequestFieldDataRequestType,
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
        return LoanReqFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return LoanReqFieldSuccessState(loanReqFieldDataResponse: r.data);
    }));
  }

  Future<void> _mapServiceReqHistoryFilteredEvent(
      ServiceReqHistoryFilteredEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await serviceReqFilteredList!(
      ServiceReqHistoryRequest(
        messageType: kServiceReqHistoryRequestType,
        fromDate: event.fromDate,
        requestType: event.requestType,
        toDate: event.toDate,
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
        return ServiceReqHistoryFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ServiceReqFilteredListSuccessState(
        reqType: r.data!.requestType,
        reqList: r.data!.results![0],
      );
    }));
  }

  Future<void> _mapDebitCardRequestsSaveEvent(DebitCardRequestsSaveEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final result = await debitCardCardReqFieldData!(
      DebitCardReqFieldDataRequest(
        messageType: kDebitCardReqFieldDataRequestType,
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
        return DebitCardReqFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return DebitCardReqFieldDataSuccessState(
          debitCardReqFieldDataResponse: r.data);
    }));
  }

  Future<void> _mapDebitCardRequestsSaveDataEvent(
      DebitCardRequestsSaveDataEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await debitCardSaveFieldData!(DebitCardSaveDataRequest(
        messageType: kDebitCardReqFieldDataSaveRequestType,
        title: event.title,
        firstName: event.fName,
        lastName: event.lName,
        nic: event.nic,
        maritalStatus: event.maritalStatus,
        gender: event.genderStatus,
        addressLine1: event.address1,
        addressLine2: event.address2,
        addressLine3: event.address3,
        branchCode: event.cardCollectionBranch,
        mobileNo: event.mobileNumber,
        mothersMaidenName: event.motherName,
        embossingName: event.embossingName,
        instrumentId: event.insID));
    emit(_result.fold((l) {
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
        return DebitCardReqSaveDataFailedState(
          message: ErrorHandler().mapFailureToMessage(l),
          code: (l as ServerFailure).errorResponse.errorCode ?? '',
        );
      }
    }, (r) {
      return DebitCardReqSaveDataSuccessState(message: r.errorDescription);
    }));
  }

  // new  requests added //

  ///cheque book request ///

  Future<void> _mapChequeBookRequestsEvent(CheckBookRequestEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await checkBookField!(
      ChequeBookRequest(
          // messageType: kUpdateProfileDetails,
          accountNumber: event.accountNumber,
          collectionMethod: event.collectionMethod,
          branch: event.branch,
          address: event.address,
          numberOfLeaves: event.numberOfLeaves,
          serviceCharge: event.serviceCharge),
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
      }
      else {
        return GetAccountFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS) {
        return CheckBookRequestSuccessState(
          message: r.responseDescription,
        );
      } else {
        return GetAccountFailState(
            message: r.errorDescription ?? r.errorDescription);
      }
    }));
  }

  Future<void> _mapFilterCheckBookEvent(FilterCheckBookEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await filteredListChequeBook!(
      ChequeBookFilterRequest(
        // messageType: kUpdateProfileDetails,
        fromDate: event.fromDate,
      toDate: event.toDate,
      accountNo: event.accountNo,
      collectionMethod: event.collectionMethod
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
      }
      else {
        return FilterChequeBookFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS || r.responseCode == "01") {
        return FilterChequeBookSuccessState(
          chequebookFilterList: r.data?.chequeBookList,
            );
      } else {
        return FilterChequeBookFailState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _mapFilterStatementkEvent(FilterStatementEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await srStatementHistory!(
      SrStatementHistoryRequest(
        // messageType: kUpdateProfileDetails,
        fromDate: event.fromDate,
      toDate: event.toDate,
      accountNo: event.accountNo,
      collectionMethod: event.collectionMethod
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
      }
      else {
        return FilterStatementFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS|| r.responseCode == "01") {
        return FilterStatementSuccessState(
          statementFilterList: r.data?.findChequeBookResponseLists,
            );
      } else {
        return FilterStatementFailState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }

  Future<void> _mapServiceChargeEvent(ServiceChargeEvent event,
      Emitter<BaseState<ServiceRequestsState>> emit) async {
    emit(APILoadingState());
    final _result = await serviceCharge!(
        SrServiceChargeRequest(
          messageType: "splashReq"
        )
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
      }
      else {
        return ServiceChargeFailState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == "00" || r.responseCode == APIResponse.SUCCESS) {
        return ServiceChargeSuccessState(
          serviceChargeRequest: r.data?.data,
            );
      } else {
        return FilterStatementFailState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }












}

