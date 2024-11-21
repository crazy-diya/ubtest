
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/qr_payment_request.dart';
import '../../../data/models/responses/qr_payment_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class QRPayment extends UseCase<BaseResponse<QrPaymentResponse>,
    QrPaymentRequest> {
  final Repository? repository;

  QRPayment({this.repository});

  @override
  Future<Either<Failure, BaseResponse<QrPaymentResponse>>> call(
      QrPaymentRequest params) {
    return repository!.qrPayment(params);
  }
}