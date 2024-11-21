import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/sr_service_charge_request.dart';
import '../../../data/models/responses/sr_service_charge_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SrServiceCharge extends UseCase<
    BaseResponse<SrServiceChargeResponse>, SrServiceChargeRequest> {
  final Repository? repository;

  SrServiceCharge({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SrServiceChargeResponse>>> call(
      SrServiceChargeRequest srServiceChargeRequest) async {
    return repository!.srServiceCharge(srServiceChargeRequest);
  }
}
