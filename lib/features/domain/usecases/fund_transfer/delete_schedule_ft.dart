import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/delete_ft_schedule_request.dart';
import '../../../data/models/responses/delete_ft_schedule_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DeleteSchedulingFT extends UseCase<
    BaseResponse<DeleteFtScheduleResponse>,
    DeleteFtScheduleRequest> {
  final Repository? repository;

  DeleteSchedulingFT({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DeleteFtScheduleResponse>>> call(
      DeleteFtScheduleRequest params) {
    return repository!.deleteFTScedule(params);
  }
}
