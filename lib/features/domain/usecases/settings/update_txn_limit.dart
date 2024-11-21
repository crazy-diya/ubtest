import 'package:fpdart/fpdart.dart';
import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/settings_update_txn_limit_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class UpdateTXNLimit extends UseCase<BaseResponse, UpdateTxnLimitRequest> {
  final Repository? repository;

  UpdateTXNLimit({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(UpdateTxnLimitRequest params) async {
    return repository!.updateTxnLimit(params);
  }
}
