import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/document_verification_api_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DocumentVerification
    extends UseCase<BaseResponse, DocumentVerificationApiRequestEntity> {
  final Repository? repository;

  DocumentVerification({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      DocumentVerificationApiRequestEntity params) async {
    return await repository!.documentVerification(params);
  }
}
