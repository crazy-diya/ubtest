// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/update_notification_settings_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class UpdateNotificationSettings
    extends UseCase<BaseResponse, UpdateNotificationSettingsRequest> {
  final Repository? repository;

  UpdateNotificationSettings({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      UpdateNotificationSettingsRequest params) {
    return repository!.updateNotificationSettings(params);
  }
}
