import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_e_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_e_statement_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardEStatement extends UseCase<BaseResponse<CardEStatementResponse>, CardEStatementRequest> {
  final Repository? repository;

  CardEStatement({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardEStatementResponse>>> call(CardEStatementRequest params) async {
    return repository!.cardEStatement(params);
  }
}
