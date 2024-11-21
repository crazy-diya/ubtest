import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_statements_request.dart';
import '../../../data/models/responses/account_statements_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountStatements extends UseCase<
    BaseResponse<AccountStatementsresponse>, AccountStatementsrequest> {
  final Repository? repository;

  AccountStatements({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountStatementsresponse>>> call(
      AccountStatementsrequest params) {
    return repository!.accountStatements(params);
  }
}
