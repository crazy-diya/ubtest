import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../data/models/requests/apply_housing_loan_request.dart';
import '../../../../domain/usecases/calculators/apply_housing_loan_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'apply_housing_loan_event.dart';
part 'apply_housing_loan_state.dart';

class ApplyHousingLoanBloc extends BaseBloc<ApplyHousingLoanEvent,
    BaseState<ApplyHousingLoanState>> {
  final ApplyHousingLoanCalculatorData? applyHousingLoanCalculator;

  ApplyHousingLoanBloc({required this.applyHousingLoanCalculator})
      : super(ApplyHousingLoanInitial()) {
    on<ApplyHousingLoanSaveDataEvent>(_applyHousingLoanSaveData);
  }


  Future<void> _applyHousingLoanSaveData(ApplyHousingLoanSaveDataEvent event,
      Emitter<BaseState<ApplyHousingLoanState>> emit) async {
    emit(APILoadingState());
    final result = await applyHousingLoanCalculator!(
      ApplyHousingLoanRequest(
        name: event.name,
        nic: event.nic,
        email: event.email,
        mobileNumber: event.mobileNumber,
        reqType: event.reqType,
        paymentPeriod: event.paymentPeriod,
        grossIncome: event.grossIncome,
        amount: event.amount,
        messageType: event.messageType,
        installmentType: event.installmentType,
        rate: event.rate
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
        return ApplyHousingLoanFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ApplyHousingLoanFieldDataSuccessState(responseDes: r.responseDescription);
    }));
  }
}
