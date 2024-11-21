import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/default_payment_instrument_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DefaultPaymentInstrument
    extends UseCase<BaseResponse, DefaultPaymentInstrumentRequest> {
  final Repository? repository;

  DefaultPaymentInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      DefaultPaymentInstrumentRequest params) {
    return repository!.defaultPaymentInstrument(params);
  }
}
