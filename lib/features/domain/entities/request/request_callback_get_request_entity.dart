// To parse this JSON data, do
//
//     final requestCallBackGetRequest = requestCallBackGetRequestFromJson(jsonString);

import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_request.dart';

class RequestCallBackGetRequestEntity extends RequestCallBackGetRequest {
  RequestCallBackGetRequestEntity(
      {final String? epicUserId, final int? page, final int? size, final DateTime? fromDate,final DateTime? toDate, final String? status, final int? subject})
      : super(epicUserId: epicUserId, page: page, size: size, fromDate: fromDate, toDate: toDate, status: status, subject: subject);
}
