import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/get_biller_list_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetSavedBillers extends UseCase<BaseResponse<GetSavedBillersResponse>,
    CommonRequestEntity> {
  final Repository? repository;

  GetSavedBillers({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetSavedBillersResponse>>> call(
      CommonRequestEntity params) {
    return repository!.getSavedBillerList(params);
  }
}
