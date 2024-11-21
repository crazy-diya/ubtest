import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/edit_ft_schedule_request.dart';
import '../../../data/models/responses/edit_ft_schedule_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class EditSchedulingFT extends UseCase<
    BaseResponse<EditFtScheduleResponse>,
    EditFtScheduleRequest> {
  final Repository? repository;

  EditSchedulingFT({this.repository});

  @override
  Future<Either<Failure, BaseResponse<EditFtScheduleResponse>>> call(
      EditFtScheduleRequest params) {
    return repository!.editFTSchedule(params);
  }
}
