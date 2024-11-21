

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/requests/check_user_request.dart';
import 'package:union_bank_mobile/features/domain/entities/request/create_user_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/check_user/check_user.dart';
import 'package:union_bank_mobile/features/domain/usecases/create_user/create_user.dart';
import 'package:union_bank_mobile/features/domain/usecases/epicuser_id/save_epicuser_id.dart';
import 'package:union_bank_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:union_bank_mobile/features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_state.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/extension.dart';

class CreateUserBloc
    extends BaseBloc<CreateUserParentEvent, BaseState<CreateUserState>> {
  final LocalDataSource? appSharedData;
  final CreateUser? createUser;
  final CheckUser? checkUser;
  final SetEpicUserID? setEpicUserID;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;

  CreateUserBloc({
    this.appSharedData,
    this.createUser,
    this.setEpicUserID,
    this.checkUser,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
  }) : super(InitialCreateUserState()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<SaveUserEvent>(_onSaveUserEvent);
    on<CheckUserEvent>(_onCheckUserEvent);
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<BaseState<CreateUserState>> emit) async {
    emit(APILoadingState());
    final result = await createUser!(CreateUserEntity(
        username: event.username,
        password: event.password!.toBase64(),
        confirmPassword: event.confirmPassword!.toBase64(),
        ///TODO: CHANGE THIS TO kDigitalOnBoarding
        onBoardedType: 'CAO',
        messageType: kCreateUserRequestType));

    emit(
      await result.fold(
        (l) async {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is SessionExpire) {
            return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
              return CreateUserFailedState(

                // message: ErrorHandler.errorMessageAlreadyExistingUserName,
              );
          }
        },
        (r) async {
          if (r.data!.epicUserId != null) {
            if(r.responseCode=="00"){
            final eitherSuccessOrFailed = await setEpicUserID!(r.data!.epicUserId!);
            return eitherSuccessOrFailed.fold(
                (l) {
                  if (l is AuthorizedFailure) {
                  return AuthorizedFailureState(
                      error: ErrorHandler().mapFailureToMessage(l) ?? "");
                } else if (l is SessionExpire) {
                  return SessionExpireState(
                      error: ErrorHandler().mapFailureToMessage(l) ?? "");
                } else if (l is ConnectionFailure) {
                  return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
                } else if (l is ServerFailure) {
                    return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
                  }else {
                  return CreateUserFailedState(
                      message: ErrorHandler().mapFailureToMessage(l));
                }
              }, (r) {
              appSharedData!.setUserName(event.username!);
              return CreateUserSuccessState();
            });
            }else if(r.responseCode=="01"){
            return  CreateUserFailedState(
                    message: r.errorDescription);

            }
          }
          return CreateUserFailedState(
            message: r.errorDescription,
          );
        },
      ),
    );
  }



  Future<void> _onSaveUserEvent(
      SaveUserEvent event, Emitter<BaseState<CreateUserState>> emit) async {
    emit(APILoadingState());
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Store the Wallet Data
      final _result = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperName: KYCStep.BIOMETRIC.toString(),
            stepperValue: KYCStep.BIOMETRIC.getStep(),
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
        }else {
        return SaveUserFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
      }, (r) {
        return SaveUserSuccessState();
      }));
    } else {
      emit(SaveUserFailedState());
    }
  }

  
    Future<void> _onCheckUserEvent( CheckUserEvent event, Emitter<BaseState<CreateUserState>> emit) async {
    emit(APILoadingState());
    final result = await checkUser!(CheckUserRequest(
      messageType:"splashReq",
      userName: event.username));

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
        return CheckUserFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseDescription=="OK"){
         return CheckUserSuccessState();

      }else{
          return CheckUserFailedState(
            message:r.responseDescription);
      }
     
    }));
  }
}
