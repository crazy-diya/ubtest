import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/apply_personal_loan_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ApplyPersonalLoanCalculator extends UseCase<BaseResponse, ApplyPersonalLoanRequest> {
  final Repository? repository;

  ApplyPersonalLoanCalculator({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ApplyPersonalLoanRequest params) {
    return repository!.applyPersonalLoan(params);
  }
}
