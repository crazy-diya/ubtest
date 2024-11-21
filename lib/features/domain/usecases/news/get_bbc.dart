import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/common/base_request.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';

import '../../repository/repository.dart';
import '../usecase.dart';

class GetBbc
    extends UseCase<BaseResponse, BaseRequest> {
  final Repository? repository;

  GetBbc({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      BaseRequest params) async {
    return repository!.getBbc(params);
  }
}
