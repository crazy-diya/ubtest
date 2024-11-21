import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_currency_list_request.dart';
import '../../../data/models/responses/get_currency_list_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetCurrencyList extends UseCase<BaseResponse<GetCurrencyListResponse>,
    GetCurrencyListRequest> {
  final Repository? repository;

  GetCurrencyList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetCurrencyListResponse>>> call(
      GetCurrencyListRequest params) {
    return repository!.getCurrencyList(params);
  }
}