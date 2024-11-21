import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/models/requests/bill_payment_excel_dwnload_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/schedule_bill_payment_request.dart';
import 'package:union_bank_mobile/features/domain/usecases/biller_management/scheduling_bill_payment.dart';

import '../../../data/models/requests/bill_payment_request.dart';
import '../../../data/models/requests/biller_pdf_download_request.dart';
import '../../../data/models/requests/delete_biller_request.dart';
import '../../../data/models/requests/edit_user_biller_request.dart';
import '../../../data/models/requests/favourite_biller_request.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/usecases/biller_management/bill_payment.dart';
import '../../../domain/usecases/biller_management/biller_excel_download.dart';
import '../../../domain/usecases/biller_management/biller_pdf_download.dart';
import '../../../domain/usecases/biller_management/delete_biller.dart';
import '../../../domain/usecases/biller_management/edit_biller.dart';
import '../../../domain/usecases/biller_management/favourite_biller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_biller_request.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/usecases/biller_management/add_biller.dart';
import '../../../domain/usecases/biller_management/get_biller_categories.dart';
import '../../../domain/usecases/biller_management/saved_billers.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'biller_management_event.dart';
import 'biller_management_state.dart';

class BillerManagementBloc
    extends BaseBloc<BillerManagementEvent, BaseState<BillerManagementState>> {
  final GetSavedBillers? getSavedBillers;
  final GetBillerCategoryList? getBillerCategoryList;
  final AddBiller? addBiller;
  final FavouriteBiller? favouriteBiller;
  final DeleteBiller? deleteBiller;
  final EditUserBiller? editUserBiller;
//  final UnFavoriteBiller? unFavoriteBiller;
  final BillPayment? billPayment;
  final BillerPdfDownload? billerPdfDownload;
  final BillerExcelDownload? billerExcelDownload;
   final SchedulingBillPayment schedulingBillPayment;

  BillerManagementBloc({
   // this.unFavoriteBiller,
   required this.schedulingBillPayment, 
    this.billPayment,
    this.favouriteBiller,
   this.deleteBiller,
    this.getSavedBillers,
    this.addBiller,
    this.getBillerCategoryList,
    this.editUserBiller,
    this.billerPdfDownload,
    this.billerExcelDownload
  }) : super(InitialBillerManagementState()) {
    on<GetSavedBillersEvent>(_handleGetSavedBillersEvent);
    on<AddBillerEvent>(_handleAddBillerEvent);
   on<GetBillerCategoryListEvent>(_handleGetBillerCategoryListEvent);
    on<FavouriteBillerEvent>(_handleFavouriteBillerEvent);
    on<DeleteBillerEvent>(_handleDeleteBillerEvent);
    on<EditUserBillerEvent>(_handleEditUserBillerEvent);
   // on<UnFavoriteBillerEvent>(_handleUnFavoriteBillerEvent);
    on<BillPaymentEvent>(_handleBillPaymentEvent);
    on<BillerPdfDDownloadEvent>(_handleBillerPdfDownloadEvent);
    on<BillerExcelDownloadEvent>(_handleBillerExcelDownloadEvent);
    on<SchedulingBillPaymentEvent>(_onSchedulingBillPaymentEvent);
  }

  Future<void> _handleGetSavedBillersEvent(GetSavedBillersEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await getSavedBillers!(
      const CommonRequestEntity(
        messageType: kGetSavedBillersRequestType,
      ),
    );

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(GetSavedBillersFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if(r.data!.billerList!.isEmpty){
          emit(GetSavedBillersFailedState(message: ""));
      }
      emit(GetSavedBillersSuccessState(response: r.data));
    });
  }

  Future<void> _handleAddBillerEvent(AddBillerEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await addBiller!(
      AddBillerRequest(
        verified: event.verified,
        isFavourite: event.isFavorite,
          messageType: kAddBillerRequestType,
          nickName: event.nickName,
          //accNumber: event.accNumber,
          serviceProviderId: event.serviceProviderId,
          value: event.billerNo,
          // fieldList: event.customFields!
          //     .map(
          //       (e) => FieldList(
          //           //customFieldValue: e.customFieldValue,
          //         customFieldValue: event.billerNo,
          //           customFieldId: e.customFieldId),
          //     )
          //     .toList(),

        // fieldList:[FieldList(
        //     customFieldValue: "0779873552",
        //     customFieldId: "66"),],
      ),
    );

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(AddBillerFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if(r.responseCode == "dbp-406"){
        emit(AddBillerSuccessState(billerId: r.data!.id , responseCode: r.responseCode));
      } else if (r.errorCode == "843"){
        emit(AddBillerSuccessState(responseDes: r.errorDescription , responseCode: r.errorCode));
      } else if (r.errorCode == "842"){
        emit(AddBillerSuccessState(responseDes: r.errorDescription , responseCode: r.errorCode));
      }

    });
  }

  Future<void> _handleGetBillerCategoryListEvent(
      GetBillerCategoryListEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await getBillerCategoryList!(const CommonRequestEntity(
      messageType: kGetBillerCategoryListRequestType,
    ));

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(GetBillerCategoryListFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      List<BillerCategoryEntity> categoryList = r.data!.data!.map(
            (e) => BillerCategoryEntity(
              logoUrl: e.logoUrl,
                categoryId: e.id,
                categoryCode: e.code,
                categoryName: e.name,
                status: e.status,
                categoryDescription: e.description,
                billers: e.dbpBspMetaCollection!
                    .map(
                      (f) => BillerEntity(
                          billerId: f.id,
                          status: f.status,
                          billerCode: f.id.toString(),
                          billerName: f.name,
                          description: f.description,
                          billerImage: f.imageUrl,
                          collectionAccount: f.collectionAccount,
                          displayName: f.displayName,
                          referencePattern: f.referencePattern,
                          referenceSample: f.referenceSample,
                          chargeCodeEntity:
                              ChargeCodeEntity(chargeCode: '', chargeAmount: f.serviceCharge),
                      ),
                    )
                    .toList()),
          )
          .toList();

      emit(GetBillerCategorySuccessState(billerCategoryList: categoryList));
    });
  }

  Future<void> _handleFavouriteBillerEvent(FavouriteBillerEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await favouriteBiller!(FavouriteBillerRequest(
        id: event.billerId,
        messageType: event.messageType,
      favourite: event.isFavourire,
    ));

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(FavouriteBillerFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      emit(FavouriteBillerSuccessState(message: r.errorDescription));
    });
  }

  Future<void> _handleDeleteBillerEvent(DeleteBillerEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await deleteBiller!
      (
        DeleteBillerRequest(
          messageType: kDeleteUserBillerReqType,
          billerIds: event.deleteAccountList,

        ),
    );

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(DeleteBillerFailedState(
            //message: ErrorMessages().mapFailureToMessage(l)));
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      emit(DeleteBillerSuccessState(message: r.responseDescription , id: r.data!.successFieldIds));
    });
  }

  Future<void> _handleEditUserBillerEvent(EditUserBillerEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await editUserBiller!(
      EditUserBillerRequest(
        isFavourite: event.isFavorite,
          messageType: kEditBillerRequestType,
          nickName: event.nickName,
          value: event.accNum,
          serviceProviderId: event.serviceProviderId,
          billerId: event.billerId,
         // categoryId: event.categoryId,
         //  fieldList: event.fieldList!
         //      .map((e) => FieldList(
         //          //customFieldValue: e.customFieldValue,
         //    customFieldValue: event.accNum,
         //          customFieldId: e.customFieldId))
         //      .toList()
      ),
    );

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(EditUserBillerFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      // emit(EditUserBillerSuccessState(billerId: r.data?.id));
      if(r.responseCode == "dbp-407"){
        emit(EditUserBillerSuccessState(billerId: r.data?.id , responseCode: r.responseCode));
      } else if (r.errorCode == "843"){
        emit(EditUserBillerSuccessState(responseDes: r.errorDescription , responseCode: r.errorCode));
      } else if (r.errorCode == "842"){
        emit(EditUserBillerSuccessState(responseDes: r.errorDescription , responseCode: r.errorCode));
      }
    });
  }
  //
  // Future<void> _handleUnFavoriteBillerEvent(UnFavoriteBillerEvent event,
  //     Emitter<BaseState<BillerManagementState>> emit) async {
  //   emit(APILoadingState());
  //   final _result = await unFavoriteBiller!(UnFavoriteBillerEntity(
  //       billerId: event.billerId, messageType: kUnFavoriteBillerRequestType));
  //
  //   _result.fold((l) {
  //     if (l is AuthorizedFailure) {
  //       emit(SessionExpireState());
  //     } else {
  //       emit(UnFavouriteBillerFailedState(
  //           message: ErrorMessages().mapFailureToMessage(l)));
  //     }
  //   }, (r) {
  //     emit(UnFavouriteBillerSuccessState());
  //   });
  // }

  Future<void> _handleBillPaymentEvent(BillPaymentEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await billPayment!(
      BillPaymentRequest(
          messageType: kBillPaymentReqType,
          instrumentId: event.instrumentId,
          remarks: event.remarks,
          amount: event.amount!.toStringAsFixed(2),
          accountNumber: event.accountNumber,
          billerId: event.billerId,
          //serviceCharge: event.serviceCharge,
          billPaymentCategory: event.billPaymentCategory),
    );

    _result.fold((l) {
       if (l is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??""));
      } else if (l is ServerFailure) {
         return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
       }
       else {
        emit(BillPaymentFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "000") {
        emit(BillPaymentSuccessState(
          billPaymentResponse: r.data,
        ));
      } else {
        emit(BillPaymentFailedState(
            message: r.errorDescription ?? r.responseDescription,
          refId: r.data?.refId ?? null,
        ));
      }
    });
  }

  Future<void> _handleBillerPdfDownloadEvent(
      BillerPdfDDownloadEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final result = await billerPdfDownload!(
      BillerPdfDownloadRequest(
        transactionId: event.transactionId,
        transactionType: event.transactionType,
        messageType: "fundTransferAndBillPaymentPDFDownload",
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
        return BillerPdfDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return BillerPdfDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }



  Future<void> _handleBillerExcelDownloadEvent(
      BillerExcelDownloadEvent event,
      Emitter<BaseState<BillerManagementState>> emit) async {
    emit(APILoadingState());
    final result = await billerExcelDownload!(
      BillPaymentExcelDownloadRequest(
        transactionId: event.transactionId,
        transactionType: event.transactionType,
        messageType: "fundTransferAndBillPaymentPDFDownload",
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
        return BillerExcelDownloadFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return BillerExcelDownloadSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }

    Future<void> _onSchedulingBillPaymentEvent(
      SchedulingBillPaymentEvent event,
      Emitter<BaseState<BillerManagementState>> emit,
      ) async {
    emit(APILoadingState());

    final _result = await schedulingBillPayment(ScheduleBillPaymentRequest(
      messageType: kScheduleFtReqType,
      amount: double.parse(event.amount!).toStringAsFixed(2),
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
      modifiedUser: event.modifiedUser,
     // beneficiaryEmail: event.beneficiaryEmail,
      beneficiaryEmail: event.beneficiaryEmail,
      startDate: event.startDate,
      toAccountNo: event.toAccountNo,
      beneficiaryMobile: event.beneficiaryMobile,
      createdDate: event.createdDate,
      createdUser: event.createdUser,
      endDate: event.endDate,
      failCount: event.failCount,
      frequency: event.frequency,
      modifiedDate: event.modifiedDate,
      tranType: event.tranType,
      remarks: event.remarks,
      billerId: event.billerId,
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
        return SchedulingBillPaymentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if (r.responseCode == APIResponse.SUCCESS || r.responseCode == "000") {
        return SchedulingBillPaymentSuccessState(
          scheduleBillPaymentResponse: r.data,
        );
      } else {
        return SchedulingBillPaymentFailedState(
            message: r.errorDescription ?? r.responseDescription);
      }
    }));
  }
}
