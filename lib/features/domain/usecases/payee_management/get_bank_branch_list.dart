import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/getBranchListRequest.dart';
import '../../../data/models/responses/getBranchListResponse.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetBankBranchList extends UseCase<BaseResponse<GetBankBranchListResponse>,
    GetBankBranchListRequest> {
  final Repository? repository;

  GetBankBranchList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetBankBranchListResponse>>> call(
      GetBankBranchListRequest params) {
    return repository!.getBankBranchList(params);
  }
}