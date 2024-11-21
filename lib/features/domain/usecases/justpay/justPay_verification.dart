import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/just_pay_verfication_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class JustPayVerification
    extends UseCase<BaseResponse, JustPayVerificationRequest> {
  final Repository? repository;

  JustPayVerification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      JustPayVerificationRequest params) {
    return repository!.justPayVerification(params);
  }
}
