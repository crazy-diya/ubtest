import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_money_notification_request.dart';
import '../../../data/models/responses/get_money_notification_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class MoneyRequestNotification extends UseCase<BaseResponse<GetMoneyNotificationResponse>, GetMoneyNotificationRequest> {
  final Repository? repository;

  MoneyRequestNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetMoneyNotificationResponse>>> call(
      GetMoneyNotificationRequest params) {
    return repository!.getMoneyNotification(params);
  }
}
