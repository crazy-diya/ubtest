import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/getTxnCategoryList_request.dart';
import '../../../data/models/responses/getTxnCategoryList_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetTxnCategoryList extends UseCase<BaseResponse<GetTxnCategoryResponse>,
    GetTxnCategoryRequest> {
  final Repository? repository;

  GetTxnCategoryList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetTxnCategoryResponse>>> call(
      GetTxnCategoryRequest params) {
    return repository!.getTxnCategoryList(params);
  }
}