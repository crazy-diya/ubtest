import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/marketing_banners_request.dart';
import '../../../data/models/responses/marketing_banners_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetMarketingBanners extends UseCase<BaseResponse<MarketingBannersResponse>, MarketingBannersRequest> {
  final Repository? repository;

  GetMarketingBanners({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MarketingBannersResponse>>> call(
      MarketingBannersRequest params) async {
    return repository!.getMarketingBanners(params);
  }
}