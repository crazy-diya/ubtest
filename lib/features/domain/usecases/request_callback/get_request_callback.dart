import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/request_callback_get_response.dart';

class GetRequestCallBack extends UseCase<
    BaseResponse<RequestCallBackGetResponse>, RequestCallBackGetRequest> {
  final Repository? repository;

  GetRequestCallBack({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RequestCallBackGetResponse>>> call(
      RequestCallBackGetRequest params) async {
    return repository!.getRequestCall(params);
  }
}