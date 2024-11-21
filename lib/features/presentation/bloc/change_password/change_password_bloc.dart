import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/messages.dart';

import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_string.dart';
import '../../../data/models/requests/change_password_request.dart';
import '../../../domain/usecases/change_password/change_password.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends BaseBloc<ChangePasswordEvent, BaseState<ChangePasswordState>> {
  final ChangePassword? changePassword;

  ChangePasswordBloc({this.changePassword}) : super(ChangePasswordInitial()) {
    on<ChangeCurrentPasswordEvent>(_onChangeCurrentPasswordEvent);
  }

  Future<void> _onChangeCurrentPasswordEvent(ChangeCurrentPasswordEvent event,
      Emitter<BaseState<ChangePasswordState>> emit) async {
    if (event.oldPassword!.isEmpty) {
      emit(ChangePasswordFailState(message: AppString.emptyOldPassword));
    } else if (event.newPassword!.isEmpty) {
      emit(ChangePasswordFailState(message: AppString.emptyNewPassword));
    } else if (event.confirmPassword!.isEmpty) {
      emit(ChangePasswordFailState(message: AppString.emptyConfirmNewPassword));
    } else if (event.newPassword != event.confirmPassword) {
      emit(ChangePasswordConfirmPasswordWrong(
          errorMessage: "Password does not match with new password"));
    } else {
      emit(APILoadingState());
      final _result = await changePassword!(
        ChangePasswordRequest(
            messageType: kChangePasswordRequestType,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            confirmPassword: event.confirmPassword),
      );

      emit(_result.fold((l) {
        // final failure = l as ServerFailure;
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
          if ((l as ServerFailure).errorResponse.errorCode ==
              APIResponse.WRONG_CURRENT_PASSWORD_ERROR_MESSAGE) {
            return ChangePasswordWrongCurrentPassword(
                errorMessage: "Password does not match try again");
          } else {
            return ChangePasswordApiFailState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        }
      }, (r) {
        return ChangePasswordSuccessState(
          responseDescription: r.responseDescription,
          responseCode: r.responseCode,
        );
      }));
    }
  }
}
