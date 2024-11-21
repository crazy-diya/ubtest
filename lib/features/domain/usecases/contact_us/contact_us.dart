import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/contact_us_response.dart';
import '../../entities/request/contact_us_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ContactUs
    extends UseCase<BaseResponse<ContactUsResponseModel>, ContactUsRequestEntity> {
  final Repository? repository;

  ContactUs({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ContactUsResponseModel>>> call(
      ContactUsRequestEntity params) async {
    return await repository!.getContactUs(params);
  }
}
