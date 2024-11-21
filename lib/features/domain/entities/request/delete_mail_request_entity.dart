

import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';

class DeleteMailRequestEntity extends DeleteMailRequest{

    const DeleteMailRequestEntity({
        String? epicUserId,
        List<int>? inboxIdList,
    }):super(epicUserId: epicUserId,inboxIdList: inboxIdList);
}
