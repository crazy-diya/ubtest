import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class DeleteMailMessage extends UseCase<BaseResponse, DeleteMailMessageRequest> {
  final Repository? repository;

  DeleteMailMessage({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(DeleteMailMessageRequest params) async {
    return repository!.deleteMailMessage(params);
  }
}