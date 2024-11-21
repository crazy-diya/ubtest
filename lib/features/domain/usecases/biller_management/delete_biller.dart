// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/delete_biller_request.dart';
import '../../../data/models/responses/delete_biller_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class DeleteBiller extends UseCase<BaseResponse<DeleteBillerResponse>, DeleteBillerRequest> {
  final Repository? repository;

  DeleteBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DeleteBillerResponse>>> call(DeleteBillerRequest params) {
    return repository!.deleteBiller(params);
  }
}
