
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';

// ignore: must_be_immutable
class MailCountRequestEntity extends MailCountRequest {

  MailCountRequestEntity({int? page, int? size,})
      : super( page: page, size: size, );
}