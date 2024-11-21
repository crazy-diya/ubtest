import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/cheque_book_filter_request.dart';
import '../../../data/models/responses/cheque_book_filter_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ChequeBookFilterList extends UseCase<
    BaseResponse<ChequeBookFilterResponse>, ChequeBookFilterRequest> {
  final Repository? repository;

  ChequeBookFilterList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ChequeBookFilterResponse>>> call(
      ChequeBookFilterRequest chequeBookFilterRequest) async {
    return repository!.checkBookFilter(chequeBookFilterRequest);
  }
}
