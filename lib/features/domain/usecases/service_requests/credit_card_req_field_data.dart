import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/credit_card_req_field_data_request.dart';
import '../../../data/models/responses/credit_card_req_field_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CreditCardReqFieldData
    extends UseCase<BaseResponse<CreditCardReqFieldDataResponse>, CreditCardReqFieldDataRequest> {
  final Repository? repository;

  CreditCardReqFieldData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CreditCardReqFieldDataResponse>>> call(
      CreditCardReqFieldDataRequest creditCardReqFieldDataRequest) async {
    return repository!.creditCardReqFieldData(creditCardReqFieldDataRequest);
  }
}
