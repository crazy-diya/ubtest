import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/delete_fund_transfer_payee_request.dart';
import '../../../../data/models/responses/delete_fund_transfer_payee_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class DeleteFundTransferPayee
    extends UseCase<BaseResponse<DeleteFundTransferPayeeResponse>, DeleteFundTransferPayeeRequest> {
  final Repository? repository;

  DeleteFundTransferPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DeleteFundTransferPayeeResponse>>> call(DeleteFundTransferPayeeRequest params) {
    return repository!.deleteFundTransferPayee(params);
  }
}
