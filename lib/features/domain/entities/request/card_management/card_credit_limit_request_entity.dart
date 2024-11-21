

import 'package:union_bank_mobile/features/data/models/requests/card_management/card_credit_limit_request.dart';

class CardCreditLimitRequestEntity extends CardCreditLimitRequest {
  final String? maskedAddonCardNumber;
  final String? messageType;
  final String? addonCrLimitPerc;
  final String? addonCashLimitPerc;

  CardCreditLimitRequestEntity({
    this.maskedAddonCardNumber,
    this.messageType,
    this.addonCrLimitPerc,
    this.addonCashLimitPerc,
  }) : super(
          addonCashLimitPerc: addonCashLimitPerc,
          maskedAddonCardNumber: maskedAddonCardNumber,
          messageType: messageType,
          addonCrLimitPerc: addonCrLimitPerc,
        );

}
