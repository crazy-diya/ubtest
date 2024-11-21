import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class JustPayTCSign extends UseCase<BaseResponse, JustpayTCSignRequest> {
  final Repository? repository;

  JustPayTCSign({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(JustpayTCSignRequest params) {
    return repository!.justPayTCSign(params);
  }
}
