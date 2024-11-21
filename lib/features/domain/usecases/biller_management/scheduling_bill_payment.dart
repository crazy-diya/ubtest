import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/schedule_bill_payment_request.dart';
import '../../../data/models/responses/schedule_bill_payment_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SchedulingBillPayment extends UseCase<
    BaseResponse<ScheduleBillPaymentResponse>, ScheduleBillPaymentRequest> {
  final Repository? repository;

  SchedulingBillPayment({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ScheduleBillPaymentResponse>>> call(
      ScheduleBillPaymentRequest params) {
    return repository!.schedulingBillPayment(params);
  }
}
