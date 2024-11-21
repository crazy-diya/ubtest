import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../../domain/entities/response/custom_field_entity.dart';

class AddBillerArgs {
  final BillerCategoryEntity? billerCategoryEntity;
  final BillerEntity? billerEntity;
  final String? nickName;
  //final String? accNumber;
  final String? mobileNumber;
  final String? billerName;
  final bool? isFavorite;
  final List<CustomFieldEntity>? customFields;
  String routeType;

  AddBillerArgs({
    this.billerCategoryEntity,
    this.billerEntity,
    this.nickName,
    //this.accNumber,
    this.customFields,
    this.mobileNumber,
    this.billerName,
    this.isFavorite,
    required this.routeType
  });
}
