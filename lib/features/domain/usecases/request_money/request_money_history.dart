import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/request_money_history_request.dart';
import '../../../data/models/responses/request_money_history_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class RequestMoneyHistory extends UseCase<
    BaseResponse<RequestMoneyHistoryResponse>, RequestMoneyHistoryRequest> {
  final Repository? repository;

  RequestMoneyHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RequestMoneyHistoryResponse>>> call(
      RequestMoneyHistoryRequest requestMoneyHistoryRequest) async {
    return repository!.reqMoneyHistory(requestMoneyHistoryRequest);
  }
}
