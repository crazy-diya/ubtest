// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/domain/entities/request/forget_pw_check_nic_account_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/forget_pw_check_security_question_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/forget_pw_check_username_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/forget_pw_reset_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_nic_account.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_security_question.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_username.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_reset.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_state.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';



class ForgetPasswordBloc extends BaseBloc<ForgetPasswordEvent, BaseState<ForgetPasswordState>> {
  final ForgetPwCheckNicAccount forgetPwCheckNicAccount;
  final ForgetPwCheckUsername forgetPwCheckUsername;
  final ForgetPwCheckSecurityQuestion forgetPwCheckSecurityQuestion;
  final ForgetPwReset forgetPwReset;
  final LocalDataSource? localDataSource;

  ForgetPasswordBloc( {
    required this.forgetPwCheckUsername,
    required this.forgetPwCheckNicAccount,
    required this.forgetPwCheckSecurityQuestion,
    required this.forgetPwReset,
    required this.localDataSource,
  }) : super(ForgetPasswordInitial()) {
    on<CheckNicAccountNumReqEvent> (_onCheckNicAccountNumReqEvent);
    on<CheckUsernameIdentityReqEvent> (_onCheckUsernameIdentityReqEvent);
    on<CheckSQAnswerReqEvent> (_onCheckSQAnswerReqEvent);
    on<ForgotPwResetReqEvent> (_onForgotPwResetReqEvent);
  }

   Future<void> _onCheckNicAccountNumReqEvent(CheckNicAccountNumReqEvent event, Emitter<BaseState<ForgetPasswordState>> emit) async {
    emit(APILoadingState());
    final result = await forgetPwCheckNicAccount(
      ForgetPwCheckNicAccountRequestEntity(
        accountNumber: event.accountNumber,
        identificationType: event.identificationType,
        identificationNo: event.identificationNo,
        messageType: knicIdentityReq,
      ));

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
        return CheckNicAccountNumReqFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.errorCode == "847"){
        return CheckNicAccountNumReqSuccessState(
            message: r.errorDescription, code: r.errorCode);
      }
      if(r.errorCode == "848"){
        return CheckNicAccountNumReqSuccessState(
            message: r.errorDescription, code: r.errorCode);
      }
      localDataSource?.setForgetPasswordUsername(r.data!.userName!);
      return CheckNicAccountNumReqSuccessState(
          message: r.responseDescription, forgetPasswordResponse: r.data);
    }));
  }

  Future<void> _onCheckUsernameIdentityReqEvent(CheckUsernameIdentityReqEvent event, Emitter<BaseState<ForgetPasswordState>> emit) async {
    emit(APILoadingState());
    final result = await forgetPwCheckUsername(
        ForgetPwCheckUsernameRequestEntity(
          username: event.username,
          identificationType: event.identificationType,
          identificationNo: event.identificationNo,
          messageType: kusernameReq
        ));

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
        return CheckUsernameIdentityReqFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.errorCode == "847"){
        return CheckUsernameIdentityReqSuccessState(
            message: r.errorDescription, code: r.errorCode);
      }
      if(r.errorCode == "846"){
        return CheckUsernameIdentityReqSuccessState(
            message: r.errorDescription, code: r.errorCode);
      }
     localDataSource?.setForgetPasswordUsername(r.data!.userName!);
      return CheckUsernameIdentityReqSuccessState(
          message: r.responseDescription, forgetPasswordResponse: r.data);
    }));
  }

  Future<void> _onCheckSQAnswerReqEvent(CheckSQAnswerReqEvent event, Emitter<BaseState<ForgetPasswordState>> emit) async {
    emit(APILoadingState());
    final result = await forgetPwCheckSecurityQuestion(
        ForgetPwCheckSecurityQuestionRequestEntity(
            answers: event.answers,
            identificationType: event.identificationType,
            identificationNo: event.identificationNo,
            messageType: kseQesAnsCheckReq
            ));

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
        return CheckSQAnswerReqFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      localDataSource?.setForgetPasswordUsername(r.data!.userName!);
      return CheckSQAnswerReqSuccessState(
          message: r.responseDescription, forgetPasswordResponse: r.data);
    }));
  }

  Future<void> _onForgotPwResetReqEvent(ForgotPwResetReqEvent event, Emitter<BaseState<ForgetPasswordState>> emit) async {
    emit(APILoadingState());

    String? userName = localDataSource?.getForgetPasswordUsername();
    final result = await forgetPwReset(
        ForgetPwResetRequestEntity(
        username: userName,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        messageType: kforgotPassResetReq));

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
        return ForgotPwResetReqFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ForgotPwResetReqSuccessState(
          message: r.responseDescription ?? r.errorDescription,);
    }));
  }
}
