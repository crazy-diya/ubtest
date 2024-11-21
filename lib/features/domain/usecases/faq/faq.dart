import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/faq_request.dart';
import '../../../data/models/responses/faq_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class Faq extends UseCase<
    BaseResponse<FaqResponse>, FaqRequest> {
  final Repository? repository;

  Faq({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FaqResponse>>> call(
      FaqRequest params) async {
    return repository!.preLoginFaq(params);
  }
}
