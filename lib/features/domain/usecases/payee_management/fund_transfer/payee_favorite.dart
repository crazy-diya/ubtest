import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/payee_favorite_request.dart';
import '../../../../data/models/responses/payee_favorite_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class PayeeFavoriteUnFavorite extends UseCase<
    BaseResponse<PayeeFavoriteResponse>, PayeeFavoriteRequest> {
  final Repository? repository;

  PayeeFavoriteUnFavorite({this.repository});

  @override
  Future<Either<Failure, BaseResponse<PayeeFavoriteResponse>>> call(
      PayeeFavoriteRequest params) async {
    return repository!.payeeFavorite(params);
  }
}