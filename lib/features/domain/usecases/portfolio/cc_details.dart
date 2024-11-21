
import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/portfolio_cc_details_request.dart';
import '../../../data/models/responses/portfolio_cc_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PortfolioCCDetails extends UseCase<
    BaseResponse<PortfolioCcDetailsResponse>, PortfolioCcDetailsRequest> {
  final Repository? repository;

  PortfolioCCDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PortfolioCcDetailsResponse>>> call(
      PortfolioCcDetailsRequest params) {
    return repository!.portfolioCCDetails(params);
  }
}
