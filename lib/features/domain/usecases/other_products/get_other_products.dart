
import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/get_other_products_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetOtherProducts
    extends UseCase<BaseResponse<GetOtherProductsResponse>, Parameters> {
  final Repository? repository;

  GetOtherProducts({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>> call(
      Parameters params) async {
    return await repository!.getOtherProducts(params.otherProductRequest);
  }
}

class Parameters extends Equatable {
  final CommonRequestEntity otherProductRequest;

  const Parameters({required this.otherProductRequest});

  @override
  List<Object> get props => [otherProductRequest];
}
