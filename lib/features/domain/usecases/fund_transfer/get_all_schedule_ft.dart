
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_all_schedule_fund_transfer_request.dart';
import '../../../data/models/responses/get_all_sheduke_ft_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetAllScheduleFT extends UseCase<BaseResponse<GetAllScheduleFtResponse>,
    GetAllScheduleFtRequest> {
  final Repository? repository;

  GetAllScheduleFT({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetAllScheduleFtResponse>>> call(
      GetAllScheduleFtRequest params) {
    return repository!.getAllScheduleFT(params);
  }
}
