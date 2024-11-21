import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/fd_calculator_request.dart';
import '../../../data/models/responses/fd_calculator_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FDCalculatorData extends UseCase<BaseResponse<FdCalculatorResponse>,
    FdCalculatorRequest> {
  final Repository? repository;

  FDCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FdCalculatorResponse>>> call(
      FdCalculatorRequest params) {
    return repository!.fdCalculatorList(params);
  }
}