import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/ub_account_verfication_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class UBAccountVerification
    extends UseCase<BaseResponse, UBAccountVerificationRequest> {
  final Repository? repository;

  UBAccountVerification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      UBAccountVerificationRequest params) {
    return repository!.ubAccountVerification(params);
  }
}
