

import '../base_event.dart';

abstract class FTViewSchedulingEvent extends BaseEvent {}

class GetAllScheduleFTEvent extends FTViewSchedulingEvent{
  final String? messageType;
  final String? txnType;

  GetAllScheduleFTEvent({this.messageType, this.txnType});
}

class UpdateScheduleFTEvent extends FTViewSchedulingEvent{
  final int? scheduleId;
  final String? startDate;
  final String? endDate;
  final String?beneficiaryEmail;
  final String? beneficiaryMobile;
  final double? amount;
  final String? messageType;

  UpdateScheduleFTEvent(
      {this.scheduleId,
      this.startDate,
      this.endDate,
      this.beneficiaryEmail,
      this.beneficiaryMobile,
      this.messageType,
      this.amount});
}

class DeleteFTScheduleEvent extends FTViewSchedulingEvent{
  final String? messageType;
  final int? scheduleId;
  final String? remarks;

  DeleteFTScheduleEvent({this.messageType, this.scheduleId, this.remarks});
}

class ScheduleFTHistoryEvent extends FTViewSchedulingEvent{
  final String? messageType;
  final int? scheduleId;
  final int? size;
  final int? page;
  final String? txnType;

  ScheduleFTHistoryEvent(
      {this.messageType, this.scheduleId, this.txnType, this.size, this.page});
}

