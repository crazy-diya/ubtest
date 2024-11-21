import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TemporaryLogin
    extends UseCase<BaseResponse<TemporaryLoginResponse>, TemporaryLoginRequest> {
  final Repository? repository;

  TemporaryLogin({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TemporaryLoginResponse>>> call(
      TemporaryLoginRequest temporaryLoginRequest) async {
    return repository!.temporaryLogin(temporaryLoginRequest);
  }
}
