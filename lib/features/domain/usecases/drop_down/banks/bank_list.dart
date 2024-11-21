import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/get_bank_list_request.dart';
import '../../../../data/models/responses/get_bank_list_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetBankData extends UseCase<BaseResponse<GetBankListResponse>, GetBankListRequest> {
  final Repository? repository;

  GetBankData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetBankListResponse>>> call(GetBankListRequest params) async {
    return await repository!.getBankList(params);
  }
}
