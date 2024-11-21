import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/cheque_book_request.dart';
import '../../../data/models/responses/cheque_book_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

// class ChequeBookField
//     extends UseCase<BaseResponse, ChequeBookRequest> {
//   final Repository? repository;
//
//   ChequeBookField({this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponse>> call(
//       ChequeBookRequest chequeBookRequest) async {
//     return repository!.checkBookReq(chequeBookRequest);
//   }
// }

class ChequeBookField extends UseCase<
    BaseResponse<ChequeBookResponse>, ChequeBookRequest> {
  final Repository? repository;

  ChequeBookField({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ChequeBookResponse>>> call(
      ChequeBookRequest chequeBookRequest) async {
    return repository!.checkBookReq(chequeBookRequest);
  }
}