import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/models/requests/getBranchListRequest.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/domain/usecases/payee_management/get_bank_branch_list.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_pay_request.dart';
import '../../../data/models/requests/delete_fund_transfer_payee_request.dart';
import '../../../data/models/requests/edit_payee_request.dart';
import '../../../data/models/requests/fund_transfer_payee_list_request.dart';
import '../../../data/models/requests/payee_favorite_request.dart';
import '../../../domain/usecases/default_payment_instrument/default_payment_instrument.dart';
import '../../../domain/usecases/pay_management/add_payee.dart';
import '../../../domain/usecases/pay_management/edit_payee.dart';
import '../../../domain/usecases/payee_management/fund_transfer/delete_fund_transfer_payee.dart';
import '../../../domain/usecases/payee_management/fund_transfer/fund_transfer_payee_list.dart';
import '../../../domain/usecases/payee_management/fund_transfer/payee_favorite.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'payee_management_event.dart';
import 'payee_management_state.dart';

class PayeeManagementBloc extends BaseBloc<PayeeManagementEvent, BaseState<PayeeManagementState>> {
  final FundTransferPayeeList? fundTransferPayeeList;
  final DeleteFundTransferPayee? deleteFundTransferPayee;
  final AddPayee? addPayee;
  final EditPayee? editPayee;
  final DefaultPaymentInstrument? defaultPaymentInstrument;
  final PayeeFavoriteUnFavorite? payeeFavoriteUnFavorite;
  final GetBankBranchList getBankBranchList;

  PayeeManagementBloc( {
    this.fundTransferPayeeList,
    this.defaultPaymentInstrument,
    this.deleteFundTransferPayee,
    this.addPayee,
    this.editPayee,
    this.payeeFavoriteUnFavorite,
    required this.getBankBranchList,
  }) : super(InitialPayeeManagementState()) {
    on<GetSavedPayeesEvent>(_onGetSavedPayeesEvent);
    on<AddPayeeEvent>(_onAddPayeeEvent);
    on<DeleteFundTransferPayeeEvent>(_onDeleteFundTransferPayeeEvent);
    on<EditPayeeEvent>(_onEditPayeeEvent);
    on<FavoriteUnFavoritePayeeEvent>(_onFavoriteUnFavoritePayee);
    on<GetPayeeBankBranchEvent>(_onGetBankBranchEvent);
  }

  Future<void> _onGetSavedPayeesEvent(GetSavedPayeesEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
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
      }
      else {
        emit(GetSavedPayeeFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
       if(r.responseCode==APIResponse.SUCCESS){
      emit(GetSavedPayeesSuccessState(
          savedPayees:r.data!.payeeDataResponseDtoList));
       }else{
        emit(GetSavedPayeeFailedState(
            message: r.errorDescription??r.responseDescription));

       }
    });
  }

  Future<void> _onAddPayeeEvent(AddPayeeEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await addPayee!(
      AddPayRequest(
        // messageType: kAddPayeeRequestType,
        // accountNumber: event.savedPayeeEntitiy!.accountNumber,
        // nickName: event.savedPayeeEntitiy!.nickName,
        // bankCode: event.savedPayeeEntitiy!.bankCode,
        // name: event.savedPayeeEntitiy!.accountHolderName,
        // branchCode: event.savedPayeeEntitiy!.branchCode,
        // favourite: event.savedPayeeEntitiy!.isFavorite,
        verified: event.verified,
        messageType: kAddPayeeRequestType,
        accountNumber: event.accountnumber,
        nickName: event.nikname?.trim(),
        bankCode: event.bankcode,
        branchId: event.branchCode,
        favourite: event.addfavorite,
        name: event.holdername?.trim(),
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
        emit(AddPayeeFailedState(
            message: ErrorHandler().mapFailureToMessage(l),
            code: (l as ServerFailure).errorResponse.errorCode??''));
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS){
         emit(AddPayeeSuccessState(payeeId: r.data!.id));
      } else if(r.errorCode == "844"){
        emit(AddPayeeSuccessState(message: r.errorDescription , responseCode: r.errorCode));
      }else if(r.errorCode == "508"){
        emit(AddPayeeSuccessState(message: r.errorDescription , responseCode: r.errorCode));
      }else if(r.errorCode == "511"){
        emit(AddPayeeSuccessState(message: r.errorDescription , responseCode: r.errorCode));
      }
      else{
          emit(AddPayeeFailedState(
            message:r.errorDescription??r.responseDescription,
            code: r.errorCode??r.responseCode));
      } 
    });
  }

  Future<void> _onDeleteFundTransferPayeeEvent(
      DeleteFundTransferPayeeEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await deleteFundTransferPayee!(
        DeleteFundTransferPayeeRequest(
            messageType: kFundTransferPayeeManagement,
            accountNumberList: event.deleteAccountList));

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
        emit(DeletePayeeFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
      emit(DeletePayeeSuccessState(message: r.responseDescription , deletePayees: r.data?.payeeDataResponseDtoList));
      }else{
        emit(DeletePayeeFailedState(
            message: r.errorDescription??r.responseDescription));
      }
    });
  }

  Future<void> _onEditPayeeEvent(EditPayeeEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await editPayee!(EditPayeeRequest(
        id: event.payeeId,
        messageType: kEditPayeeRequestType,
        accountNumber: event.accountnumber,
        nickName: event.nikname?.trim(),
        bankCode: event.bankcode,
        branchId: event.branchCode,
        name: event.holdername?.trim(),
        favourite: event.addfavorite));

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
        emit(EditPayeeFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
       if(r.responseCode==APIResponse.SUCCESS){
      emit(EditPayeeSuccessState(message: r.responseDescription));
       } else if(r.errorCode == "508"){ //nickname
         emit(EditPayeeSuccessState(message: r.errorDescription , errorCode: r.errorCode));
       } else if(r.errorCode == "844"){
         emit(EditPayeeSuccessState(message: r.errorDescription , errorCode: r.errorCode));
       }
       else {
        emit(EditPayeeFailedState(
            message: r.errorDescription ?? r.responseDescription,
            code: r.errorCode ?? r.responseCode));
      }
    });
  }

  Future<void> _onFavoriteUnFavoritePayee(FavoriteUnFavoritePayeeEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
    emit(APILoadingState());
    final _result = await payeeFavoriteUnFavorite!(PayeeFavoriteRequest(
      messageType: kPayeeReq,
      favourite: event.favorite,
      id: event.id,
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
        emit(FavoritePayeeFailedState(
            message: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
      emit(FavoritePayeeSuccessState(message: r.responseDescription));
      }else{
         emit(FavoritePayeeFailedState(
            message: r.errorDescription??r.responseDescription));
      }
    });
  }


   Future<void> _onGetBankBranchEvent(
      GetPayeeBankBranchEvent event,
      Emitter<BaseState<PayeeManagementState>> emit) async {
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
            return GetPayeeBranchFaildState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
          return GetPayeeBranchSuccessState(
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



}
