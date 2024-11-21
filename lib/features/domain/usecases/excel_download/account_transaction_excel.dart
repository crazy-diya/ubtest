import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_tran_excel_request.dart';
import '../../../data/models/responses/account_tran_excel_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountTransactionExcelDownload extends UseCase<BaseResponse<AccountTransactionExcelResponse>, AccountTransactionExcelRequest> {
  final Repository? repository;

  AccountTransactionExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionExcelResponse>>>
  call(AccountTransactionExcelRequest params) {
    return repository!.accTransactionExcelDownload(params);
  }
}
