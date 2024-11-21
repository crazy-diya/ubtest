import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/check_user_request.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CheckUser
    extends UseCase<BaseResponse, CheckUserRequest> {
  final Repository? repository;

  CheckUser({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      CheckUserRequest params) {
    return repository!.checkUser(params);
  }
}
