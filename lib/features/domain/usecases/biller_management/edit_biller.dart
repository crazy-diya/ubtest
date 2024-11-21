import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/edit_user_biller_request.dart';
import '../../../data/models/responses/edit_user_biller_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class EditUserBiller extends UseCase<BaseResponse<EditUserBillerResponse>,
    EditUserBillerRequest> {
  final Repository? repository;

  EditUserBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse<EditUserBillerResponse>>> call(
      EditUserBillerRequest params) async {
    return repository!.editBiller(params);
  }
}
