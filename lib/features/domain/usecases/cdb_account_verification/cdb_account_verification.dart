import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/cdb_account_verfication_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CDBAccountVerification
    extends UseCase<BaseResponse, CdbAccountVerificationRequest> {
  final Repository? repository;

  CDBAccountVerification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      CdbAccountVerificationRequest params) {
    return repository!.cdbAccountVerification(params);
  }
}
