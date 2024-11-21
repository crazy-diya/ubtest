import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';

import '../../../data/models/requests/lease_payment_history_request.dart';

import '../../../data/models/responses/lease_payment_history_response.dart';

import '../../repository/repository.dart';
import '../usecase.dart';

class LeaseHistory extends UseCase<
    BaseResponse<LeaseHistoryresponse>,
    LeaseHistoryrequest> {
  final Repository? repository;

  LeaseHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryresponse>>> call(
      LeaseHistoryrequest params) {
    return repository!.leaseHistory(params);
  }
}
