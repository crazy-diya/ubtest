

import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';

class ForgetPwResetRequestEntity extends ForgetPwResetRequest{

    ForgetPwResetRequestEntity({
        String? newPassword,
        String? confirmPassword,
        String? messageType,
        String? epicUserId,
        String? username
  }) : super(
            newPassword: newPassword,
            confirmPassword: confirmPassword,
            messageType:messageType,
            epicUserId: epicUserId,
            username:username);
}
