import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_credit_limit_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_credit_limit_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardCreditLimit extends UseCase<BaseResponse<CardCreditLimitResponse>, CardCreditLimitRequest> {
  final Repository? repository;

  CardCreditLimit({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardCreditLimitResponse>>> call(CardCreditLimitRequest params) async {
    return repository!.cardCreditLimit(params);
  }
}
