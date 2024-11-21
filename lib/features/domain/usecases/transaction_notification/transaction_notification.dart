import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/responses/transaction_notification_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_notification_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionNotification extends UseCase<
    BaseResponse<TransactionNotificationResponse>,
    TransactionNotificationRequest> {
  final Repository? repository;

  TransactionNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionNotificationResponse>>> call(
      TransactionNotificationRequest transactionNotificationRequest) async {
    return repository!.getTranNotifications(transactionNotificationRequest);
  }
}
