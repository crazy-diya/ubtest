import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/create_user_response.dart';
import '../../entities/request/create_user_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CreateUser
    extends UseCase<BaseResponse<CreateUserResponse>, CreateUserEntity> {
  final Repository? repository;

  CreateUser({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CreateUserResponse>>> call(
      CreateUserEntity params) {
    return repository!.createUser(params);
  }
}
