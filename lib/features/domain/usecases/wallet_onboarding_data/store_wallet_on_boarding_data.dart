import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../entities/request/wallet_onboarding_data_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class StoreWalletOnBoardingData extends UseCase<bool, Parameter> {
  final Repository? repository;

  StoreWalletOnBoardingData({this.repository});

  @override
  Future<Either<Failure, bool>> call(Parameter parameter) async {
    return repository!
        .storeWalletOnBoardingData(parameter.walletOnBoardingDataEntity);
  }
}

class Parameter extends Equatable {
  final WalletOnBoardingDataEntity walletOnBoardingDataEntity;

  const Parameter({required this.walletOnBoardingDataEntity});

  @override
  List<Object> get props => [walletOnBoardingDataEntity];
}
