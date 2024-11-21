
import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/responses/schedule_date_response.dart';
import '../../../entities/request/common_request_entity.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetScheduleDates extends UseCase<BaseResponse<ScheduleDateResponse>, GetScheduleParams> {
  final Repository? repository;

  GetScheduleDates({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> call(GetScheduleParams params) async {
    return await repository!.getScheduleDates(params.scheduleDateRequest);
  }
}

class GetScheduleParams extends Equatable {
  final CommonRequestEntity scheduleDateRequest;

  const GetScheduleParams({required this.scheduleDateRequest});

  @override
  List<Object> get props => [scheduleDateRequest];
}
