import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/past_card_statement_request.dart';
import '../../../data/models/responses/past_card_statement_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PastCardStatesments extends UseCase<
    BaseResponse<PastCardStatementsresponse>,
    PastCardStatementsrequest> {
  final Repository? repository;

  PastCardStatesments({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PastCardStatementsresponse>>> call(
      PastCardStatementsrequest params) {
    return repository!.pastCardStatements(params);
  }
}
