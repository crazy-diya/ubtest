import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_statement_pdf_download.dart';
import '../../../data/models/responses/account_statement_pdf_download.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountStatementsPdfDownload extends UseCase<BaseResponse<AccountStatementPdfDownloadResponse>, AccountStatementPdfDownloadRequest> {
  final Repository? repository;

  AccountStatementsPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountStatementPdfDownloadResponse>>>
      call(AccountStatementPdfDownloadRequest params) {
    return repository!.accStatementsPdfDownload(params);
  }
}
