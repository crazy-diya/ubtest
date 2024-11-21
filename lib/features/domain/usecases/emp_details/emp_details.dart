
import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/emp_details_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class EmpDetails extends UseCase<BaseResponse, EmpDetailsParam> {
  final Repository? repository;

  EmpDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(EmpDetailsParam params) async {
    return repository!.submitEmpDetails(params.empDetailsRequestEntity);
  }
}

class EmpDetailsParam extends Equatable {
  final EmpDetailsRequestEntity empDetailsRequestEntity;

  const EmpDetailsParam({required this.empDetailsRequestEntity});

  @override
  List<Object> get props => [empDetailsRequestEntity];
}