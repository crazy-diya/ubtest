import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../entities/request/wallet_onboarding_data_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class GetWalletOnBoardingData
    extends UseCase<WalletOnBoardingData?, WalletParams> {
  final Repository? repository;

  GetWalletOnBoardingData({this.repository});

  @override
  Future<Either<Failure, WalletOnBoardingData?>> call(
      WalletParams params) async {
    return repository!.getWalletOnBoardingData();
  }
}

class WalletParams extends Equatable {
  final WalletOnBoardingDataEntity? walletOnBoardingDataEntity;

  const WalletParams({required this.walletOnBoardingDataEntity});

  @override
  List<Object?> get props => [walletOnBoardingDataEntity];
}
