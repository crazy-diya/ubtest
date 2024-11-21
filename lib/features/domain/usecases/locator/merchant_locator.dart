import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/merchant_locator_request.dart';
import '../../../data/models/responses/get_locator_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class MerchantLocator extends UseCase<
    BaseResponse<MerchantLocatorResponse>, MerchantLocatorRequest> {
  final Repository? repository;

  MerchantLocator({this.repository});

  @override
  Future<Either<Failure, BaseResponse<MerchantLocatorResponse>>> call(
      MerchantLocatorRequest params) {
    return repository!.merchantLocator(params);
  }
}
