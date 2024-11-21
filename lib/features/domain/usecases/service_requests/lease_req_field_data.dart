import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/lease_req_field_data_request.dart';
import '../../../data/models/responses/lease_req_field_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LeaseReqFieldData
    extends UseCase<BaseResponse<LeaseReqFieldDataResponse>, LeaseReqFieldDataRequest> {
  final Repository? repository;

  LeaseReqFieldData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeaseReqFieldDataResponse>>> call(
      LeaseReqFieldDataRequest leaseReqFieldDataRequest) async {
    return repository!.leaseReqFieldData(leaseReqFieldDataRequest);
  }
}
