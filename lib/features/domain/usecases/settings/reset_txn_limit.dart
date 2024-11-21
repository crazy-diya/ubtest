import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/txn_limit_reset_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ResetTxnLimit extends UseCase<
    BaseResponse<Serializable>,
    TxnLimitResetRequest> {
  final Repository? repository;

  ResetTxnLimit({this.repository});

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> call(
      TxnLimitResetRequest params) async {
    return repository!.txnLimitReset(params);
  }
}