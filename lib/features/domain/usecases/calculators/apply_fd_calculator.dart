
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/apply_fd_calculator_request.dart';
import '../../../data/models/responses/apply_fd_calculator_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ApplyFDCalculatorData extends UseCase<BaseResponse<ApplyFdCalculatorResponse>,
    ApplyFdCalculatorRequest> {
  final Repository? repository;

  ApplyFDCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ApplyFdCalculatorResponse>>> call(
      ApplyFdCalculatorRequest params) {
    return repository!.applyFDCalculatorList(params);
  }
}