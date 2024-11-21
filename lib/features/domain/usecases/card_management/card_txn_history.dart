import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_txn_history_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_txn_history_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardTxnHistory extends UseCase<BaseResponse<CardTxnHistoryResponse>, CardTxnHistoryRequest> {
  final Repository? repository;

  CardTxnHistory({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardTxnHistoryResponse>>> call(CardTxnHistoryRequest params) async {
    return repository!.cardTxnHistory(params);
  }
}