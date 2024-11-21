import 'package:union_bank_mobile/features/data/models/requests/card_management/card_details_request.dart';

class CardDetailsRequestEntity extends CardDetailsRequest {
  final String? maskedPrimaryCardNumber;
  final String? messageType;

  CardDetailsRequestEntity({
    this.maskedPrimaryCardNumber,
    this.messageType,
  }) : super(
          maskedPrimaryCardNumber: maskedPrimaryCardNumber,
          messageType: messageType,
        );
}
