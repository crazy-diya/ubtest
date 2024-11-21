import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class DeleteMailAttcahment extends UseCase<BaseResponse, MailAttachmentRequest> {
  final Repository? repository;

  DeleteMailAttcahment({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(MailAttachmentRequest params) async {
    return repository!.deleteMailAttachment(params);
  }
}