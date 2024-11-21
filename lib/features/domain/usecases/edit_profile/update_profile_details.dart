import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/edit_profile_details_request.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class UdateProfile extends UseCase<BaseResponse, UpdateProfileDetailsRequest> {
  final Repository? repository;

  UdateProfile({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(UpdateProfileDetailsRequest params) async {
    return repository!.updateProfile(params);
  }
}