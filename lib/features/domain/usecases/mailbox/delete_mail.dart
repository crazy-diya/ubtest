import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class DeleteMail extends UseCase<BaseResponse, DeleteMailRequest> {
  final Repository? repository;

  DeleteMail({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(DeleteMailRequest params) async {
    return repository!.deleteMail(params);
  }
}