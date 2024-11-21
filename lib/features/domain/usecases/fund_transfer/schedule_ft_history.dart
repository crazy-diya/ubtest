import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/schedule_ft_history_request.dart';
import '../../../data/models/responses/schedule_ft_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SchedulingFTHistory extends UseCase<
    BaseResponse<ScheduleFtHistoryResponse>,
    ScheduleFtHistoryReq> {
  final Repository? repository;

  SchedulingFTHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ScheduleFtHistoryResponse>>> call(
      ScheduleFtHistoryReq params) {
    return repository!.scheduleFTHistory(params);
  }
}
