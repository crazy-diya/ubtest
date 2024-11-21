

import '../../../data/models/responses/edit_ft_schedule_response.dart';
import '../../../data/models/responses/get_all_fund_transfer_schedule_response.dart';
import '../../../data/models/responses/schedule_ft_history_response.dart';
import '../base_state.dart';

abstract class FTViewSchedulingState extends BaseState<FTViewSchedulingState> {}

class InitialGetAllScheduleFTState extends FTViewSchedulingState {}

class GetAllScheduleFTSuccessState extends FTViewSchedulingState{
  final List<ScheduleDetailsDto>? completedScheduleDetailsDtos;
  final List<ScheduleDetailsDto>? ongoingScheduleDetailsDtos;
  final List<ScheduleDetailsDto>? upcomingScheduleDetailsDtos;
  final List<ScheduleDetailsDto>? deletedScheduleDetailsDtos;

  GetAllScheduleFTSuccessState(
      {this.completedScheduleDetailsDtos,
      this.ongoingScheduleDetailsDtos,
      this.upcomingScheduleDetailsDtos,
      this.deletedScheduleDetailsDtos});
}
class GetAllScheduleFTFailedState extends FTViewSchedulingState{
  final String? errorMessage;

  GetAllScheduleFTFailedState({this.errorMessage});
}

class EditSchedulingFTSuccessState extends FTViewSchedulingState{
  final EditFtScheduleResponse? editFtScheduleResponse;
  final String? responseDes;
  final String? responseCode;

  EditSchedulingFTSuccessState({this.editFtScheduleResponse, this.responseDes, this.responseCode});
}

class EditSchedulingFTFailState extends FTViewSchedulingState{
  final String? errorMessage;

  EditSchedulingFTFailState({this.errorMessage});
}

class DeleteSchedulingFTSuccessState extends FTViewSchedulingState{
  final bool? scheduleCanceled;

  DeleteSchedulingFTSuccessState({this.scheduleCanceled});
}

class DeleteSchedulingFTFailState extends FTViewSchedulingState{
  final String? errorMessage;

  DeleteSchedulingFTFailState({this.errorMessage});
}

// class SchedulingFTHistorySuccessState extends FTViewSchedulingState{
//   final String? responsedes;
//   final ScheduleHistoryData? scheduleHistoryData;
//   final List<SchFundTransferHistoryResponseDto>? schFundTransferHistoryResponseDto;
//
//   SchedulingFTHistorySuccessState(
//       {this.responsedes,
//       this.scheduleHistoryData,
//       this.schFundTransferHistoryResponseDto});
// }
class SchedulingFTHistorySuccessState extends FTViewSchedulingState{
  final ScheduleFtHistoryResponse? scheduleFtHistoryResponse;
  final List<SchFundTransferHistoryResponseTempDtoList>? schFundTransferHistoryResponseTempDtoList;

  SchedulingFTHistorySuccessState(
      {this.scheduleFtHistoryResponse,
      this.schFundTransferHistoryResponseTempDtoList});
}

class SchedulingFTHistoryFailState extends FTViewSchedulingState{
  final String? errorMessage;

  SchedulingFTHistoryFailState({this.errorMessage});
}