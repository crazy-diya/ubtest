import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';
import 'package:union_bank_mobile/features/domain/usecases/usecase.dart';

class DemoTour extends UseCase<BaseResponse<DemoTourListResponse>, CommonRequest> {
  final Repository? repository;

  DemoTour({this.repository});

  @override
  Future<Either<Failure, BaseResponse<DemoTourListResponse>>> call(CommonRequest params) async {
    return await repository!.getDemoTour(params);
  }
}