// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/favourite_biller_request.dart';
import '../../../data/models/responses/favourite_biller_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FavouriteBiller extends UseCase<BaseResponse<FavoriteBillerResponse>,
    FavouriteBillerRequest> {
  final Repository? repository;

  FavouriteBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FavoriteBillerResponse>>> call(
      FavouriteBillerRequest params) {
    return repository!.favouriteBiller(params);
  }
}
