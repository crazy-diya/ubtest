import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_type_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_type_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class GetRecipientTypes extends UseCase<BaseResponse<RecipientTypeResponse>, RecipientTypeRequest> {
  final Repository? repository;

  GetRecipientTypes({this.repository});

  @override
  Future<Either<Failure, BaseResponse<RecipientTypeResponse>>> call(RecipientTypeRequest params) async {
    return repository!.getRecipientType(params);
  }
}