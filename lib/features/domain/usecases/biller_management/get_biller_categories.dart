// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/get_biller_category_list_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetBillerCategoryList extends UseCase<
    BaseResponse<GetBillerCategoryListResponse>, CommonRequestEntity> {
  final Repository? repository;

  GetBillerCategoryList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetBillerCategoryListResponse>>> call(
      CommonRequestEntity params) {
    return repository!.getBillerCategoryList(params);
  }
}
