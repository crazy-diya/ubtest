import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/update_profile_image_request.dart';
import '../../../data/models/responses/update_profile_image_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class UpdateProfileImage extends UseCase<BaseResponse<UpdateProfileImageResponse>, UpdateProfileImageRequest> {
  final Repository? repository;

  UpdateProfileImage({this.repository});

  @override
  Future<Either<Failure, BaseResponse<UpdateProfileImageResponse>>> call(
      UpdateProfileImageRequest params) async {
    return repository!.updateProfileImage(params);
  }
}
