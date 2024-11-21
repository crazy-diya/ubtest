import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_limit_request.dart';
import '../../../data/models/responses/transaction_limit_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionLimit extends UseCase<BaseResponse<TransactionLimitResponse>,
    TransactionLimitRequest> {
  final Repository? repository;

  TransactionLimit({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionLimitResponse>>> call(
      TransactionLimitRequest TransactionLimitRequest) async {
    return repository!.transactionLimit(TransactionLimitRequest);
  }
}
