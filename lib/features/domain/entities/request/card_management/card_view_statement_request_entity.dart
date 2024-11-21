import 'package:union_bank_mobile/features/data/models/requests/card_management/card_view_statement_request.dart';

class CardViewStatementRequestEntity extends CardViewStatementRequest {
  final String? maskedPrimaryCardNumber;
  final String? messageType;
  final String? billMonth;

  CardViewStatementRequestEntity({
    this.maskedPrimaryCardNumber,
    this.messageType,
    this.billMonth,
  }) : super(
          maskedPrimaryCardNumber: maskedPrimaryCardNumber,
          messageType: messageType,
          billMonth: billMonth,
        );
}
