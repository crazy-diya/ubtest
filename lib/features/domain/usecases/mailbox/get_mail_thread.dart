import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetMailThread extends UseCase<BaseResponse<MailThreadResponse>, MailThreadRequest> {
  final Repository? repository;

  GetMailThread({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MailThreadResponse>>> call(MailThreadRequest params) async {
    return repository!.getMailThread(params);
  }
}
