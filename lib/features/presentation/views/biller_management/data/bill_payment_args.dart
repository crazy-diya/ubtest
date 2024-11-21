import '../../../../domain/entities/response/account_entity.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../../domain/entities/response/custom_field_entity.dart';

class BillPaymentArgs {
  final BillerCategoryEntity? billerCategoryEntity;
  final BillerEntity? billerEntity;
  final int? amount;
  final String? remark;
  final String? accNumber;
  final AccountEntity? accountEntity;
  final List<CustomFieldEntity>? customFields;
  final double? serviceChange;

  BillPaymentArgs(
      {this.billerCategoryEntity,
      this.accNumber,
      this.accountEntity,
      this.amount,
      this.remark,
      this.billerEntity,
      this.customFields,
        this.serviceChange
      });
}
