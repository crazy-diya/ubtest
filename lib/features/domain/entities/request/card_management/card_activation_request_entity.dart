import 'package:union_bank_mobile/features/data/models/requests/card_management/card_activation_request.dart';

class CardActivationRequestEntity extends CardActivationRequest {
  final String? maskedCardNumber;
  final String? messageType;

  CardActivationRequestEntity({
    this.maskedCardNumber,
    this.messageType,
  }) : super(
          maskedCardNumber: maskedCardNumber,
          messageType: messageType,
        );
}
