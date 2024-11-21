import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../entities/request/common_request_entity.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetCityData extends UseCase<BaseResponse, Params> {
  final Repository? repository;

  GetCityData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(Params params) async {
    return await repository!.cityRequest(params.commonRequestEntity);
  }
}

class Params extends Equatable {
  final CommonRequestEntity commonRequestEntity;

  const Params({required this.commonRequestEntity});

  @override
  List<Object> get props => [commonRequestEntity];
}
