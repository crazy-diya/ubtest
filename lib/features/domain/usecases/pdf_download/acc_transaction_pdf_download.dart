import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_tarnsaction_history_pdf_download_request.dart';
import '../../../data/models/responses/account_transaction_history_pdf_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountTransactionsPdfDownload extends UseCase<BaseResponse<AccountTransactionsPdfDownloadResponse>, AccountTransactionsPdfDownloadRequest> {
  final Repository? repository;

  AccountTransactionsPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionsPdfDownloadResponse>>>
  call(AccountTransactionsPdfDownloadRequest params) {
    return repository!.accTransactionsPdfDownload(params);
  }
}
