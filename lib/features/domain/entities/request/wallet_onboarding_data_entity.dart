import '../../../data/models/requests/wallet_onboarding_data.dart';

class WalletOnBoardingDataEntity extends WalletOnBoardingData {
  WalletOnBoardingDataEntity({
    stepperValue,
    walletUserData,
    stepperName,
  }) : super(
          stepperValue: stepperValue,
          walletUserData: walletUserData,
          stepperName: stepperName,
        );
}
