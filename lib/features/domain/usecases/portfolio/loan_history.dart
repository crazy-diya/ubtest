import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_history_request.dart';
import '../../../data/models/responses/loan_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanHistory extends UseCase<
    BaseResponse<LoanHistoryresponse>,
    LoanHistoryrequest> {
  final Repository? repository;

  LoanHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryresponse>>> call(
      LoanHistoryrequest params) {
    return repository!.loanHistory(params);
  }
}
