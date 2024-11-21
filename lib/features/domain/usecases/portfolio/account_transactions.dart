import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_transaction_history_request.dart';
import '../../../data/models/responses/account_transaction_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountTransactions extends UseCase<
    BaseResponse<AccountTransactionHistoryresponse>,
    AccountTransactionHistorysrequest> {
  final Repository? repository;

  AccountTransactions({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionHistoryresponse>>> call(
      AccountTransactionHistorysrequest params) {
    return repository!.accountTransactions(params);
  }
}
