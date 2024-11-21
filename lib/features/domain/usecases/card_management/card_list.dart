import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_list_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardList extends UseCase<BaseResponse<CardListResponse>, CommonRequest> {
  final Repository? repository;

  CardList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardListResponse>>> call(CommonRequest params) async {
    return repository!.cardList(params);
  }
}
