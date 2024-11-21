import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../data/models/requests/delete_notification_request.dart';

class DeleteNotifications extends UseCase<BaseResponse, DeleteNotificationRequest> {
  final Repository? repository;

  DeleteNotifications({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(DeleteNotificationRequest params) async {
    return repository!.deleteNotification(params);
  }
}