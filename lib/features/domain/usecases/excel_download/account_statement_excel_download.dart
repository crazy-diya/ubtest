import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_statements_excel_request.dart';
import '../../../data/models/responses/account_statesment_xcel_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountSatementsXcelDownload extends UseCase<
    BaseResponse<AccountSatementsXcelDownloadResponse>,
    AccountSatementsXcelDownloadRequest> {
  final Repository? repository;

  AccountSatementsXcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountSatementsXcelDownloadResponse>>>
  call(AccountSatementsXcelDownloadRequest params) {
    return repository!.accStatementsXcelDownload(params);
  }
}
