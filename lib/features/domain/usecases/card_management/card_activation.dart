import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_activation_request.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardActivation extends UseCase<BaseResponse, CardActivationRequest> {
  final Repository? repository;

  CardActivation({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(CardActivationRequest params) async {
    return repository!.cardActivation(params);
  }
}

