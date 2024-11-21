import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class FloatInquiry extends UseCase<
    BaseResponse<FloatInquiryResponse>, FloatInquiryRequest> {
  final Repository? repository;

  FloatInquiry({this.repository});

  @override
  Future<Either<Failure, BaseResponse<FloatInquiryResponse>>> call(
      FloatInquiryRequest params) async {
    return repository!.floatInquiryRequest(params);
  }
}
