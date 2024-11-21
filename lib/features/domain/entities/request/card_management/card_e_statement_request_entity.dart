import 'package:union_bank_mobile/features/data/models/requests/card_management/card_e_statement_request.dart';

class CardEStatementRequestEntity extends CardEStatementRequest {
  final String? maskedPrimaryCardNumber;
  final String? messageType;
  final String? isGreenStatement;

  CardEStatementRequestEntity({
    this.maskedPrimaryCardNumber,
    this.messageType,
    this.isGreenStatement,
  }) : super(
          maskedPrimaryCardNumber: maskedPrimaryCardNumber,
          messageType: messageType,
          isGreenStatement: isGreenStatement,
        );
}
