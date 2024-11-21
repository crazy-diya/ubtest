import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/reply_mail_request.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ReplyMail extends UseCase<BaseResponse, ReplyMailRequest> {
  final Repository? repository;

  ReplyMail({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(ReplyMailRequest params) async {
    return repository!.replyMail(params);
  }
}
