import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/sr_statement_request.dart';
import '../../../data/models/responses/sr_statement_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SrStatement extends UseCase<
    BaseResponse<SrStatementResponse>, SrStatementRequest> {
  final Repository? repository;

  SrStatement({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SrStatementResponse>>> call(
      SrStatementRequest srStatementRequest) async {
    return repository!.srStatement(srStatementRequest);
  }
}
