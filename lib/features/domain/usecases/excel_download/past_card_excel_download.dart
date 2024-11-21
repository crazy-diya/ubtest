import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/past_card_excel_download.dart';
import '../../../data/models/responses/past_card_excel_download.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PastCardExcelDownload extends UseCase<
    BaseResponse<PastCardExcelDownloadResponse>,
    PastCardExcelDownloadRequest> {
  final Repository? repository;

  PastCardExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PastCardExcelDownloadResponse>>>
  call(PastCardExcelDownloadRequest params) {
    return repository!.pastCardExcelDownload(params);
  }
}
