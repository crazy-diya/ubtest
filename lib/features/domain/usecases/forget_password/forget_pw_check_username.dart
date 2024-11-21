import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ForgetPwCheckUsername extends UseCase<
    BaseResponse<ForgetPasswordResponse>, ForgetPwCheckUsernameRequest> {
  final Repository? repository;

  ForgetPwCheckUsername({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>> call(
      ForgetPwCheckUsernameRequest params) async {
    return repository!.forgetPwCheckUsername(params);
  }
}
