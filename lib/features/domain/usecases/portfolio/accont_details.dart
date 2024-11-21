import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/portfolio_account_details_request.dart';
import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PortfolioAccountDetails extends UseCase<
    BaseResponse<AccountDetailsResponseDtos>, PortfolioAccDetailsRequest> {
  final Repository? repository;

  PortfolioAccountDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountDetailsResponseDtos>>> call(
      PortfolioAccDetailsRequest params) {
    return repository!.portfolioAccDetails(params);
  }
}
