import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_default_data_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';

class GetRequestCallBackDefaultData extends UseCase<
    BaseResponse<RequestCallBackGetDefaultDataResponse>, RequestCallBackGetDefaultDataRequest> {
  final Repository? repository;

  GetRequestCallBackDefaultData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RequestCallBackGetDefaultDataResponse>>> call(
      RequestCallBackGetDefaultDataRequest params) async {
    return repository!.getRequestCallDefaultData(params);
  }
}
