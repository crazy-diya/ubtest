import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/verify_nic_request.dart';
import '../../entities/request/verify_nic_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class VerifyNIC extends UseCase<BaseResponse, Params> {
  final Repository? repository;

  VerifyNIC({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(Params params) async {
    return repository!
        .verifyNIC(params.verifyNicRequest as VerifyNICRequestEntity);
  }
}

class Params extends Equatable {
  final VerifyNicRequest verifyNicRequest;

  const Params({required this.verifyNicRequest});

  @override
  List<Object> get props => [verifyNicRequest];
}
