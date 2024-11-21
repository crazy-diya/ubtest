// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../base_event.dart';

abstract class RequestCallBackEvent extends BaseEvent {}

class RequestCallBackGetEvent extends RequestCallBackEvent {
  final int? page;
    final int? size;
    final DateTime? fromDate;
    final DateTime? toDate;
    final String? status;
    final int? subject;

  RequestCallBackGetEvent(
      {this.page,
      this.size,
      this.fromDate,
      this.toDate,
      this.status,
      this.subject});
}

class RequestCallBackSaveEvent extends RequestCallBackEvent {
    final String? callBackTime;
    final String? subject;
    final String? language;
    final String? comment;

  RequestCallBackSaveEvent({this.callBackTime, this.subject, this.language, this.comment});
}

class RequestCallBackGetDefaultDataEvent extends RequestCallBackEvent {}


class RequestCallBackCancelEvent extends RequestCallBackEvent {
  final int? requestCallBackId;
  RequestCallBackCancelEvent({
    this.requestCallBackId,
  });
  
}

