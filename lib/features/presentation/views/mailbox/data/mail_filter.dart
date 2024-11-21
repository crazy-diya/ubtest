// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';

class MailFilter {
   CommonDropDownResponse? recipientCategoryCode;
   CommonDropDownResponse? recipientTypeCode;
   DateTime? fromDate;
   DateTime? toDate;
   int? hasAttachment;
   String? readStatus;
   String? subject;
   bool? isFiltered;
   

  MailFilter({
    this.recipientCategoryCode,
    this.recipientTypeCode,
    this.fromDate,
    this.toDate,
    this.hasAttachment,
    this.readStatus,
    this.subject,
    this.isFiltered

  });

  @override
  String toString() {
    return 'MailFilter(recipientCategoryCode: $recipientCategoryCode, recipientTypeCode: $recipientTypeCode, fromDate: $fromDate, toDate: $toDate, hasAttachment: $hasAttachment, readStatus: $readStatus, subject: $subject)';
  }
}
