import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_fd_period_req.dart';
import '../../../data/models/responses/get_fd_period_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetFDPeriod extends UseCase<BaseResponse<GetFdPeriodResponse>,
    GetFdPeriodRequest> {
  final Repository? repository;

  GetFDPeriod({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetFdPeriodResponse>>> call(
      GetFdPeriodRequest params) {
    return repository!.getFDPeriodList(params);
  }
}