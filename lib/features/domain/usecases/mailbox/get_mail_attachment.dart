import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class GetMailAttcahment extends UseCase<BaseResponse<MailAttachmentResponse>, MailAttachmentRequest> {
  final Repository? repository;

  GetMailAttcahment({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MailAttachmentResponse>>> call(MailAttachmentRequest params) async {
    return repository!.getMailAttachment(params);
  }
}