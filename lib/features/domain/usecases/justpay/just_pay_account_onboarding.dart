import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/just_pay_account_onboarding_request.dart';
import '../../../data/models/responses/just_pay_account_onboarding_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class JustPayAccountOnboarding extends UseCase<
    BaseResponse<JustPayAccountOnboardingResponse>,
    JustPayAccountOnboardingRequest> {
  final Repository? repository;

  JustPayAccountOnboarding({this.repository});

  @override
  Future<Either<Failure, BaseResponse<JustPayAccountOnboardingResponse>>> call(
      JustPayAccountOnboardingRequest params) async {
    return repository!.justPayAcoountOnboarding(params);
  }
}
