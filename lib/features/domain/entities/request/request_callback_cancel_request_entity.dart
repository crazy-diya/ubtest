// To parse this JSON data, do
//
//     final requestCallBackCancelRequest = requestCallBackCancelRequestFromJson(jsonString);



import 'package:union_bank_mobile/features/data/models/requests/request_callback_cancel_request.dart';

class RequestCallBackCancelRequestEntity extends RequestCallBackCancelRequest {
    

    RequestCallBackCancelRequestEntity({
        int? requestCallBackId,
    }):super(requestCallBackId:requestCallBackId);
}
