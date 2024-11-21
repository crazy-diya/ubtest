import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/network/network_config.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/domain/entities/request/float_inquiry_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/float_inquiry/float_inquiry.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'float_inquiry_event.dart';
import 'float_inquiry_state.dart';

class FloatInquiryBloc
    extends BaseBloc<FloatInquiryEvent, BaseState<FloatInquiryState>> {
  final FloatInquiry? floatInquiry;
  final LocalDataSource? localDataSource;

 FloatInquiryBloc({
    this.floatInquiry,
    this.localDataSource
  }) : super(InitialFloatInquiryState()) {
    on<FloatInquiryGetEvent>(_onRequestCallBackSaveEvent);
  }

    Future<void> _onRequestCallBackSaveEvent(FloatInquiryGetEvent event,
      Emitter<BaseState<FloatInquiryState>> emit) async {
    emit(APILoadingState());
     final String epicUserId = localDataSource?.getEpicUserId() ??"";
    final result = await floatInquiry!(
      FloatInquiryRequestEntity(
        epicUserId: epicUserId,
        checkAllAccount: event.checkAllAccount,
        accountNo: event.accountNo,
        accountType: event.accountType
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
       }
       else {
        return FloatInquiryFailState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      if(r.responseCode ==APIResponse.SUCCESS) {
      return FloatInquirySuccessState( floatInquiryResponse: r.data);
      }else{
        return FloatInquiryFailState(
          message: r.errorDescription??r.responseDescription,
          responseCode: r.errorCode??r.responseCode
        );
      }
    }));
  }

}
