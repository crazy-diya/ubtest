

import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';

class MailThreadRequestEntity extends MailThreadRequest{

    const MailThreadRequestEntity({
        String? epicUserId,
        int? inboxId,
        bool? isComposeDraft
    }):super(epicUserId: epicUserId,inboxId: inboxId,isComposeDraft: isComposeDraft);

}
