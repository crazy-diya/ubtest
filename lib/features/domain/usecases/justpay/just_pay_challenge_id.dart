import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/just_pay_challenge_id_request.dart';
import '../../../data/models/responses/just_pay_challenge_id_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class JustPayChallengeId extends UseCase<
    BaseResponse<JustPayChallengeIdResponse>,
    JustPayChallengeIdRequest> {
  final Repository? repository;

  JustPayChallengeId({this.repository});

  @override
  Future<Either<Failure, BaseResponse<JustPayChallengeIdResponse>>> call(
      JustPayChallengeIdRequest justPayChallengeIdRequest) async {
    return repository!.justPayChallengeId(justPayChallengeIdRequest);
  }
}
