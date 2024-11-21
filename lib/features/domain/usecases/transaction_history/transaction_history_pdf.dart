
import '../../../data/models/requests/transaction_history_pdf_download_request.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/transaction_history_pdf_download_respose.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionHistoryPdfDownload
    extends UseCase<BaseResponse<TransactionHistoryPdfDownloadResponse>, TransactionHistoryPdfDownloadRequest> {
  final Repository? repository;

  TransactionHistoryPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionHistoryPdfDownloadResponse>>> call(
      TransactionHistoryPdfDownloadRequest params) {
    return repository!.transactionHistoryPdfDownload(params);
  }
}
