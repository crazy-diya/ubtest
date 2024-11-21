import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/gold_loan_list_request.dart';
import '../../../data/models/responses/gold_loan_list_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GoldLoanList
    extends UseCase<BaseResponse<GoldLoanListResponse>, GoldLoanListRequest> {
  final Repository? repository;

  GoldLoanList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GoldLoanListResponse>>> call(
      GoldLoanListRequest params) {
    return repository!.requestGoldLoanList(params);
  }
}
