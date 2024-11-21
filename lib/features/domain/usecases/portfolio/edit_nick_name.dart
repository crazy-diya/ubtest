import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/edit_nick_name_request.dart';

import '../../repository/repository.dart';
import '../usecase.dart';

class EditNickName extends UseCase<BaseResponse<Serializable>,
    EditNickNamerequest> {
  final Repository? repository;

  EditNickName({this.repository});

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> call(
      EditNickNamerequest params) {
    return repository!.editNickName(params);
  }
}
