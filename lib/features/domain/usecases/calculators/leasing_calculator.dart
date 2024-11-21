import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/leasing_calculator_request.dart';
import '../../../data/models/responses/leasing_calculator_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LeasingCalculatorData extends UseCase<BaseResponse<LeasingCalculatorResponse>,
    LeasingCalculatorRequest> {
  final Repository? repository;

  LeasingCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeasingCalculatorResponse>>> call(
      LeasingCalculatorRequest params) {
    return repository!.leasingCalculatorList(params);
  }
}