import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/add_justPay_instrument_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class JustPayInstrument
    extends UseCase<BaseResponse, JustPayInstruementsReques> {
  final Repository? repository;

  JustPayInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call
      (JustPayInstruementsReques params) {
    return repository!.justPayInstrument(params);
  }
}
