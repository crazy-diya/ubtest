import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/view_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class GetViewMails extends UseCase<BaseResponse<ViewMailResponse>, ViewMailRequest> {
  final Repository? repository;

  GetViewMails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ViewMailResponse>>> call(ViewMailRequest params) async {
    return repository!.getViewMail(params);
  }
}