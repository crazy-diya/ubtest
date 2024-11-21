import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/itransfer_get_theme_request.dart';
import '../../../data/models/responses/itransfer_get_theme_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class ItransferGetTheme extends UseCase<
    BaseResponse<ItransferGetThemeResponse>, ItransferGetThemeRequest> {
  final Repository? repository;

  ItransferGetTheme({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ItransferGetThemeResponse>>> call(
      ItransferGetThemeRequest params) async {
    return repository!.itransferGetTheme(params);
  }
}
