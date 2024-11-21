
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../error/failures.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/models/requests/submit_products_request.dart';
import '../../../../domain/entities/request/common_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/other_products/get_other_products.dart';
import '../../../../domain/usecases/other_products/submit_other_products.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'other_products_event.dart';
import 'other_products_state.dart';

class OtherProductsBloc
    extends BaseBloc<OtherProductsEvent, BaseState<OtherProductsState>> {
  final GetOtherProducts? getOtherProducts;
  final SubmitOtherProducts? submitOtherProducts;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;

  OtherProductsBloc({
    this.getOtherProducts,
    this.submitOtherProducts,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
  }) : super(InitialOtherProductsState()) {
    on<GetOtherProductsEvent>(_onGetOtherProductsEvent);
    on<SubmitOtherProductsEvent>(_onSubmitOtherProductsEvent);
    on<SaveOtherProductsEvent>(_onSaveOtherProductsEvent);
    on<SaveUserEvent>(_onSaveUserEvent);
  }

  Future<void> _onGetOtherProductsEvent(GetOtherProductsEvent event,
      Emitter<BaseState<OtherProductsState>> emit) async {
    emit(APILoadingState());
    final result = await getOtherProducts!(
       const Parameters(
        otherProductRequest: CommonRequestEntity(
          messageType: kMessageTypeInterestedProductReq,
        ),
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
      }else {
        return GetOtherProductsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetOtherProductsLoadedState(data: r.data!.data);
    }));
  }

  Future<void> _onSubmitOtherProductsEvent(SubmitOtherProductsEvent event,
      Emitter<BaseState<OtherProductsState>> emit) async {
    emit(APILoadingState());
    final result = await submitOtherProducts!(Params(
      submitProductsRequest: SubmitProductsRequest(
          messageType: kSubmitOtherProductsRequestType, products: event.data),
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
     }else {
        return SubmitOtherProductFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return SubmitOtherProductSuccessState(message: r.errorDescription);
    }));
  }

  Future<void> _onSaveOtherProductsEvent(SaveOtherProductsEvent event,
      Emitter<BaseState<OtherProductsState>> emit) async {
    emit(APILoadingState());
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Store the Wallet Data
      final _result = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperName: KYCStep.SECURITYQ.toString(),
            stepperValue: KYCStep.SECURITYQ.getStep(),
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
        return SaveOtherProductsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
      }, (r) {
        return SaveOtherProductsSuccessState();
      }));
    } else {
      emit(SaveOtherProductsFailedState());
    }
  }

  Future<void> _onSaveUserEvent(
      SaveUserEvent event, Emitter<BaseState<OtherProductsState>> emit) async {
    emit(APILoadingState());
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Store the Wallet Data
      final _result = await storeWalletOnBoardingData!(
        Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
            stepperName: KYCStep.SECURITYQ.toString(),
            stepperValue: KYCStep.SECURITYQ.getStep(),
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
}
