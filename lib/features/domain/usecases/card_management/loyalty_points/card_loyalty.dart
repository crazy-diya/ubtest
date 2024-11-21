import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardLoyaltyVouchers extends UseCase<BaseResponse<CardLoyaltyVouchersResponse>, CommonRequest> {
  final Repository? repository;

  CardLoyaltyVouchers({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardLoyaltyVouchersResponse>>> call(CommonRequest params) async {
    return repository!.cardLoyaltyVouchers(params);
  }
}