import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ForgetPwCheckNicAccount extends UseCase<
    BaseResponse<ForgetPasswordResponse>, ForgetPwCheckNicAccountRequest> {
  final Repository? repository;

  ForgetPwCheckNicAccount({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>> call(
      ForgetPwCheckNicAccountRequest params) async {
    return repository!.forgetPwCheckNicAccount(params);
  }
}
