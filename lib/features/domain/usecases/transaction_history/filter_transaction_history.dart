import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';


import '../../../data/models/requests/transaction_filter_request.dart';

import '../../../data/models/responses/transaction_filter_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionHistoryFilter extends UseCase<
    BaseResponse<TransactionFilterResponse>,
    TransactionFilterRequest> {
  final Repository? repository;

  TransactionHistoryFilter({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionFilterResponse>>> call(
      TransactionFilterRequest params) {
    return repository!.transactionFilter(params);
  }
}
