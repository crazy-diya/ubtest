import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/key_exchange_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';


class KeyExchange extends UseCase<
    BaseResponse<KeyExchangeResponse>, KeyExchangeRequest> {
  final Repository? repository;

  KeyExchange({this.repository});

  @override
  Future<Either<Failure, BaseResponse<KeyExchangeResponse>>> call(
      KeyExchangeRequest params) {
    return repository!.keyExchange(params);
  }
}
