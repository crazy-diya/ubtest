import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/fund_transfer_excel_dwnload_request.dart';
import '../../../data/models/responses/fund_transfer_excel_dwnload_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FundTransferExcelDownload extends UseCase<BaseResponse<FundTransferExcelDownloadResponse>,
    FundTransferExcelDownloadRequest> {
  final Repository? repository;

  FundTransferExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FundTransferExcelDownloadResponse>>> call(
      FundTransferExcelDownloadRequest params) {
    return repository!.fundTransferExcelDownload(params);
  }
}
