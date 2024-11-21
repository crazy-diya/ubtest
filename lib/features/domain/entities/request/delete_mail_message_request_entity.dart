

import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';

class DeleteMailMessageRequestEntity extends DeleteMailMessageRequest{

    const DeleteMailMessageRequestEntity({
        String? epicUserId,
        List<int>? inboxMessageIdList,
    }):super(epicUserId: epicUserId,inboxMessageIdList: inboxMessageIdList);
}
