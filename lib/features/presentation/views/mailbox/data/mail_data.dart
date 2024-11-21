import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';

class MailData{
  final int messageType;
  final bool? isNewCompose;
  final ViewMailData viewMailData;
  MailData({
    required this.messageType,
    required this.viewMailData,
    this.isNewCompose = false
  });

}