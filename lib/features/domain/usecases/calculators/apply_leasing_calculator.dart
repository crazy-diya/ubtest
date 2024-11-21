
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/apply_leasing_request.dart';
import '../../../data/models/responses/apply_leasing_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ApplyLeasingCalculatorData extends UseCase<BaseResponse<ApplyLeasingCalculatorResponse>,
    ApplyLeasingCalculatorRequest> {
  final Repository? repository;

  ApplyLeasingCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ApplyLeasingCalculatorResponse>>> call(
      ApplyLeasingCalculatorRequest params) {
    return repository!.applyLeasingList(params);
  }
}