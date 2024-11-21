// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_verfication_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountVerification
    extends UseCase<BaseResponse, AccountVerificationRequest> {
  final Repository? repository;

  AccountVerification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      AccountVerificationRequest params) {
    return repository!.accountVerification(params);
  }
}
