import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/add_pay_request.dart';
import '../../../data/models/responses/add_pay_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AddPayee extends UseCase<BaseResponse<AddPayResponse>, AddPayRequest> {
  final Repository? repository;

  AddPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AddPayResponse>>> call(
      AddPayRequest params) {
    return repository!.payManagementAddPay(params);
  }
}
