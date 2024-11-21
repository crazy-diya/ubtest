
import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/sec_question_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetSecurityQuestions extends UseCase<BaseResponse, SecurityQuestionRequestEntity> {
  final Repository? repository;

  GetSecurityQuestions({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>> call(
      SecurityQuestionRequestEntity params) async {
    return repository!.getSecurityQuestions(params);
  }
}
