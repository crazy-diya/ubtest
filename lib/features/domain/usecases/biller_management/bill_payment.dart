import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/bill_payment_request.dart';
import '../../../data/models/responses/bill_payment_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

  class BillPayment
    extends UseCase<BaseResponse<BillPaymentResponse>, BillPaymentRequest> {
  final Repository? repository;

  BillPayment({this.repository});

  @override
  Future<Either<Failure, BaseResponse<BillPaymentResponse>>> call(
      BillPaymentRequest params) {
    return repository!.billPayment(params);
  }
}
