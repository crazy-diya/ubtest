import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/fund_transfer_scheduling_request.dart';
import '../../../data/models/responses/fund_transfer_scheduling_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SchedulingFundTransfer extends UseCase<
    BaseResponse<SchedulingFundTransferResponse>,
    SchedulingFundTransferRequest> {
  final Repository? repository;

  SchedulingFundTransfer({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SchedulingFundTransferResponse>>> call(
      SchedulingFundTransferRequest params) {
    return repository!.schedulingFundTransfer(params);
  }
}
