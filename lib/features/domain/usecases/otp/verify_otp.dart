// import 'package:fpdart/fpdart.dart';
//
// import '../../../../error/failures.dart';
// import '../../../data/models/common/base_response.dart';
// import '../../entities/request/challenge_request_entity.dart';
// import '../../repository/repository.dart';
// import '../usecase.dart';
//
// class VerifyOTP extends UseCase<BaseResponse, ChallengeRequestEntity> {
//   final Repository? repository;
//
//   VerifyOTP({this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponse>> call(
//       ChallengeRequestEntity params) async {
//     return repository!.otpVerification(params);
//   }
// }

import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/challenge_response.dart';
import '../../entities/request/challenge_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class VerifyOTP extends UseCase<BaseResponse<ChallengeResponse>, ChallengeRequestEntity> {
  final Repository? repository;

  VerifyOTP({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ChallengeResponse>>> call(
      ChallengeRequestEntity params) async {
    return repository!.otpVerification(params);
  }
}
