import 'package:fpdart/fpdart.dart';
import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/edit_payee_request.dart';
import '../../../data/models/responses/edit_payee_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class EditPayee extends UseCase<BaseResponse<EditPayeeResponse>, EditPayeeRequest> {
  final Repository? repository;

  EditPayee({this.repository});

  @override
  Future<Either<Failure, BaseResponse<EditPayeeResponse>>> call(
      EditPayeeRequest params) {
    return repository!.editPayee(params);
  }
}