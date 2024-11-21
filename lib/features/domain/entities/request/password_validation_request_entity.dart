
import 'package:union_bank_mobile/features/data/models/requests/password_validation_request.dart';

class PasswordValidationRequestEntity extends PasswordValidationRequest {
  PasswordValidationRequestEntity({
    String? password,
    String? messageType,
  }) : super(password: password, messageType: messageType);
}
