import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class SetEpicUserID extends UseCase<bool, String> {
  final Repository? repository;

  SetEpicUserID({this.repository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return repository!.setEpicUserID(params);
  }
}
