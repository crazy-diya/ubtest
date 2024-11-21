
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/get_justpay_instrument_request.dart';
import '../../../data/models/responses/get_justpay_instrument_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetJustpayPaymentInstrument extends
UseCase<BaseResponse <GetJustPayInstrumentResponse>,GetJustPayInstrumentRequest> {
  final Repository? repository;

  GetJustpayPaymentInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetJustPayInstrumentResponse>>> call(
      GetJustPayInstrumentRequest params)  {
    return repository!.GetPaymentInstrument(params);
  }
}
