import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/account_inquiry_request.dart';
import '../../../data/models/responses/account_inquiry_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AccountInquiry extends UseCase<
    BaseResponse<AccountInquiryResponse>, AccountInquiryRequest> {
  final Repository? repository;

  AccountInquiry({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AccountInquiryResponse>>> call(
      AccountInquiryRequest params) async {
    return repository!.accountInquiry(params);
  }
}
