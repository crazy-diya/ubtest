
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';

class MarkAsReadMailRequestEntity extends MarkAsReadMailRequest{

    const MarkAsReadMailRequestEntity({
        String? epicUserId,
        List<int>? inboxIdList,
    }):super(epicUserId: epicUserId,inboxIdList: inboxIdList);
}
