import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_bank_mobile/features/data/models/requests/apply_personal_loan_request.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../domain/usecases/calculators/apply_personal_loan_calculator.dart';
import '../../base_bloc.dart';
import '../../base_event.dart';
import '../../base_state.dart';

part 'apply_personal_loan_event.dart';
part 'apply_personal_loan_state.dart';

class ApplyPersonalLoanBloc extends BaseBloc<ApplyPersonalLoanEvent,
    BaseState<ApplyPersonalLoanState>> {
  final ApplyPersonalLoanCalculator? applyPersonalLoanCalculator;

  ApplyPersonalLoanBloc({required this.applyPersonalLoanCalculator})
      : super(ApplyPersonalLoanInitial()) {
    on<ApplyPersonalLoanSaveDataEvent>(_applyPersonalLoanSaveData);
  }


  Future<void> _applyPersonalLoanSaveData(ApplyPersonalLoanSaveDataEvent event,
      Emitter<BaseState<ApplyPersonalLoanState>> emit) async {
    emit(APILoadingState());
    final result = await applyPersonalLoanCalculator!(
      ApplyPersonalLoanRequest(
        name: event.name,
        nic: event.nic,
        email: event.email,
        mobileNumber: event.mobileNumber,
        reqType: event.reqType,
        paymentPeriod: event.paymentPeriod,
        grossIncome: event.grossIncome,
        amount: event.amount,
        messageType: "savePersonalLoanReq",
        rate: event.rate,
        installmentType: event.installmentType
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
        return ApplyPersonalLoanFieldDataFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return ApplyPersonalLoanFieldDataSuccessState(responseDescription: r.responseDescription);
    }));
  }
}
