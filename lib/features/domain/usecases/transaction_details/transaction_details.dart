import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/transcation_details_request.dart';
import '../../../data/models/responses/transcation_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class TransactionDetails extends UseCase<
    BaseResponse<TransactionDetailsResponse>, TransactionDetailsRequest> {
  final Repository? repository;

  TransactionDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionDetailsResponse>>> call(
      TransactionDetailsRequest transactionDetailsRequest) async {
    return repository!.getTransactionDetails(transactionDetailsRequest);
  }
}
