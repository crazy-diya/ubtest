import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/retrieve_profile_image_request.dart';
import '../../../data/models/responses/retrieve_profile_image_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetProfileImage extends UseCase<BaseResponse<RetrieveProfileImageResponse>, RetrieveProfileImageRequest> {
  final Repository? repository;

  GetProfileImage({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RetrieveProfileImageResponse>>> call(
      RetrieveProfileImageRequest params) async {
    return repository!.getProfileImage(params);
  }
}