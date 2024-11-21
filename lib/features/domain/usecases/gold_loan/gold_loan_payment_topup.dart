import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/gold_loan_payment_topup_request.dart';
import '../../../data/models/responses/gold_loan_payment_top_up_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GoldLoanPaymentTopUp extends UseCase<
    BaseResponse<GoldLoanPaymentTopUpResponse>, GoldLoanPaymentTopUpRequest> {
  final Repository? repository;

  GoldLoanPaymentTopUp({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GoldLoanPaymentTopUpResponse>>> call(
      GoldLoanPaymentTopUpRequest params) {
    return repository!.requestGoldLoanPaymentTopUp(params);
  }
}
