// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:union_bank_mobile/features/domain/entities/response/saved_payee_entity.dart';

class SavedPayeeWithList {
  SavedPayeeEntity? savedPayeeEntity;
  List<SavedPayeeEntity>? savedPayeeEntities;
  SavedPayeeWithList({
    this.savedPayeeEntity,
    this.savedPayeeEntities,
  });
}
