import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/view_personal_information_request.dart';
import '../../../data/models/responses/view_personal_information_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ViewPersonalInformation extends UseCase<BaseResponse<ViewPersonalInformationResponse>, ViewPersonalInformationRequest> {
  final Repository? repository;

  ViewPersonalInformation({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ViewPersonalInformationResponse>>> call(
      ViewPersonalInformationRequest params) async {
    return repository!.viewPersonalInformation(params);
  }
}
