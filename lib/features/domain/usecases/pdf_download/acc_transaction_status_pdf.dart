import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/acc_tran_status_pdf.dart';
import '../../../data/models/responses/acc_tran_status_pdf.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountTransactionStatusPdfDownload extends UseCase<BaseResponse<AccTranStatusPdfDownloadResponse>, AccTranStatusPdfDownloadRequest> {
  final Repository? repository;

  AccountTransactionStatusPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccTranStatusPdfDownloadResponse>>>
  call(AccTranStatusPdfDownloadRequest params) {
    return repository!.accTransactionsStatusPdfDownload(params);
  }
}
