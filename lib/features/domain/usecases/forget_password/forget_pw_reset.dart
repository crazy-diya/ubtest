import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class ForgetPwReset extends UseCase<
    BaseResponse, ForgetPwResetRequest> {
  final Repository? repository;

  ForgetPwReset({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ForgetPwResetRequest params) async {
    return repository!.forgetPwReset(params);
  }
}