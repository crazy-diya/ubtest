import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/personal_loan_request.dart';
import '../../../data/models/responses/personal_loan_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PersonalLoanCalculator extends UseCase<BaseResponse<PersonalLoanResponse>,
    PersonalLoanRequest> {
  final Repository? repository;

  PersonalLoanCalculator({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PersonalLoanResponse>>> call(
      PersonalLoanRequest params) {
    return repository!.personalLoanCalculator(params);
  }
}
