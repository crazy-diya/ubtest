
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/models/responses/get_terms_response.dart';
import '../../../../domain/entities/request/get_terms_request_entity.dart';
import '../../../../domain/entities/request/terms_accept_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/terms/accept_terms_data.dart';
import '../../../../domain/usecases/terms/get_terms_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'tnc_event.dart';
import 'tnc_state.dart';

class TnCBloc extends BaseBloc<TnCEvent, BaseState<TnCState>> {
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;
  final GetTermsData? useCaseGetTerms;
  final AcceptTermsData? useCaseAcceptTerms;

  TnCBloc({
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.useCaseGetTerms,
    this.useCaseAcceptTerms,
  }) : super(InitialTnCState()) {
    on<GetTermsEvent>(_onGetTermsEvent);
    on<AcceptTermsEvent>(_onAcceptTermsEvent);
  }

  Future<void> _onGetTermsEvent(
      GetTermsEvent event, Emitter<BaseState<TnCState>> emit) async {
    emit(APILoadingState());
    final result = await useCaseGetTerms!(
      GetTermsRequestEntity(
        messageType: kMessageTypeTermsAndConditionsGetReq,
        termType: event.termType,
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
        return TermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      final TermsData? termsData = r.data!.data;
      return TermsLoadedState(termsData: termsData);
    }));
  }

  Future<void> _onAcceptTermsEvent(
      AcceptTermsEvent event, Emitter<BaseState<TnCState>> emit) async {
    emit(APILoadingState());

    await storeWalletOnBoardingData!(
      Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.PERSONALINFO.toString(),
              stepperValue: KYCStep.PERSONALINFO.getStep())),
    );

    final result = await useCaseAcceptTerms!(
      TermsAcceptRequestEntity(
        termId: event.termId,
        acceptedDate: event.acceptedDate,
        messageType: kMessageTypeTermsAndConditionsAcceptReq,
        termType: event.termType,
        isMigrated: event.isMigrated
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
        return TermsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return TermsSubmittedState(message: r.responseDescription,responseCode: r.responseCode);
    }));
  }
}
