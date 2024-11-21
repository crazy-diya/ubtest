import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/lease_history_pdf.dart';
import '../../../data/models/responses/lease_history_pdf.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LeaseHistoryPdfDownload extends UseCase<BaseResponse<LeaseHistoryPdfResponse>, LeaseHistoryPdfRequest> {
  final Repository? repository;

  LeaseHistoryPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryPdfResponse>>>
  call(LeaseHistoryPdfRequest params) {
    return repository!.leaseHistoryPdfDownload(params);
  }
}
