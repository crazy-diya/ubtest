import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/password_validation_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/password_validation_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class PasswordValidation
    extends UseCase<BaseResponse<PasswordValidationResponse>,
    PasswordValidationRequest> {
  final Repository? repository;

  PasswordValidation({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PasswordValidationResponse>>> call(
      PasswordValidationRequest params) async {
    return await repository!.passwordValidation(params);
  }
}