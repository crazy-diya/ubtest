import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/lease_req_save_data_request.dart';
import '../../../data/models/responses/lease_req_save_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LeaseReqSaveData
    extends UseCase<BaseResponse<LeaseReqSaveDataResponse>, LeaseReqSaveDataRequest> {
  final Repository? repository;

  LeaseReqSaveData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeaseReqSaveDataResponse>>> call(
      LeaseReqSaveDataRequest leaseReqSaveDataRequest) async {
    return repository!.leaseReqSaveData(leaseReqSaveDataRequest);
  }
}
