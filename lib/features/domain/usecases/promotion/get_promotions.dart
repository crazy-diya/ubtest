import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/promotions_request.dart';
import '../../../data/models/responses/promotions_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetPromotions
    extends UseCase<BaseResponse<PromotionsResponse>, PromotionsRequest> {
  final Repository? repository;

  GetPromotions({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PromotionsResponse>>> call(
      PromotionsRequest params) {
    return repository!.getPromotions(params);
  }
}
