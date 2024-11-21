import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_category_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_category_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class GetRecipientCategory extends UseCase<BaseResponse<RecipientCategoryResponse>, RecipientCategoryRequest> {
  final Repository? repository;

  GetRecipientCategory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RecipientCategoryResponse>>> call(RecipientCategoryRequest params) async {
    return repository!.getRecipientCategory(params);
  }
}