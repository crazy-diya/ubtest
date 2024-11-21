import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/settings_tran_limit_request.dart';
import '../../../data/models/responses/settings_tran_limit_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetTranLimits extends UseCase<
    BaseResponse<SettingsTranLimitResponse>, SettingsTranLimitRequest> {
  final Repository? repository;

  GetTranLimits({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SettingsTranLimitResponse>>> call(
      SettingsTranLimitRequest settingsTranLimitRequest) async {
    return repository!.settingsTranLimit(settingsTranLimitRequest);
  }
}
