import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/itransfer_get_theme_details_request.dart';
import '../../../data/models/responses/itransfer_get_theme_details_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ItransferGetThemeDetails extends UseCase<
    BaseResponse<ItransferGetThemeDetailsResponse>, ItransferGetThemeDetailsRequest> {
  final Repository? repository;

  ItransferGetThemeDetails({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ItransferGetThemeDetailsResponse>>> call(
      ItransferGetThemeDetailsRequest params) async {
    return repository!.itransferGetThemeDetails(params);
  }
}
