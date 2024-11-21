import 'package:union_bank_mobile/features/data/models/requests/card_management/card_pin_request.dart';

class CardPinRequestEntity extends CardPinRequest {
  final String? maskedCardNumber;
  final String? messageType;
  final String? pinChangeReason;

  CardPinRequestEntity({
    this.maskedCardNumber,
    this.messageType,
    this.pinChangeReason,
  }) : super(
          maskedCardNumber: maskedCardNumber,
          messageType: messageType,
          pinChangeReason: pinChangeReason,
        );
}
