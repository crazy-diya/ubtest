import 'package:union_bank_mobile/features/presentation/views/credit_card_management/credit_card_payment/data/credit_card_entity.dart';

import '../../../../../../utils/enums.dart';
import '../../../../../domain/entities/response/fund_transfer_entity.dart';
import '../../widgets/credit_card_details_card.dart';

class CreditCardPaymentArgs {
  CreditCardPaymentType creditCardPaymentType;
  List<CreditCardDetailsCard> itemList;
  String? amount;
  CreditCardEntity? payTo;
  FundTransferEntity? payFrom;
  String? remark;
  String? bankCode;
  double? serviceCharge;

  CreditCardPaymentArgs({
    required this.creditCardPaymentType,
    required this.itemList,
    this.amount,
    this.payTo,
    this.payFrom,
    this.remark,
    this.bankCode,
    this.serviceCharge,
  });
}
