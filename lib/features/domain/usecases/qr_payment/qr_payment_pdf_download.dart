import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/QRPaymentPdfDownloadRequest.dart';
import '../../../data/models/responses/QrPaymentPdfDownloadResponse.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class QRPaymentPdfDownload extends UseCase<BaseResponse<QrPaymentPdfDownloadResponse>, QrPaymentPdfDownloadRequest> {
  final Repository? repository;

  QRPaymentPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<QrPaymentPdfDownloadResponse>>>
  call(QrPaymentPdfDownloadRequest params) {
    return repository!.qrPaymentPdfDownload(params);
  }
}