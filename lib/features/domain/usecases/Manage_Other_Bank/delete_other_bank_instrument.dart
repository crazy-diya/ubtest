import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/delete_justpay_instrument_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DeletePaymentInstrument extends
UseCase<BaseResponse,DeleteJustPayInstrumentRequest> {
  final Repository? repository;

  DeletePaymentInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      DeleteJustPayInstrumentRequest params) async {
    return repository!.DeleteInstrumentPaymentInstrument(params);
  }
}
