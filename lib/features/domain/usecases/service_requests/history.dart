
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/service_req_history_request.dart';
import '../../../data/models/responses/service_req_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ServiceReqHistory extends UseCase<
    BaseResponse<ServiceReqHistoryResponse>, ServiceReqHistoryRequest> {
  final Repository? repository;

  ServiceReqHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ServiceReqHistoryResponse>>> call(
      ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    return repository!.serviceReqHistory(serviceReqHistoryRequest);
  }
}
