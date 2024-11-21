
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/terms_accept_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AcceptTermsData extends UseCase<BaseResponse, TermsAcceptRequestEntity> {
  final Repository? repository;

  AcceptTermsData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      TermsAcceptRequestEntity params) async {
    return repository!.acceptTerms(params);
  }
}
