
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/change_password_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ChangePassword extends UseCase<BaseResponse,
    ChangePasswordRequest> {
  final Repository? repository;

  ChangePassword({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ChangePasswordRequest changePasswordRequest) async {
    return repository!.changePassword(changePasswordRequest);
  }
}
