import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/temporary_login_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/reset_password/temporary_login.dart';
import 'package:union_bank_mobile/utils/app_string.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../error/failures.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/reset_password_request.dart';
import '../../../domain/usecases/reset_password/reset_password.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc
    extends BaseBloc<ResetPasswordEvent, BaseState<ResetPasswordState>> {
  final ResetPassword? resetPassword;
  final TemporaryLogin? temporaryLogin;

  ResetPasswordBloc({this.resetPassword,this.temporaryLogin,}) : super(ResetPasswordInitial()) {
    on<ResetCurrentPasswordEvent>(_onResetCurrentPasswordEvent);
    on<TemporaryResetEvent>(_onTemporaryResetEvent);
  }

  Future<void> _onResetCurrentPasswordEvent(ResetCurrentPasswordEvent event,
      Emitter<BaseState<ResetPasswordState>> emit) async {
      emit(APILoadingState());
      final _result = await resetPassword!(
        ResetPasswordRequest(
            messageType: kChangePasswordRequestType,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            confirmPassword: event.confirmPassword,
            isAdminPasswordReset: event.isAdminPasswordReset),
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
            return ResetPasswordFailState(
                message: ErrorHandler().mapFailureToMessage(l),
            responseCode: (l as ServerFailure).errorResponse.errorCode??''
            );
          }

      }, (r) {
        if(r.responseCode == "00"){
          return ResetPasswordSuccessState(
            responseDescription: r.responseDescription,
            responseCode: r.responseCode,
          );
        } else {
          return ResetPasswordFailState(
              message:r.errorDescription,
              responseCode: r.errorCode
          );
        }

      }));
  }

   Future<void> _onTemporaryResetEvent(
      TemporaryResetEvent event, Emitter<BaseState<ResetPasswordState>> emit) async {
    emit(APILoadingState());
    
    if (event.password!.isEmpty) {
      emit(TemporaryResetFailedState(message: AppString.password));
    } else {
      final _result = await temporaryLogin!(
        TemporaryLoginRequestEntity(
          messageType: kMobileLoginRequestType,
          username: event.username,
          password: event.password!.toBase64(), 
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
          return TemporaryResetAPIFailedState(
              errorCode: (l as ServerFailure).errorResponse.errorCode,
              message: ErrorHandler().mapFailureToMessage(l));
        }
      }, (r) {
        if(r.data?.status =="SUCCESS"){
      return TemporaryResetSuccessState(
              temporaryLoginResponse: r.data,
              responseCode: r.responseCode,
              responseDescription: r.responseDescription,
              );
      }else {
        return 
            TemporaryResetAPIFailedState(
              errorCode: r.responseCode, message: r.responseDescription);
      }
        
      }));
    }
  }
}
