import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/get_terms_response.dart';
import '../../entities/request/get_terms_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetTermsData
    extends UseCase<BaseResponse<GetTermsResponse>, GetTermsRequestEntity> {
  final Repository? repository;

  GetTermsData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetTermsResponse>>> call(
      GetTermsRequestEntity params) async {
    return await repository!.getTerms(params)
        as FutureOr<Either<Failure, BaseResponse<GetTermsResponse>>>;
  }
}
