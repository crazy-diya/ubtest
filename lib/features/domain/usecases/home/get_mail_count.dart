

import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class GetMailCount extends UseCase<
    BaseResponse<MailCountResponse>, MailCountRequest> {
  final Repository? repository;

  GetMailCount({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MailCountResponse>>> call(
      MailCountRequest params) async {
    return repository!.getMailCount(params);
  }
}