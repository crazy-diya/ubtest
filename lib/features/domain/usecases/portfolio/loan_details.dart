import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/portfolio_loan_details_request.dart';
import '../../../data/models/responses/portfolio_loan_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PortfolioLoanDetails extends UseCase<
    BaseResponse<PortfolioLoanDetailsResponse>, PortfolioLoanDetailsRequest> {
  final Repository? repository;

  PortfolioLoanDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PortfolioLoanDetailsResponse>>> call(
      PortfolioLoanDetailsRequest params) {
    return repository!.portfolioLoanDetails(params);
  }
}
