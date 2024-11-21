// To parse this JSON data, do
//
//     final requestCallBackSaveRequest = requestCallBackSaveRequestFromJson(jsonString);



import 'package:union_bank_mobile/features/data/models/requests/request_callback_save_request.dart';



class RequestCallBackSaveRequestEntity extends RequestCallBackSaveRequest {
  RequestCallBackSaveRequestEntity({
    String? epicUserId,
    String? callBackTime,
    String? subject,
    String? language,
    String? comment,
  }) : super(
            epicUserId: epicUserId,
            callBackTime: callBackTime,
            subject: subject,
            language: language,
            comment: comment);
}
