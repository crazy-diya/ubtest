import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/itransfer_payee_list_request.dart';
import '../../../../data/models/responses/itransfer_payee_list_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class ItransferPayeeList extends UseCase<
    BaseResponse<ItransferPayeeListResponse>, ItransferPayeeListRequest> {
  final Repository? repository;

  ItransferPayeeList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ItransferPayeeListResponse>>> call(
      ItransferPayeeListRequest params) async {
    return repository!.itransferPayeeList(params);
  }
}
