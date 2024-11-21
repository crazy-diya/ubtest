import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/past_card_statements_pdf_download_request.dart';
import '../../../data/models/responses/past_card_statements_pdf_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PastCardStatemntsPdfDownload extends UseCase<
    BaseResponse<PastcardStatementstPdfDownloadResponse>,
    PastcardStatementstPdfDownloadRequest> {
  final Repository? repository;

  PastCardStatemntsPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PastcardStatementstPdfDownloadResponse>>>
      call(PastcardStatementstPdfDownloadRequest params) {
    return repository!.pastCardStatementsPdfDownload(params);
  }
}
