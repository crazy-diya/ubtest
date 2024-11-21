

import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';

class ForgetPwCheckNicAccountRequestEntity
    extends ForgetPwCheckNicAccountRequest {
  ForgetPwCheckNicAccountRequestEntity({
    String? accountNumber,
    String? identificationType,
    String? identificationNo,
    String? messageType,
  }) : super(
            accountNumber: accountNumber,
            identificationType: identificationType,
            identificationNo: identificationNo,
            messageType: messageType);
}
