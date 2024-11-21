// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../base_event.dart';

abstract class FloatInquiryEvent extends BaseEvent {}


class FloatInquiryGetEvent extends FloatInquiryEvent {
    final bool? checkAllAccount;
    final String? accountNo;
    final String? accountType;

  FloatInquiryGetEvent({this.checkAllAccount, this.accountNo, this.accountType,});
}


