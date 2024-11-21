import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_save_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';

class SaveRequestCallBack extends UseCase<BaseResponse, RequestCallBackSaveRequest> {
  final Repository? repository;

  SaveRequestCallBack({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      RequestCallBackSaveRequest params) async {
    return repository!.saveRequestCall(params);
  }
}