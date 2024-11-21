import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/biometric_login_request.dart';
import '../../../data/models/responses/mobile_login_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class BiometricLogin
    extends UseCase<BaseResponse<MobileLoginResponse>, BiometricLoginRequest> {
  final Repository? repository;

  BiometricLogin({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> call(
      BiometricLoginRequest params) {
    return repository!.biometricLogin(params);
  }
}
