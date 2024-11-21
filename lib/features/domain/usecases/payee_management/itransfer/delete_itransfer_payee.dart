import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/delete_itransfer_payee_request.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class DeleteItransferPayee
    extends UseCase<BaseResponse, DeleteItransferPayeeRequest> {
  final Repository? repository;

  DeleteItransferPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      DeleteItransferPayeeRequest params) {
    return repository!.deleteItransferPayee(params);
  }
}
