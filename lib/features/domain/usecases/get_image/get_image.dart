
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/image_api_response_model.dart';
import '../../entities/request/image_api_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetImage extends UseCase<BaseResponse<ImageApiResponseModel>,
    ImageApiRequestEntity> {
  final Repository? repository;

  GetImage({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ImageApiResponseModel>>> call(
      ImageApiRequestEntity params) async {
    return repository!.getImage(params);
  }
}
