import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/gold_loan_details_request.dart';
import '../../../data/models/responses/gold_loan_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GoldLoanDetails extends UseCase<BaseResponse<GoldLoanDetailsResponse>,
    GoldLoanDetailsRequest> {
  final Repository? repository;

  GoldLoanDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GoldLoanDetailsResponse>>> call(
      GoldLoanDetailsRequest params) {
    return repository!.requestGoldLoanDetails(params);
  }
}
