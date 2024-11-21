// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_all_fund_transfer_schedule_request.dart';
import '../../../data/models/responses/get_all_fund_transfer_schedule_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetAllFTSchedule extends UseCase<
    BaseResponse<GetAllFundTransferScheduleResponse>, GetAllFundTransferScheduleRequest> {
  final Repository? repository;

  GetAllFTSchedule({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetAllFundTransferScheduleResponse>>> call(
      GetAllFundTransferScheduleRequest params) {
    return repository!.getAllFTScheduleList(params);
  }
}