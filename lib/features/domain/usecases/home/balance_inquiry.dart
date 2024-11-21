import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/balance_inquiry_request.dart';
import '../../../data/models/responses/balance_inquiry_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class BalanceInquiry extends UseCase<
    BaseResponse<BalanceInquiryResponse>, BalanceInquiryRequest> {
  final Repository? repository;

  BalanceInquiry({this.repository});

  @override
  Future<Either<Failure, BaseResponse<BalanceInquiryResponse>>> call(
      BalanceInquiryRequest params) async {
    return repository!.balanceInquiry(params);
  }
}
