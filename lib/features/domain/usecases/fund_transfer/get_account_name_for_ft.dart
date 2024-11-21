// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_account_name_ft_request.dart';
import '../../../data/models/responses/get_account_name_ft_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetAcctNameForFT extends UseCase<
    BaseResponse<GetAcctNameFtResponse>, GetAcctNameFtRequest> {
  final Repository? repository;

  GetAcctNameForFT({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetAcctNameFtResponse>>> call(
      GetAcctNameFtRequest params) {
    return repository!.acctNameForFt(params);
  }
}