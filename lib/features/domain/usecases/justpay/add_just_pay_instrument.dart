import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/add_just_pay_instruements_request.dart';
import '../../../data/models/responses/add_just_pay_instruements_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class AddJustPayInstrument extends UseCase<
    BaseResponse<AddJustPayInstrumentsResponse>, AddJustPayInstrumentsRequest> {
  final Repository? repository;

  AddJustPayInstrument({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AddJustPayInstrumentsResponse>>> call(
      AddJustPayInstrumentsRequest addJustPayInstrumentsRequest) async {
    return repository!.addJustPayInstrument(addJustPayInstrumentsRequest);
  }
}
