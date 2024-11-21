import 'package:fpdart/fpdart.dart';
import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/csi_request.dart';
import '../../../data/models/responses/csi_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ChequeStatusInquiry extends UseCase<
    BaseResponse<CsiResponse>, CsiRequest> {
  final Repository? repository;

  ChequeStatusInquiry({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CsiResponse>>> call(
      CsiRequest params) async {
    return repository!.csiData(params);
  }
}