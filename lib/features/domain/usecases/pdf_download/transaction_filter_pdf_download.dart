import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_filter_pdf_download.dart';
import '../../../data/models/responses/transaction_filter_pdf_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';




class TransactionFilterPdfDownload extends UseCase<BaseResponse<TransactionFilteredPdfDownloadResponse>, TransactionFilteredPdfDownloadRequest> {
  final Repository? repository;

  TransactionFilterPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionFilteredPdfDownloadResponse>>>
  call(TransactionFilteredPdfDownloadRequest params) {
    return repository!.transactionFilterPdfDownload(params);
  }
}
