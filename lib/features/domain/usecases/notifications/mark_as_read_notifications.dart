import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../data/models/requests/mark_as_read_notification_request.dart';

class MarkAsReadNotification extends UseCase<BaseResponse, MarkAsReadNotificationRequest> {
  final Repository? repository;

  MarkAsReadNotification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(MarkAsReadNotificationRequest params) async {
    return repository!.markAsReadNotification(params);
  }
}