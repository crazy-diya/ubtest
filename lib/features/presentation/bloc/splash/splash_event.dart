// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../base_event.dart';

abstract class SplashEvent extends BaseEvent {}

class SplashRequestEvent extends SplashEvent {
  final String? deviceChannel;

  SplashRequestEvent({this.deviceChannel});
}

class GetStepperValueEvent extends SplashEvent {}

class RequestPushToken extends SplashEvent {}

class GetMarketingBannersEvent extends SplashEvent {
   String? channelType;
  GetMarketingBannersEvent({
    this.channelType,
  });
   
}

class ExchangeKeyEvent extends SplashEvent {
  ExchangeKeyEvent();
}
