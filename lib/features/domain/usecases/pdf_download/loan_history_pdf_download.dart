import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_history_pdf_download.dart';
import '../../../data/models/responses/loan_history_pdf_download.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanHistoryPdfDownload extends UseCase<
    BaseResponse<LoanHistoryPdfResponse>,
    LoanHistoryPdfRequest> {
  final Repository? repository;

  LoanHistoryPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryPdfResponse>>>
  call(LoanHistoryPdfRequest params) {
    return repository!.loanHistoryPdfDownload(params);
  }
}
