import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

import '../../../../data/models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import '../../../../data/models/responses/card_management/loyalty_points/loyalty_redeem_response.dart';

class CardDLoyaltyRedeem extends UseCase<BaseResponse<CardLoyaltyRedeemResponse>, CardLoyaltyRedeemRequest> {
  final Repository? repository;

  CardDLoyaltyRedeem({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardLoyaltyRedeemResponse>>> call(CardLoyaltyRedeemRequest params) async {
    return repository!.cardLoyaltyRedeem(params);
  }
}
