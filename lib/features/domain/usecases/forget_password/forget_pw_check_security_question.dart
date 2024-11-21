import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class ForgetPwCheckSecurityQuestion extends UseCase<
    BaseResponse<ForgetPasswordResponse>, ForgetPwCheckSecurityQuestionRequest> {
  final Repository? repository;

  ForgetPwCheckSecurityQuestion({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>> call(
      ForgetPwCheckSecurityQuestionRequest params) async {
    return repository!.forgetPwCheckSecurityQuestion(params);
  }
}