import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_fd_rate_request.dart';
import '../../../data/models/responses/get_fd_rate_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetFDRate extends UseCase<BaseResponse<GetFdRateResponse>,
    GetFdRateRequest> {
  final Repository? repository;

  GetFDRate({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetFdRateResponse>>> call(
      GetFdRateRequest params) {
    return repository!.getFDRate(params);
  }
}