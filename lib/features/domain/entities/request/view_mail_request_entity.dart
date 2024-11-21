import 'package:union_bank_mobile/features/data/models/requests/view_mail_request.dart';

class ViewMailRequestEntity extends ViewMailRequest {
   ViewMailRequestEntity({
    String? epicUserId,
    int? page,
    int? size,
    String? recipientCategoryCode,
    String? recipientTypeCode,
    DateTime? fromDate,
    DateTime? toDate,
    int? hasAttachment,
    String? readStatus,
    String? subject
  }) : super(
          epicUserId: epicUserId,
          page: page,
          size: size,
          recipientCategoryCode:recipientCategoryCode,
          recipientTypeCode:recipientTypeCode,
          fromDate:fromDate,
          toDate:toDate,
          hasAttachment:hasAttachment,
          readStatus: readStatus,
          subject: subject
        );
}
