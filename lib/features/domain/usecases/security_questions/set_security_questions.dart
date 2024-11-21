import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/set_security_questions_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SetSecurityQuestions
    extends UseCase<BaseResponse, SetSecurityQuestionsEntity> {
  final Repository? repository;

  SetSecurityQuestions({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      SetSecurityQuestionsEntity params) async {
    return repository!.setSecurityQuestions(params);
  }
}
