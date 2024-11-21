
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/service_req_history_request.dart';
import '../../../data/models/responses/service_req_filted_list_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ServiceReqFilteredList extends UseCase<
    BaseResponse<ServiceReqFilteredListResponse>, ServiceReqHistoryRequest> {
  final Repository? repository;

  ServiceReqFilteredList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ServiceReqFilteredListResponse>>> call(
      ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    return repository!.serviceReqFilteredList(serviceReqHistoryRequest);
  }
}
