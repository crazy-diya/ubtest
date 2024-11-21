import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/otp_request.dart';
import '../../../data/models/responses/otp_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class RequestOTP extends UseCase<BaseResponse<OtpResponse>, OtpRequest> {
  final Repository? repository;

  RequestOTP({this.repository});

  @override
  Future<Either<Failure, BaseResponse<OtpResponse>>> call(
      OtpRequest params) async {
    return repository!.otpRequest(params);
  }
}
