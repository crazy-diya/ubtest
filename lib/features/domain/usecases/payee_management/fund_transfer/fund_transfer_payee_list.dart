import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/fund_transfer_payee_list_request.dart';
import '../../../../data/models/responses/fund_transfer_payee_list_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class FundTransferPayeeList extends UseCase<
    BaseResponse<FundTransferPayeeListResponse>, FundTransferPayeeListRequest> {
  final Repository? repository;

  FundTransferPayeeList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FundTransferPayeeListResponse>>> call(
      FundTransferPayeeListRequest params) async {
    return repository!.fundTransferPayeeList(params);
  }
}
