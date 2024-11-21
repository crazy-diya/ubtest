import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_cancel_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';

class CancelRequestCallBack extends UseCase<BaseResponse, RequestCallBackCancelRequest> {
  final Repository? repository;

  CancelRequestCallBack({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      RequestCallBackCancelRequest params) async {
    return repository!.cancelRequestCall(params);
  }
}