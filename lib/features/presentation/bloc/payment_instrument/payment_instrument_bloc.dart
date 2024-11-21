import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/data/models/requests/portfolio_account_details_request.dart';
import 'package:union_bank_mobile/features/domain/usecases/portfolio/accont_details.dart';

import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_justPay_instrument_request.dart';
import '../../../data/models/requests/default_payment_instrument_request.dart';
import '../../../data/models/requests/delete_justpay_instrument_request.dart';
import '../../../data/models/requests/get_user_inst_request.dart';
import '../../../data/models/requests/instrument_nickName_change_request.dart';
import '../../../data/models/requests/instrument_status_change_request.dart';
import '../../../domain/usecases/Manage_Other_Bank/delete_other_bank_instrument.dart';
import '../../../domain/usecases/Manage_Other_Bank/manage_other_bank.dart';
import '../../../domain/usecases/default_payment_instrument/default_payment_instrument.dart';
import '../../../domain/usecases/default_payment_instrument/instrument_nik_name_change.dart';
import '../../../domain/usecases/default_payment_instrument/instrument_status_change.dart';
import '../../../domain/usecases/home/get_user_instrument.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'payment_instrument_event.dart';
import 'payment_instrument_state.dart';

class PaymentInstrumentBloc extends BaseBloc<PaymentInstrumentEvent, BaseState<PaymentInstrumentState>> {
  final GetUserInstruments? getJustpayPaymentInstrument;
  final DefaultPaymentInstrument? defaultPaymentInstrument;
  final InstrumentStatusChange? instrumentStatusChange;
  final InstrumentNickNameChange? instrumentNickNameChange;
  final AddPaymentInstrument? addPaymentInstrument;
  final DeletePaymentInstrument? deletePaymetInstrument;
  final PortfolioAccountDetails? portfolioAccountDetails;

  PaymentInstrumentBloc({
    this.getJustpayPaymentInstrument,
    this.defaultPaymentInstrument,
    this.instrumentNickNameChange,
    this.instrumentStatusChange,
    this.addPaymentInstrument,
    this.deletePaymetInstrument,
    this.portfolioAccountDetails, 


  }) : super(InitialPaymentInstrumentState()) {
    on<GetJustpayInstrumentEvent>(_onGetPaymentInstrumentEvent);
    on<SelectDefaultPaymentInstrumentEvent>(_onSelectDefaultPaymentInstrumentEvent);
    on<InstrumentStatusChangeEvent>(_onInstrumentStatusChangeEvent);
    on<InstrumentNikeNameChangeEvent>(_onInstrumentNikeNameChangeEvent);
    on<AddInstrumentEvent>(_onAddInstrumentEvent);
    on<DeleteInstrumentEvent>(_onDeleteInstrumentEvent);
    on<GetManageAccDetailsEvent>(_onGetAccDetailsEvent);

  }


  Future<void> _onGetPaymentInstrumentEvent(
      GetJustpayInstrumentEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async {
    emit(APILoadingState());

    final response = await getJustpayPaymentInstrument!(
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
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }
      else {
       return GetPaymentInstrumentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==  APIResponse.SUCCESS || r.responseCode =="824"){
        return GetPaymentInstrumentSuccessState(
            getUserInstList: r.data!.userInstrumentsList);

      }else{
        return GetPaymentInstrumentFailedState(
            message: r.errorDescription ??r.responseDescription);
      }

    }));
  }



  Future<void> _onInstrumentNikeNameChangeEvent(
      InstrumentNikeNameChangeEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async {
    emit(APILoadingState());

    final response = await instrumentNickNameChange!(
      InstrumentNickNameChangeRequest(
        messageType: kEditNickName,
        instrumentId: event.instrumentId,
        nickName: event.nickName,
        instrumentType: event.instrumentType
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
        return InstrumentNikNameChangeFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.errorCode == "853"){
        return InstrumentNikNameChangeSuccessState(responseDescription: r.errorDescription , responseCode: r.errorCode);
      }else {
        return InstrumentNikNameChangeSuccessState(baseResponse: r);
      }
    }));
  }

  Future<void> _onAddInstrumentEvent(
      AddInstrumentEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async{
    emit(APILoadingState());
    final response = await addPaymentInstrument!(
        JustPayInstruementsReques(
        messageType: kAddPaymentInstrument,
        nic:event.nic,
        fullName: event.fullName?.trim(),
        bankCode: event.bankCode,
        accountType: event.accountType,
        accountNo: event.accountNo,
        nickName: event.nickName?.trim(),
        enableAlert: event.enableAlert
      )
    );
    response.fold((l) {
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
        return AddPaymentInstrumentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS || r.responseCode =="826"){
        emit(AddPaymentInstrumentSuccessState(baseResponse: r));
      }else if(r.errorCode == "853"){
        emit(AddPaymentInstrumentSuccessState(responseDescription: r.errorDescription , code: r.errorCode));
      }else if(r.errorCode == "843"){
        emit(AddPaymentInstrumentSuccessState(responseDescription: r.errorDescription , code: r.errorCode));
      } else{
       emit(AddPaymentInstrumentFailedState(
            message: r.errorDescription??r.responseDescription));
      }
      
    });
  }

  Future<void> _onDeleteInstrumentEvent(
      DeleteInstrumentEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async{
    emit(APILoadingState());
    final response = await deletePaymetInstrument!(
        DeleteJustPayInstrumentRequest(
          instrumentId: event.instrumentId,
            instrumentType: event.instrumentType,
            messageType: kDeletePaymentInstrument,

        )
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
        return DeleteJustPayInstrumentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode =="838" ||r.responseCode ==APIResponse.SUCCESS){
        return DeleteJustPayInstrumentSuccessState(baseResponse: r);
      } else if(r.responseCode == "961"){
        return DeleteJustPayInstrumentSuccessState(message: r.responseDescription , code: r.responseCode);
      }
      else{
          return DeleteJustPayInstrumentFailedState(
            message:r.errorDescription??r.responseDescription);
      }
      
    }));
  }

  Future<void> _onSelectDefaultPaymentInstrumentEvent(
      SelectDefaultPaymentInstrumentEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async {
    emit(APILoadingState());

    final response = await defaultPaymentInstrument!(
      DefaultPaymentInstrumentRequest(
        messageType: kGetUserInstrumentRequestType,
        instrumentId: event.instrumentId,
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
        return SelectDefaultPaymentInstrumentFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return SelectDefaultPaymentInstrumentSuccessState(baseResponse: r);
    }));
  }

  Future<void> _onInstrumentStatusChangeEvent(InstrumentStatusChangeEvent event,
      Emitter<BaseState<PaymentInstrumentState>> emit) async {
    emit(APILoadingState());

    final response = await instrumentStatusChange!(
      InstrumentStatusChangeRequest(
        messageType: kDefaultPaymentInstrumentRequestType,
        instrumentId: event.instrumentId,
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
        return InstrumentStatusChangeFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return InstrumentStatusChangeSuccessState(baseResponse: r);
    }));
  }

    Future<void> _onGetAccDetailsEvent(
      GetManageAccDetailsEvent event, Emitter<BaseState<PaymentInstrumentState>> emit) async {
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
      }
      else {
        emit(ManageAccountDetailFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l)));
      }
    }, (r) {
      if (r.responseCode == "844" || r.responseCode == APIResponse.SUCCESS) {
        emit(ManageAccountDetailsSuccessState(accDetails: r.data));
      } else {
        emit(ManageAccountDetailFailState(
            errorMessage: r.errorDescription ?? r.responseDescription));
      }
    });
  }

}
