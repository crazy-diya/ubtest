import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_requests_submit_request.dart';
import '../../../data/models/responses/loan_request_submit_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanRequestsSaveData
    extends UseCase<BaseResponse<LoanRequestsSubmitResponse>, LoanRequestsSubmitRequest> {
  final Repository? repository;

  LoanRequestsSaveData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanRequestsSubmitResponse>>> call(
      LoanRequestsSubmitRequest loanRequestsSubmitRequest) async {
    return repository!.loanReqSaveData(loanRequestsSubmitRequest);
  }
}
