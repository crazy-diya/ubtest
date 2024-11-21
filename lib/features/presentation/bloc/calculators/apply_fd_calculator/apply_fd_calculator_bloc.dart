import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/apply_fd_calculator_request.dart';
import '../../../../domain/usecases/calculators/apply_fd_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'apply_fd_calculator_event.dart';
part 'apply_fd_calculator_state.dart';

class ApplyFDCalculatorBloc extends BaseBloc<ApplyFDCalculatorEvent,
    BaseState<ApplyFDCalculatorState>> {
  final ApplyFDCalculatorData? applyFDCalculatorData;

  ApplyFDCalculatorBloc({required this.applyFDCalculatorData})
      : super(ApplyFDCalculatorInitial()) {
    on<ApplyFDCalculatorSaveDataEvent>(_applyFDCalculatorSaveData);
  }


  Future<void> _applyFDCalculatorSaveData(ApplyFDCalculatorSaveDataEvent event,
      Emitter<BaseState<ApplyFDCalculatorState>> emit) async {
    emit(APILoadingState());
    final result = await applyFDCalculatorData!(
      ApplyFdCalculatorRequest(
        name: event.name,
        nic: event.nic,
        email: event.email,
        mobileNumber: event.mobileNumber,
        reqType: event.reqType,
        messageType: event.messageType,
        branch: event.branch,
        rate: event.rate,
        // installmentType: event.installmentType,
        interestRecieved: event.interestRecieved,
        interestPeriod: event.interestPeriod,
        currencyCode: event.currencyCode,
        amount: event.amount
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
        return ApplyFDCalculatorFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ApplyFDCalculatorFieldDataSuccessState(
        // responseCode: r.data!.responseCode,
          responseDescription: r.responseDescription

      );
    }));
  }
}