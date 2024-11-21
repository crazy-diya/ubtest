
import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/submit_products_request.dart';
import '../../../data/models/responses/submit_other_products_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SubmitOtherProducts
    extends UseCase<BaseResponse<SubmitProductsResponse>, Params> {
  final Repository? repository;

  SubmitOtherProducts({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>> call(
      Params params) async {
    return await repository!.submitOtherProducts(params.submitProductsRequest);
  }
}

class Params extends Equatable {
  final SubmitProductsRequest submitProductsRequest;

  const Params({required this.submitProductsRequest});

  @override
  List<Object> get props => [submitProductsRequest];
}
