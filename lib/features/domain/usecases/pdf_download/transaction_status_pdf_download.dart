import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transaction_pdf_download.dart';
import '../../../data/models/responses/transaction_pdf_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionStatusPdfDownload extends UseCase<BaseResponse<TransactionStatusPdfResponse>, TransactionStatusPdfRequest> {
  final Repository? repository;

  TransactionStatusPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionStatusPdfResponse>>>
  call(TransactionStatusPdfRequest params) {
    return repository!.transactionStatusPdfDownload(params);
  }
}
