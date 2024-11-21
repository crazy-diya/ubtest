

import 'package:bloc/bloc.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../data/models/requests/delete_ft_schedule_request.dart';
import '../../../data/models/requests/edit_ft_schedule_request.dart';
import '../../../data/models/requests/get_all_fund_transfer_schedule_request.dart';
import '../../../data/models/requests/schedule_ft_history_request.dart';
import '../../../domain/usecases/fund_transfer/delete_schedule_ft.dart';
import '../../../domain/usecases/fund_transfer/edit_scheduling_fund_transfer.dart';
import '../../../domain/usecases/fund_transfer/get_all_fund_transfer_schedule.dart';
import '../../../domain/usecases/fund_transfer/schedule_ft_history.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'ft_view_scheduling_event.dart';
import 'ft_view_scheduling_state.dart';

class FTViewSchedulingBloc
    extends BaseBloc<FTViewSchedulingEvent, BaseState<FTViewSchedulingState>> {
  final GetAllFTSchedule? getAllFTSchedule;
 final EditSchedulingFT? editSchedulingFT;
 final DeleteSchedulingFT? deleteSchedulingFT;
 final SchedulingFTHistory? schedulingFTHistory;

  FTViewSchedulingBloc({this.getAllFTSchedule, this.editSchedulingFT , this.deleteSchedulingFT, this.schedulingFTHistory})
      : super(InitialGetAllScheduleFTState()) {
    on<GetAllScheduleFTEvent>(_getAllScheduleFTEvent);
    on<UpdateScheduleFTEvent>(_updateScheduleFTEvent);
    on<DeleteFTScheduleEvent>(_deleteScheduleFTEvent);
    on<ScheduleFTHistoryEvent>(_scheduleFTHistoryEvent);
  }

  Future<void> _getAllScheduleFTEvent(
      GetAllScheduleFTEvent event,
      Emitter<BaseState<FTViewSchedulingState>> emit,
      ) async {
    emit(APILoadingState());
    final response = await getAllFTSchedule!(
      GetAllFundTransferScheduleRequest(
        messageType: event.messageType,
        txnType: event.txnType,
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
        return GetAllScheduleFTFailedState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return  GetAllScheduleFTSuccessState(
          completedScheduleDetailsDtos: r.data!.completedScheduleDetailsDtos,
        deletedScheduleDetailsDtos: r.data!.deletedScheduleDetailsDtos,
        ongoingScheduleDetailsDtos: r.data!.ongoingScheduleDetailsDtos,
        upcomingScheduleDetailsDtos: r.data!.upcomingScheduleDetailsDtos
      );
    }));
  }


  Future<void> _updateScheduleFTEvent(
      UpdateScheduleFTEvent event,
      Emitter<BaseState<FTViewSchedulingState>> emit,
      ) async {
    emit(APILoadingState());
    final response = await editSchedulingFT!(
      EditFtScheduleRequest(
        messageType: "scheduleFtReq",
          scheduleId: event.scheduleId,
          startDate: event.startDate,
          endDate: event.endDate,
          beneficiaryEmail: event.beneficiaryEmail,
          beneficiaryMobile: event.beneficiaryMobile,
          amount: event.amount!.toInt(),
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
        return EditSchedulingFTFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return  EditSchedulingFTSuccessState(
        responseDes: r.responseDescription,
        editFtScheduleResponse: r.data,
        responseCode: r.responseCode
      );
    }));
  }

  Future<void> _deleteScheduleFTEvent(
      DeleteFTScheduleEvent event,
      Emitter<BaseState<FTViewSchedulingState>> emit,
      ) async {
    emit(APILoadingState());
    final response = await deleteSchedulingFT!(
        DeleteFtScheduleRequest(
            messageType: event.messageType,
            scheduleId: event.scheduleId,
          remarks: event.remarks
        )
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
        return DeleteSchedulingFTFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return  DeleteSchedulingFTSuccessState(
        scheduleCanceled: r.data!.scheduleCanceled
      );
    }));
  }

  Future<void> _scheduleFTHistoryEvent(
      ScheduleFTHistoryEvent event,
      Emitter<BaseState<FTViewSchedulingState>> emit,
      ) async {
    emit(APILoadingState());
    final response = await schedulingFTHistory!(
        ScheduleFtHistoryReq(
          size: event.size,
          page: event.page,
          scheduleId: event.scheduleId,
          messageType: event.messageType,
          txnType: event.txnType,
        )
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
        return SchedulingFTHistoryFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return  SchedulingFTHistorySuccessState(
        scheduleFtHistoryResponse: r.data,
        schFundTransferHistoryResponseTempDtoList: r.data!.schFundTransferHistoryResponseTempDtoList
      );
    }));
  }
}