import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_notification_settings_request.dart';
import '../../../data/models/responses/get_notification_settings_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetNotification extends UseCase<
    BaseResponse<GetNotificationSettingsResponse>,
    GetNotificationSettingsRequest> {
  final Repository? repository;

  GetNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetNotificationSettingsResponse>>> call(
      GetNotificationSettingsRequest params) async {
    return repository!.getNotificationSettings(params);
  }
}
