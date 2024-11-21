import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_home_details_request.dart';
import '../../../data/models/responses/get_home_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetHomeDetails extends UseCase<BaseResponse<GetHomeDetailsResponse>, GetHomeDetailsRequest> {
  final Repository? repository;

  GetHomeDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetHomeDetailsResponse>>> call(
      GetHomeDetailsRequest params) async {
    return repository!.getHomeDetails(params);
  }
}
