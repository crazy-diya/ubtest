import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/splash_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetSplashData extends UseCase<BaseResponse<SplashResponse>, Params> {
  final Repository? repository;

  GetSplashData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SplashResponse>>> call(
      Params params) async {
    return await repository!.getSplash(params.splashRequest);
  }
}

class Params extends Equatable {
  final CommonRequestEntity splashRequest;

  const Params({required this.splashRequest});

  @override
  List<Object> get props => [splashRequest];
}
