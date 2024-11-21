import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../entities/request/common_request_entity.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetDesignationData extends UseCase<BaseResponse, Parameter> {
  final Repository? repository;

  GetDesignationData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(Parameter params) async {
    return repository!.designationRequest(params.commonRequestEntity);
  }
}

class Parameter extends Equatable {
  final CommonRequestEntity commonRequestEntity;

  const Parameter({required this.commonRequestEntity});

  @override
  List<Object> get props => [commonRequestEntity];
}
