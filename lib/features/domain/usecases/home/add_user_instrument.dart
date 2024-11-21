import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/add_user_inst_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AddUserInstrument extends UseCase<BaseResponse, AddUserInstRequest> {
  final Repository? repository;

  AddUserInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(AddUserInstRequest params) {
    return repository!.addUserInstrument(params);
  }
}
