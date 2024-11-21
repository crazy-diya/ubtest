import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/language_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SetPreferredLanguage extends UseCase<BaseResponse, LanguageEntity> {
  final Repository? repository;

  SetPreferredLanguage({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(LanguageEntity params) async {
    return repository!.setPreferredLanguage(params);
  }
}
