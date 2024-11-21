import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/instrument_nickName_change_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class InstrumentNickNameChange
    extends UseCase<BaseResponse, InstrumentNickNameChangeRequest> {
  final Repository? repository;

  InstrumentNickNameChange({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      InstrumentNickNameChangeRequest params) {
    return repository!.instrumentNickNameChange(params);
  }
}
