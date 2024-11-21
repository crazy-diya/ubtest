import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/req_money_notification_history_request.dart';
import '../../../data/models/responses/req_money_notification_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ReqMoneyNotificationStatus extends UseCase<BaseResponse<ReqMoneyNotificationHistoryResponse>, ReqMoneyNotificationHistoryRequest> {
  final Repository? repository;

  ReqMoneyNotificationStatus({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ReqMoneyNotificationHistoryResponse>>> call(
      ReqMoneyNotificationHistoryRequest params) {
    return repository!.reqMoneyNotificationHistory(params);
  }
}
