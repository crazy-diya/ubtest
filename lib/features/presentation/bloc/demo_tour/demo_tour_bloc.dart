import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:union_bank_mobile/features/domain/usecases/demo_tour/demo_tour.dart';

import '../../../../error/failures.dart';
import '../../../../utils/api_msg_types.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'demo_tour_event.dart';

part 'demo_tour_state.dart';

class DemoTourBloc extends BaseBloc<DemoTourEvent, BaseState<DemoTourState>> {
  final DemoTour? demoTour;

  DemoTourBloc({this.demoTour}) : super(DemoTourInitial()) {
    on<GetDemoTourEvent>(_onGetDemoTourEvent);
  }

  Future<void> _onGetDemoTourEvent(GetDemoTourEvent event,
      Emitter<BaseState<DemoTourState>> emit) async {
      emit(APILoadingState());
      final result = await demoTour!(const CommonRequestEntity(messageType: kDemoTour));

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
        return DemoTourFailedState(
          message: ErrorHandler().mapFailureToMessage(l),
        );
      }
    }, (r) {
      return DemoTourSuccessState(
        demoTourList: r.data,
      );
    }));
  }
}
