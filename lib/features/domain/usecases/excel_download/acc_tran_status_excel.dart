import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/acc_tran_status_excel.dart';
import '../../../data/models/responses/acc_tran_status_excel.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountTranStatusExcelDownload extends UseCase<BaseResponse<AccTranStatusExcelDownloadResponse>, AccTranStatusExcelDownloadRequest> {
  final Repository? repository;

  AccountTranStatusExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccTranStatusExcelDownloadResponse>>>
  call(AccTranStatusExcelDownloadRequest params) {
    return repository!.accTranStatusExcelDownload(params);
  }
}
