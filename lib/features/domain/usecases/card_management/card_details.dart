import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_details_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_detals_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class CardDetails extends UseCase<BaseResponse<CardDetailsResponse>, CardDetailsRequest> {
  final Repository? repository;

  CardDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardDetailsResponse>>> call(CardDetailsRequest params) async {
    return repository!.cardDetails(params);
  }
}
