import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_just_pay_instruements_request.dart';
import '../../../data/models/requests/otp_request.dart';
import '../../../domain/entities/request/challenge_request_entity.dart';
import '../../../domain/usecases/justpay/add_just_pay_instrument.dart';
import '../../../domain/usecases/otp/request_otp.dart';
import '../../../domain/usecases/otp/verify_otp.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OTPBloc extends BaseBloc<OTPEvent, BaseState<OTPState>> {
  final VerifyOTP? verifyOTP;
  final RequestOTP? requestOTP;
  final AddJustPayInstrument? addJustPayInstrument;

  OTPBloc({this.verifyOTP, this.requestOTP, this.addJustPayInstrument}) : super(InitialOTPState()) {
    on<OTPVerificationEvent>(_onOTPVerificationEvent);
    on<RequestOTPEvent>(_onRequestOTPEvent);
    on<OtherBankRequestEvent>(_onOtherBankRequestEvent);

  }

  Future<void> _onOTPVerificationEvent(
      OTPVerificationEvent event, Emitter<BaseState<OTPState>> emit) async {
    emit(APILoadingState());
    final deviceID = await FlutterUdid.consistentUdid;
    final _result = await verifyOTP!(ChallengeRequestEntity(
      action: event.action ?? null,
      id: event.id ?? null,
      otpTranId: event.otpTranId,
      messageType: kMessageTypeChallengeReq,
      otp: event.otp,
      deviceId: deviceID,
      otpType: event.otpType,
      smsOtp: event.smsOtp,
      emailOtp: event.emailOtp,
      justpayOtp: event.justpayOtp,
      ids: event.ids
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
        return OTPVerificationFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode == APIResponse.SUCCESS || r.responseCode =="dbp-314"){
        return OTPVerificationSuccessState(
          id: r.data?.id
        );
      }else{
        return OTPVerificationFailedState(
          code: r.errorCode?? r.responseCode,
            message: r.errorDescription??r.responseDescription);
      }
      
    }));
  }

  Future<void> _onRequestOTPEvent(
      RequestOTPEvent event, Emitter<BaseState<OTPState>> emit) async {
    emit(APILoadingState());
    final _result = await requestOTP!(
        OtpRequest(otpType: event.OtpType, messageType: kOTPRequestType));

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
        return OTPRequestFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return OTPRequestSuccessState(otpResponse: r.data);
    }));
  }

  Future<void> _onOtherBankRequestEvent(
      OtherBankRequestEvent event, Emitter<BaseState<OTPState>> emit) async {
    emit(APILoadingState());
    final _result = await addJustPayInstrument!(AddJustPayInstrumentsRequest( messageType: kAddUserInstrumentRequestType));

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
        return JustPayOTPRequestFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode =="826"||r.responseCode =="00"){
         return JustPayOTPRequestSuccessState(addJustPayInstrumentsResponse: r.data);

      }  else{
         return JustPayOTPRequestFailedState(
            message: r.responseDescription);
      }
    }));
  }

}
