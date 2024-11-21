import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/notification_count_request.dart';
import '../../../data/models/responses/notification_count_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CountNotification extends UseCase<BaseResponse<NotificationCountResponse>, NotificationCountRequest> {
  final Repository? repository;

  CountNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<NotificationCountResponse>>> call(
      NotificationCountRequest params) {
    return repository!.notificationCount(params);
  }
}
