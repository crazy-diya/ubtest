import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_lost_stolen_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_lost_stolen_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardLostStolen extends UseCase<BaseResponse<CardLostStolenResponse>, CardLostStolenRequest> {
  final Repository? repository;

  CardLostStolen({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardLostStolenResponse>>> call(CardLostStolenRequest params) async {
    return repository!.cardLostStolen(params);
  }
}
