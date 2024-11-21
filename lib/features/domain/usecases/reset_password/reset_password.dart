import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/reset_password_request.dart';
import '../../../data/models/responses/reset_password_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ResetPassword extends UseCase<
    BaseResponse<ResetPasswordResponse>, ResetPasswordRequest> {
  final Repository? repository;

  ResetPassword({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ResetPasswordResponse>>> call(
      ResetPasswordRequest resetPasswordRequest) async {
    return repository!.resetPassword(resetPasswordRequest);
  }
}
