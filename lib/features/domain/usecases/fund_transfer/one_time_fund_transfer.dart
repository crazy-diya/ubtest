import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/fund_transfer_one_time_request.dart';
import '../../../data/models/responses/fund_transfer_one_time_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class OneTimeFundTransfer extends UseCase<
    BaseResponse<OneTimeFundTransferResponse>, OneTimeFundTransferRequest> {
  final Repository? repository;

  OneTimeFundTransfer({this.repository});

  @override
  Future<Either<Failure, BaseResponse<OneTimeFundTransferResponse>>> call(
      OneTimeFundTransferRequest params) {
    return repository!.oneTimeFundTransfer(params);
  }
}
