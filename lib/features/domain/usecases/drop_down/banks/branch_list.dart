import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/get_branch_list_request.dart';
import '../../../../data/models/responses/get_branch_list_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetBranchData
    extends UseCase<BaseResponse<GetBranchListResponse>, GetBranchListRequest> {
  final Repository? repository;

  GetBranchData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetBranchListResponse>>> call(
      GetBranchListRequest params) async {
    return await repository!.getBranchList(params);
  }
}
