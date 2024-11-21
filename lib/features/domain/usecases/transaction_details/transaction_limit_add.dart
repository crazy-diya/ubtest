import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_limit_add_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionLimitAdd extends UseCase<BaseResponse, TransactionLimitAddRequest> {
  final Repository? repository;

  TransactionLimitAdd({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      TransactionLimitAddRequest transactionLimitAddRequest) {
    return repository!.transactionLimitAdd(transactionLimitAddRequest);
  }
}
