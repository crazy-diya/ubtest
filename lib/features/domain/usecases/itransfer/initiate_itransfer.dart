
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/initiate_itransfer_request.dart';
import '../../../data/models/responses/initiate_itransfer_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class InitiateItransfer extends UseCase<
    BaseResponse<InitiateItransfertResponse>, InitiateItransfertRequest> {
  final Repository? repository;

  InitiateItransfer({this.repository});

  @override
  Future<Either<Failure, BaseResponse<InitiateItransfertResponse>>> call(
      InitiateItransfertRequest params) async {
    return repository!.initiateItransfer(params);
  }
}
