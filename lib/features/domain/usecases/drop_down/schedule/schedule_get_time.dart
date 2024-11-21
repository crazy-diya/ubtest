
import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/get_schedule_time_request.dart';
import '../../../../data/models/responses/get_schedule_time_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetScheduleTime extends UseCase<BaseResponse<GetScheduleTimeResponse>,
    GetScheduleTimeRequest> {
  final Repository? repository;

  GetScheduleTime({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>> call(
      GetScheduleTimeRequest params) async {
    return await repository!.getScheduleTimeSlot(params);
  }
}
