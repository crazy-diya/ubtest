// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:union_bank_mobile/features/data/models/responses/marketing_banners_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';

import '../base_state.dart';

abstract class SplashState extends BaseState<SplashState> {}

class InitialSplashState extends SplashState {}

class SplashLoadedState extends SplashState {
 final SplashResponse? splashResponse;
  SplashLoadedState({
   this.splashResponse,
  });
}

class SplashFailedState extends SplashState {
  final String? message;

  SplashFailedState({this.message});
}

class StepperValueLoadedState extends SplashState {
  final String? routeString;
  final String? stepperName;
  final int? stepperValue;
  final bool? initialLaunchDone;

  StepperValueLoadedState(
      {this.routeString,
        this.stepperValue,
        this.stepperName,
        this.initialLaunchDone});
}

class PushTokenSuccessState extends SplashState {}

class PushTokenFailedState extends SplashState {
  final int? code;
  PushTokenFailedState({this.code});
}

class GetMarketingBannersFailedState extends SplashState {
   final String? message;

  GetMarketingBannersFailedState({this.message});
}
class GetMarketingBannersSuccessState extends SplashState {
  final MarketingBannersResponse? marketingBannersResponse;

  GetMarketingBannersSuccessState({this.marketingBannersResponse});

}


class ExchangeKeySuccessState extends SplashState {
  ExchangeKeySuccessState();
}

class ExchangeKeyFailedState extends SplashState {
  final String? message;

  ExchangeKeyFailedState({this.message});
}
