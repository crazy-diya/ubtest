
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_remaining_inst_request.dart';
import '../../../data/models/responses/get_remaining_inst_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetRemainingInstruments extends UseCase<
    BaseResponse<GetRemainingInstResponse>, GetRemainingInstRequest> {
  final Repository? repository;

  GetRemainingInstruments({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetRemainingInstResponse>>> call(
      GetRemainingInstRequest params) async {
    return repository!.getRemainingInstruments(params);
  }
}
