import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/request_money_request.dart';
import '../../../data/models/responses/request_money_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class RequestMoney extends UseCase<
    BaseResponse<RequestMoneyResponse>, RequestMoneyRequest> {
  final Repository? repository;

  RequestMoney({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RequestMoneyResponse>>> call(
      RequestMoneyRequest requestMoneyRequest) async {
    return repository!.requestMoney(requestMoneyRequest);
  }
}
