
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/apply_housing_loan_request.dart';
import '../../../data/models/responses/apply_housing_loan_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ApplyHousingLoanCalculatorData extends UseCase<BaseResponse<ApplyHousingLoanResponse>,
    ApplyHousingLoanRequest> {
  final Repository? repository;

  ApplyHousingLoanCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ApplyHousingLoanResponse>>> call(
      ApplyHousingLoanRequest params) {
    return repository!.applyHousingLoanList(params);
  }
}