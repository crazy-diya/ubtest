import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_user_inst_request.dart';
import '../../../data/models/responses/get_user_inst_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetUserInstruments extends UseCase<
    BaseResponse<GetUserInstResponse>, GetUserInstRequest> {
  final Repository? repository;

  GetUserInstruments({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetUserInstResponse>>> call(
      GetUserInstRequest params) async {
    return repository!.getUserInstruments(params);
  }
}
