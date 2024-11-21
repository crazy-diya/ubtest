import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_view_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_view_statement_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardViewStatement extends UseCase<BaseResponse<CardViewStatementResponse>, CardViewStatementRequest> {
  final Repository? repository;

  CardViewStatement({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardViewStatementResponse>>> call(CardViewStatementRequest params) async {
    return repository!.cardViewStatement(params);
  }
}
