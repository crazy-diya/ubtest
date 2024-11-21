import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/edit_itransfer_payee_request.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';


class EditItransferPayee
    extends UseCase<BaseResponse, EditItransferPayeeRequest> {
  final Repository? repository;

  EditItransferPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      EditItransferPayeeRequest params) {
    return repository!.editItransferPayee(params);
  }
}
