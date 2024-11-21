import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_last_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_last_statement_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardLastStatement extends UseCase<BaseResponse<CardLastStatementResponse>, CardLastStatementRequest> {
  final Repository? repository;

  CardLastStatement({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardLastStatementResponse>>> call(CardLastStatementRequest params) async {
    return repository!.cardLastStatement(params);
  }
}
