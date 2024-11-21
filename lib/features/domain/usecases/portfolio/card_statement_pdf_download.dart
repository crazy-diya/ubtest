import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/card_management/card_statement_pdf_download_request.dart';
import '../../../data/models/responses/card_management/card_statement_pdf_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CardStatementPDFDownload extends UseCase<
    BaseResponse<CardStatementPdfResponse>,
    CardStateentPdfDownloadRequest> {
  final Repository? repository;

  CardStatementPDFDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardStatementPdfResponse>>> call(
      CardStateentPdfDownloadRequest params) {
    return repository!.cardStatementPdfDownload(params);
  }
}