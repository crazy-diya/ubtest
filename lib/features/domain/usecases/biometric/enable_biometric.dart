import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/biometric_enable_request.dart';
import '../../../data/models/responses/biometric_enable_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class EnableBiometric extends UseCase<BaseResponse<BiometricEnableResponse>, BiometricEnableRequest> {
  final Repository? repository;

  EnableBiometric({this.repository});

  @override
  Future<Either<Failure, BaseResponse<BiometricEnableResponse>>> call(BiometricEnableRequest params) {
    return repository!.enableBiometric(params);
  }
}
