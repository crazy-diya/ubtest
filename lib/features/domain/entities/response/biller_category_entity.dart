import 'biller_entity.dart';

class BillerCategoryEntity {
  final int? categoryId;
  final String? categoryCode;
  final String? categoryName;
  final String? categoryDescription;
  final String? status;
  final String? logoUrl;
  final List<BillerEntity>? billers;

  BillerCategoryEntity(
      {this.categoryId,
      this.categoryName,
      this.billers,
      this.categoryCode,
      this.categoryDescription,
      this.status,
      this.logoUrl
      });
}
