
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/security_questions/get_security_questions.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/enums.dart';
import '../../../../domain/entities/request/set_security_questions_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/security_questions/set_security_questions.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'security_questions_event.dart';
import 'security_questions_state.dart';

class SecurityQuestionsBloc extends BaseBloc<SecurityQuestionsEvent,
    BaseState<SecurityQuestionsState>> {
  final SetSecurityQuestions? useCaseSetQuestions;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;
  final GetSecurityQuestions useCaseGetQuestions;

  SecurityQuestionsBloc({
    required this.useCaseGetQuestions,
    this.useCaseSetQuestions,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
  }) : super(InitialSecurityQuestionsState()) {
    on<SetSecurityQuestionsEvent>(_onSetSecurityQuestionsEvent);
    on<SaveSecurityQuestionsEvent>(_onSaveSecurityQuestionsEvent);
    on<GetSecurityQuestionSECDropDownEvent>(_getSecurityQuestionDropDown);
  }

  Future<void> _onSetSecurityQuestionsEvent(SetSecurityQuestionsEvent event,
      Emitter<BaseState<SecurityQuestionsState>> emit) async {
    emit(APILoadingState());

    final _result = await useCaseSetQuestions!(SetSecurityQuestionsEntity(
        messageType: kMessageTypeAnswerSecurityQuestionReq,
        answerList: event.answerList,isMigrated: event.isMigrated));

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
        return SetSecurityQuestionsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return SetSecurityQuestionsSuccessState();
    }));
  }

  Future<void> _onSaveSecurityQuestionsEvent(SaveSecurityQuestionsEvent event,
      Emitter<BaseState<SecurityQuestionsState>> emit) async {
    emit(APILoadingState());
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Store the Wallet Data
      final _result = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperName: KYCStep.CREATEUSER.toString(),
            stepperValue: KYCStep.CREATEUSER.getStep(),
            walletUserData: result
                .getOrElse(
                  (l) => null,
                )!
                .walletUserData,
          ),
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
        return SaveSecurityQuestionsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
      }, (r) {
        return SaveSecurityQuestionsSuccessState();
      }));
    } else {
      emit(SaveSecurityQuestionsFailedState());
    }
  }

    Future<void> _getSecurityQuestionDropDown(
      GetSecurityQuestionSECDropDownEvent event,
      Emitter<BaseState<SecurityQuestionsState>> emit) async {
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
            return SecurityQuestionsDropDownDataFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
            (r) {
              if(r.responseCode == APIResponse.SUCCESS || r.responseCode == "dbp-319") {
                return SecurityQuestionsDropDownDataLoadedState(
              data: r.data?.data
                  ?.map(
                    (e) => CommonDropDownResponse(
                  description: e.secQuestion,
                  id: e.id,
                ),
              )
                  .toList());
              }else{
                return SecurityQuestionsDropDownDataFailedState(
                message: r.errorDescription??r.responseDescription);

              }
        },
      ),
    );
  }
}
