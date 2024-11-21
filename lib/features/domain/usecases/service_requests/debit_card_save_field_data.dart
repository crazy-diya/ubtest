
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/debit_card_save_data_request.dart';
import '../../../data/models/responses/debit_card_save_data_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DebitCardSaveFieldData
    extends UseCase<BaseResponse<DebitCardSaveDataResponse>, DebitCardSaveDataRequest> {
  final Repository? repository;

  DebitCardSaveFieldData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DebitCardSaveDataResponse>>> call(
      DebitCardSaveDataRequest debitCardSaveDataRequest) async {
    return repository!.debitCardReqSaveData(debitCardSaveDataRequest);
  }
}
