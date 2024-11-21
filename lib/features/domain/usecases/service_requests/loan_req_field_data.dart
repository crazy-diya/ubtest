import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_requests_field_data_request.dart';
import '../../../data/models/responses/loan_requests_field_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanRequestsFieldData
    extends UseCase<BaseResponse<LoanRequestFieldDataResponse>, LoanRequestsFieldDataRequest> {
  final Repository? repository;

  LoanRequestsFieldData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanRequestFieldDataResponse>>> call(
      LoanRequestsFieldDataRequest loanRequestsFieldDataRequest) async {
    return repository!.loanRequestsFieldData(loanRequestsFieldDataRequest);
  }
}
