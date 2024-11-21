import 'biller_category_entity.dart';
import 'biller_entity.dart';
import 'charee_code_entity.dart';
import 'custom_field_entity.dart';

class SavedBillerEntity {
  final int? id;
  final String? userId;
  final String? referenceNumber;
  final BillerCategoryEntity? billerCategory;
  final BillerEntity? serviceProvider;
  final ChargeCodeEntity? chargeCodeEntity;
  String? nickName;
  final List<CustomFieldEntity>? customFieldEntityList;
  bool? isFavorite;
  //TODO: Remove mobile Number
  late String? mobileNumber;
  bool isSelected;
  String? value;

  SavedBillerEntity({
    this.id,
    this.userId,
    this.chargeCodeEntity,
    this.referenceNumber,
    this.billerCategory,
    this.serviceProvider,
    this.nickName,
    this.customFieldEntityList,
    this.mobileNumber,
    this.isFavorite,
    this.isSelected = false,
    this.value,
  });
}
