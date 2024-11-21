import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:fpdart/fpdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/encryption/encryptor.dart';
import 'package:union_bank_mobile/core/network/network_info.dart';
import 'package:union_bank_mobile/core/service/cloud_service/cloud_services.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/marketing_banners_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/domain/usecases/key_exchange/key_exchange.dart';
import 'package:union_bank_mobile/features/domain/usecases/splash/get_marketing_banners.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_state.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
// import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/usecases/splash/get_splash_data.dart';
import '../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../base_bloc.dart';
import '../base_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, BaseState<SplashState>> {
  final LocalDataSource appSharedData;
  final GetSplashData useCaseSplashData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final CloudServices cloudServices;
  final GetMarketingBanners getMarketingBanners;
  final NetworkInfo networkInfo;
  final KeyExchange? keyExchange;
  final Encrypt? encrypt;

  SplashBloc({
    required this.appSharedData,
    required this.useCaseSplashData,
    required this.getWalletOnBoardingData,
    required this.cloudServices,
    required this.getMarketingBanners,
    required this.networkInfo,
    required this.encrypt,
    required this.keyExchange,
  }) : super(InitialSplashState()) {
    on<SplashRequestEvent>(_handleSplashRequestEvent);
    on<GetStepperValueEvent>(_handleGetStepperValueEvent);
    on<RequestPushToken>(_handleRequestPushToken);
    on<GetMarketingBannersEvent>(_handleGetMarketingBanners);
    on<ExchangeKeyEvent>(_handleExchangeKeyEvent);
  }

  Future<void> _handleSplashRequestEvent(
      SplashRequestEvent event, Emitter<BaseState<SplashState>> emit) async {
    final biometric = await appSharedData.getBiometricCode();
    AppConstants.BIOMETRIC_CODE = biometric;

    String? bas64Signature;
    String? splitFirst;
    String? splitLast;
    String? finalSignature;

    if(Platform.isAndroid){
      bas64Signature = base64.encode(utf8.encode(await PlatformServices.getSignature()??""));
      splitFirst = bas64Signature.substring(0,13);
      splitLast = bas64Signature.substring(13,bas64Signature.length-2);
      finalSignature = "$splitLast$splitFirst==";
    }
 
    final result = await useCaseSplashData(
     Params(
        splashRequest: (Platform.isAndroid)
              ? CommonRequestEntity(
                  messageType: kMessageTypeSplashReq,
                  appSignature: finalSignature,
                )
              : const CommonRequestEntity(
                  messageType: kMessageTypeSplashReq,
                ),
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return SplashFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      //username policy

      AppConstants.userNamePolicy = r.data!.userNamePolicy!;
      appSharedData.setUserNamePolicy(r.data!.userNamePolicy!);

      //password policy

      AppConstants.passwordPolicy = r.data!.passwordPolicy!;
      appSharedData.setPasswordPolicy(r.data!.passwordPolicy!);


      AppConstants.RATES_URL = r.data!.ratesUrl;
      AppConstants.SEAT_RESERVATION_URL = r.data!.seatReservationUrl;
      AppConstants.COMPANY_DETAILS = r.data?.companyDetails??[];
      AppConstants.CALL_CENTER_TEL_NO = AppConstants.COMPANY_DETAILS!.firstWhere((e)=>e.code=="CALL_CENTER_TEL_NO",orElse:()=> CompanyDetail(value: "0117818181")).value;
      AppConstants.ubBankName = r.data!.bankDataList?.where((element) => element.bankCode == "7302").first.description;
      obTypes = r.data!.obTypeDataList;
      for (var element in r.data!.bankDataList!) {
        kBankList.add(CommonDropDownResponse(
            id: int.parse(element.bankCode!),
            description: element.description,
            code: element.ceftCode,
            key: element.bankCode,
            icon: bankIcons.firstWhere((e) => element.bankCode == e.bankCode,orElse: () => BankIcon() ,).icon
            ));
      }
      return SplashLoadedState(splashResponse: r.data);
    }));
  }

  Future<void> _handleGetStepperValueEvent(
      GetStepperValueEvent event, Emitter<BaseState<SplashState>> emit) async {
    final result = await getWalletOnBoardingData(
      const WalletParams(walletOnBoardingDataEntity: null),
    );

    final obj = result.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is Failure) {
      if (obj is AuthorizedFailure) {
        emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is SessionExpire) {
       emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ServerFailure) {
        emit(ServerFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      }else {
      emit(
          SplashFailedState(message: "Could not load data from local Storage"));
      }
    } else {
      final WalletOnBoardingData walletOnBoardingData =
          obj != null ? obj as WalletOnBoardingData : WalletOnBoardingData();
      final bool initialLaunch = await appSharedData.isInitialLaunchDone();

      if (walletOnBoardingData.stepperValue != null) {
        if (walletOnBoardingData.stepperValue! > 0) {
          emit(StepperValueLoadedState(
              routeString: Routes.kLoginView,
              stepperName: walletOnBoardingData.stepperName,
              stepperValue: walletOnBoardingData.stepperValue,
              initialLaunchDone: initialLaunch));
        } else {
          emit(StepperValueLoadedState(
              routeString: Routes.kLoginView,
              initialLaunchDone: initialLaunch));
        }
      } else {
        emit(StepperValueLoadedState(
            routeString: Routes.kLoginView, initialLaunchDone: initialLaunch));
      }
    }
  }

  Future<void> _handleRequestPushToken(
      RequestPushToken event, Emitter<BaseState<SplashState>> emit) async {
    final hasToken = await appSharedData.hasPushToken();
    if (await networkInfo.isConnected) {
    if (hasToken) {
      final token = await appSharedData.getPushToken();
      log(token ?? "");
      emit(PushTokenSuccessState());
    } else {
     bool? isToken = await cloudServices.capturePushToken();
     if(isToken==true){
     emit(PushTokenSuccessState());
     }else{
      emit(PushTokenFailedState());
     }
    }
   }else{
    emit(PushTokenFailedState(code: 01));
   }
  }

  // You can keep the _eitherSplashSuccessOrErrorState method as it is

Future<void> _handleGetMarketingBanners(GetMarketingBannersEvent event, Emitter<BaseState<SplashState>> emit) async {

    final result = await getMarketingBanners(
        MarketingBannersRequest(messageType: kMessageTypeSplashReq,channelType: event.channelType));

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return GetMarketingBannersFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.data?.channel?.isNotEmpty??false){
      appSharedData.setMarketingBanners([
        r.data?.channel?.first.bannerOneUrl ?? "",
        r.data?.channel?.first.bannerTwoUrl ?? "",
        r.data?.channel?.first.bannerThreeUrl ?? ""
      ]);

      appSharedData.setDescriptionBanners( r.data?.channel?.first.description ?? "");

      }
      return GetMarketingBannersSuccessState(
          marketingBannersResponse: r.data
          );
    }));
  }

    ///encryption
  Future<void> _handleExchangeKeyEvent(
      ExchangeKeyEvent event, Emitter<BaseState<SplashState>> emit) async {
    final _result = await keyExchange!( KeyExchangeRequest(
              clientPubKey: encrypt!.getClientPublicKey(),));
    emit(_result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return ExchangeKeyFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      encrypt!.setPublicKey(ecServerPublicKey: r.data!.serverPubKey!);
      return ExchangeKeySuccessState();
    }));
  }
}
