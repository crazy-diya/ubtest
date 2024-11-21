import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/portfolio_loan_details_request.dart';
import '../../../data/models/responses/portfolio_lease_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PortfolioLeaseDetails extends UseCase<
    BaseResponse<PortfolioLeaseDetailsResponse>, PortfolioLoanDetailsRequest> {
  final Repository? repository;

  PortfolioLeaseDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PortfolioLeaseDetailsResponse>>> call(
      PortfolioLoanDetailsRequest params) {
    return repository!.portfolioLeaseDetails(params);
  }
}
