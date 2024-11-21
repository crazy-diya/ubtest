import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/debit_card_req_field_data_request.dart';
import '../../../data/models/responses/debit_card_req_field_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DebitCardCardReqFieldData
    extends UseCase<BaseResponse<DebitCardReqFieldDataResponse>, DebitCardReqFieldDataRequest> {
  final Repository? repository;

  DebitCardCardReqFieldData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DebitCardReqFieldDataResponse>>> call(
      DebitCardReqFieldDataRequest debitCardReqFieldDataRequest) async {
    return repository!.debitCardReqFieldData(debitCardReqFieldDataRequest);
  }
}
