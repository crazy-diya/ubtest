
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/loan_req_field_data_request.dart';
import '../../../data/models/responses/loan_req_field_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class LoanReqField
    extends UseCase<BaseResponse<LoanReqFieldDataResponse>, LoanReqFieldDataRequest> {
  final Repository? repository;

  LoanReqField({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LoanReqFieldDataResponse>>> call(
      LoanReqFieldDataRequest loanReqFieldDataRequest) async {
    return repository!.loanReq(loanReqFieldDataRequest);
  }
}
