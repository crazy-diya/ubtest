import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class MarkAsReadMail extends UseCase<BaseResponse, MarkAsReadMailRequest> {
  final Repository? repository;

  MarkAsReadMail({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(MarkAsReadMailRequest params) async {
    return repository!.markAsReadMail(params);
  }
}