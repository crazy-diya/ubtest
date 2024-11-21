import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/portfolio_user_fd_details_request.dart';
import '../../../data/models/responses/portfolio_userfd_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PortfolioFDDetails extends UseCase<
    BaseResponse<PortfolioUserFdDetailsResponse>,
    PortfolioUserFdDetailsRequest> {
  final Repository? repository;

  PortfolioFDDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PortfolioUserFdDetailsResponse>>> call(
      PortfolioUserFdDetailsRequest params) {
    return repository!.portfolioFDDetails(params);
  }
}
