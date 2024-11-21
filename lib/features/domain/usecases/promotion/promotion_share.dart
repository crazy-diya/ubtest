import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/promotion_share_request.dart';
import '../../../data/models/responses/promotion_share_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class PromotionPdfShare extends UseCase<BaseResponse<PromotionShareResponse>, PromotionShareRequest> {
  final Repository? repository;

  PromotionPdfShare({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PromotionShareResponse>>>
  call(PromotionShareRequest params) {
    return repository!.promotionsPdfShare(params);
  }
}
