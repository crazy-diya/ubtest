import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ComposeMail extends UseCase<BaseResponse, ComposeMailRequest> {
  final Repository? repository;

  ComposeMail({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(ComposeMailRequest params) async {
    return repository!.composeMail(params);
  }
}
