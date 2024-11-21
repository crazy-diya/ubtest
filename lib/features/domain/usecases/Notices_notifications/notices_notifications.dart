import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/notices_notification_request.dart';
import '../../../data/models/responses/notices_notification_list.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class NoticesNotification extends UseCase<
    BaseResponse<NoticesNotificationResponse>, NoticesNotificationRequest> {
  final Repository? repository;

  NoticesNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<NoticesNotificationResponse>>> call(
      NoticesNotificationRequest noticesNotificationRequest) async {
    return repository!.getNoticesNotifications(noticesNotificationRequest);
  }
}
