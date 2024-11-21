import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/merchant_locator_request.dart';
import '../../../domain/usecases/locator/merchant_locator.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'locator_event.dart';
import 'locator_state.dart';

class LocatorBloc extends BaseBloc<LocatorEvent, BaseState<LocatorState>> {
  final MerchantLocator? merchantLocator;

  LocatorBloc({this.merchantLocator}) : super(InitialLocatorState()) {
    on<GetLocatorEvent>(_onGetLocatorEvent);
  }

  Future<void> _onGetLocatorEvent(
      GetLocatorEvent event, Emitter<BaseState<LocatorState>> emit) async {
    emit(APILoadingState());
    final response = await merchantLocator!(
      MerchantLocatorRequest(
        messageType: kMerchantLocatorRequestType,
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
        return GetLocatorFailedState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode==APIResponse.SUCCESS){
        
      return GetLocatorLoadedState(
            branchData: r.data?.branch,
            atmData: r.data?.atm,
            cdmData: r.data?.cdm);

      }else{
        return GetLocatorFailedState(
            errorMessage: r.errorDescription??r.responseDescription);
      }
    }));
  }
}
