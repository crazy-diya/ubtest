import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/sr_statement_history_request.dart';
import '../../../data/models/responses/sr_statement_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SrStatementHistory extends UseCase<
    BaseResponse<SrStatementHistoryResponse>, SrStatementHistoryRequest> {
  final Repository? repository;

  SrStatementHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SrStatementHistoryResponse>>> call(
      SrStatementHistoryRequest srStatementHistoryRequest) async {
    return repository!.statementHistory(srStatementHistoryRequest);
  }
}
