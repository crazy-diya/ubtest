import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/fund_transfer_pdf_download_request.dart';
import '../../../data/models/responses/fund_transfer_pdf_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FundTransferPdfDownload extends UseCase<BaseResponse<FundTransferPdfDownloadResponse>,
    FundTransferPdfDownloadRequest> {
  final Repository? repository;

  FundTransferPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FundTransferPdfDownloadResponse>>> call(
      FundTransferPdfDownloadRequest params) {
    return repository!.fundTransferPdfDownload(params);
  }
}
