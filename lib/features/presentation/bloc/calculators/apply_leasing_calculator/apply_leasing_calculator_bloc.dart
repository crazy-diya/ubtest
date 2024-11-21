import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/apply_leasing_request.dart';
import '../../../../domain/usecases/calculators/apply_leasing_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'apply_leasing_calculator_event.dart';

part 'apply_leasing_calculator_state.dart';

class ApplyLeasingCalculatorBloc extends BaseBloc<ApplyLeasingCalculatorEvent,
    BaseState<ApplyLeasingCalculatorState>> {
  final ApplyLeasingCalculatorData? applyLeasingCalculatorData;

  ApplyLeasingCalculatorBloc({required this.applyLeasingCalculatorData})
      : super(ApplyLeasingCalculatorInitial()) {
    on<ApplyLeasingCalculatorSaveDataEvent>(_applyLeasingCalculatorSaveData);
  }

  Future<void> _applyLeasingCalculatorSaveData(
      ApplyLeasingCalculatorSaveDataEvent event,
      Emitter<BaseState<ApplyLeasingCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await applyLeasingCalculatorData!(
      ApplyLeasingCalculatorRequest(
          messageType: event.messageType,
          name:event.name,
          nic: event.nic,
          email: event.email,
          mobileNumber: event.mobileNumber,
          branch: event.branch,
          reqType: event.reqType,
        rate: event.rate,
        // installmentType: event.installmentType,
        vehicleCategory: event.vehicleCategory,
        vehicleType: event.vehicleType,
        manufactYear: event.manufactYear,
        price: event.price,
        advancedPayment: event.advancedPayment,
        amount: event.amount,
        interestPeriod: event.interestPeriod
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
        return ApplyLeasingCalculatorFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ApplyLeasingCalculatorFieldDataSuccessState();
    }));
  }
}
