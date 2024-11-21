import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/credit_card_req_save_request.dart';
import '../../../data/models/responses/credt_card_req_save_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CreditCardReqSave
    extends UseCase<BaseResponse<CreditCardReqSaveResponse>, CreditCardReqSaveRequest> {
  final Repository? repository;

  CreditCardReqSave({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CreditCardReqSaveResponse>>> call(
      CreditCardReqSaveRequest creditCardReqSaveRequest) async {
    return repository!.creditCardReqSave(creditCardReqSaveRequest);
  }
}
