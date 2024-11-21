
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';

class ForgetPwCheckUsernameRequestEntity extends ForgetPwCheckUsernameRequest{

    ForgetPwCheckUsernameRequestEntity({
        String? username,
        String? identificationType,
        String? identificationNo,
        String? messageType,
    }) : super(
            username: username,
            identificationType: identificationType,
            identificationNo: identificationNo,
            messageType:messageType);
}
