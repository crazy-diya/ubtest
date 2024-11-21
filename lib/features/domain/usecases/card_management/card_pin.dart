
import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_pin_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_pin_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardPin extends UseCase<BaseResponse<CardPinResponse>, CardPinRequest> {
  final Repository? repository;

  CardPin({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardPinResponse>>> call(CardPinRequest params) async {
    return repository!.cardPinRequest(params);
  }
}
