import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/instrument_status_change_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class InstrumentStatusChange
    extends UseCase<BaseResponse, InstrumentStatusChangeRequest> {
  final Repository? repository;

  InstrumentStatusChange({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      InstrumentStatusChangeRequest params) {
    return repository!.instrumentStatusChange(params);
  }
}
