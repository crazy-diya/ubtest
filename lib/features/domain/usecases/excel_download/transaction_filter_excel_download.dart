import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_filtered_exce_download_request.dart';
import '../../../data/models/responses/transaction_filtered_excel_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';




class TransactionFilterExcelDownload extends UseCase<BaseResponse<TransactionFilteredExcelDownloadResponse>, TransactionFilteredExcelDownloadRequest> {
  final Repository? repository;

  TransactionFilterExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionFilteredExcelDownloadResponse>>>
  call(TransactionFilteredExcelDownloadRequest params) {
    return repository!.transactionFilterExcelDownload(params);
  }
}
