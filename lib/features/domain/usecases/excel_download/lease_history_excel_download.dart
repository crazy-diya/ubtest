import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/lease_history_excel.dart';
import '../../../data/models/responses/lease_history_excel.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LeaseHistoryExcelDownload extends UseCase<BaseResponse<LeaseHistoryExcelResponse>, LeaseHistoryExcelRequest> {
  final Repository? repository;

  LeaseHistoryExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryExcelResponse>>>
  call(LeaseHistoryExcelRequest params) {
    return repository!.leaseHistoryExcelDownload(params);
  }
}
