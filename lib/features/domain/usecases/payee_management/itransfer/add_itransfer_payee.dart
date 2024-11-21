import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/add_itransfer_payee_request.dart';
import '../../../../data/models/responses/add_itransfer_payee_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';


class AddItransferPayee extends UseCase<BaseResponse<AddItransferPayeeResponse>, AddItransferPayeeRequest> {
  final Repository? repository;

  AddItransferPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AddItransferPayeeResponse>>> call(
      AddItransferPayeeRequest params) {
    return repository!.addItransferPayee(params);
  }
}
