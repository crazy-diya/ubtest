import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/promotion_notification_request.dart';
import '../../../data/models/responses/promotion_notification_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PromotionNotification extends UseCase<
    BaseResponse<PromotionNotificationResponse>, PromotionNotificationRequest> {
  final Repository? repository;

  PromotionNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PromotionNotificationResponse>>> call(
      PromotionNotificationRequest promotionNotificationRequest) async {
    return repository!.getPromoNotifications(promotionNotificationRequest);
  }
}
