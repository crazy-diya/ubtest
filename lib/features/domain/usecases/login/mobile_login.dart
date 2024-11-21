import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/mobile_login_request.dart';
import '../../../data/models/responses/mobile_login_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class MobileLogin
    extends UseCase<BaseResponse<MobileLoginResponse>, MobileLoginRequest> {
  final Repository? repository;

  MobileLogin({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> call(
      MobileLoginRequest mobileLoginRequest) async {
    return repository!.mobileLogin(mobileLoginRequest);
  }
}
