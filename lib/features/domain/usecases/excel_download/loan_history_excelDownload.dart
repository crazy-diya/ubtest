import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_history_excel_request.dart';
import '../../../data/models/responses/loan_history_excel_download.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanHistoryExcelDownloadDownload extends UseCase<BaseResponse<LoanHistoryExcelResponse>, LoanHistoryExcelRequest> {
  final Repository? repository;

  LoanHistoryExcelDownloadDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryExcelResponse>>>
  call(LoanHistoryExcelRequest params) {
    return repository!.loanHistoryExcelDownload(params);
  }
}
