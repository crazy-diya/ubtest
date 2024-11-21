// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/biller_pdf_download_request.dart';
import '../../../data/models/responses/biller_pdf_download_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class BillerPdfDownload extends UseCase<BaseResponse<BillerPdfDownloadResponse>,
    BillerPdfDownloadRequest> {
  final Repository? repository;

  BillerPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<BillerPdfDownloadResponse>>> call(
      BillerPdfDownloadRequest params) async {
    return await repository!.billerPdfDownload(params);
  }
}
