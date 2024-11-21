import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/intra_fund_transfer_request.dart';
import '../../../data/models/responses/intra_fund_transfer_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FundTransfer extends UseCase<BaseResponse<IntraFundTransferResponse>,
    IntraFundTransferRequest> {
  final Repository? repository;

  FundTransfer({this.repository});

  @override
  Future<Either<Failure, BaseResponse<IntraFundTransferResponse>>> call(
      IntraFundTransferRequest params) {
    return repository!.getIntraFundTransfer(params);
  }
}
