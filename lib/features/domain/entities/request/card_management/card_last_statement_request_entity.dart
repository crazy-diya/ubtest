import 'package:union_bank_mobile/features/data/models/requests/card_management/card_last_statement_request.dart';

class CardLastStatementRequestEntity extends CardLastStatementRequest {
  final String? maskedPrimaryCardNumber;
  final String? messageType;

  CardLastStatementRequestEntity({
    this.maskedPrimaryCardNumber,
    this.messageType,
  }) : super(
          maskedPrimaryCardNumber: maskedPrimaryCardNumber,
          messageType: messageType,
        );
}
