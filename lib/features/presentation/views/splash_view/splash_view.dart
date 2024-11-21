import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/service/deep_linking_services.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_assets.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../bloc/splash/splash_event.dart';
import '../../bloc/splash/splash_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';

class SplashView extends BaseView {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView> {
  final LocalDataSource? _localDataSource = injection<LocalDataSource>();
  final DeepLinkHandler? _deepLinkHandler = injection<DeepLinkHandler>();

  final SplashBloc _splashBloc = injection<SplashBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((t) async => await isTamper());
  }

  Future<void> clearNullUser() async {
    final user = await _localDataSource?.hasUsername();
    if (user == false) {
      _localDataSource?.clearAccessToken();
      await _localDataSource?.clearEpicUserId();
      _localDataSource?.clearRefreshToken();
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _localDataSource!.checkIfAppIsNewInstalled();
  }

  Future<void> isTamper() async {
    if (Platform.isAndroid && AppConfig.isTamperDetection && kReleaseMode) {
      String? uniQueID = await PlatformServices.getTamperCheck();
      //VkZkd1NrMVZNWEZTVkVKUFpXdFdORlJZWXpsUVVUMDk=
      // print(uniQueID);
      if (uniQueID ==
          decodeMessageBase64(
              "VkRCU1RtVlZOWEZVV0dSUFZrWnJkdz09", 4)) {
        clearNullUser().then((value) {
          if (AppConfig.isEncryptionAvailable) {
            _splashBloc.add(ExchangeKeyEvent());
          } else {
            _splashBloc.add(RequestPushToken());
          }
        });
      }
    } else {
      clearNullUser().then((value) {
        if (AppConfig.isEncryptionAvailable) {
          _splashBloc.add(ExchangeKeyEvent());
        } else {
          _splashBloc.add(RequestPushToken());
        }
      });
    }
  }

  @override
  void onRetryPressedEvent() {
    exit(0);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SplashBloc>(
        create: (_) => _splashBloc,
        child: BlocListener<SplashBloc, BaseState<SplashState>>(
          listener: (context, state) async {
            if (state is StepperValueLoadedState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                 await _deepLinkHandler?.appLinkInitial();
              if (state.initialLaunchDone!) {
                if (state.routeString == Routes.kRegistrationInProgressView) {
                  Navigator.pushReplacementNamed(context, Routes.kLanguageView,
                      arguments: true);
                } else {
                  Navigator.pushReplacementNamed(context, state.routeString!);
                }
              } else {
                Navigator.pushReplacementNamed(context, Routes.kLanguageView,
                    arguments: true);
              }
              });
            } else if (state is SplashFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            } else if (state is SplashLoadedState) {
              if (state.splashResponse?.forceUpdate == true) {
                Navigator.pushReplacementNamed(context, Routes.kForceUpdateView,
                    arguments: true);
              } else if (state.splashResponse?.optionalUpdate == true) {
                await Navigator.pushNamed(context, Routes.kForceUpdateView, arguments: false);
                   if (_localDataSource?.getMarketingBanners() != null) {
                  _splashBloc.add(GetStepperValueEvent());
                } else {
                  _splashBloc.add(GetMarketingBannersEvent(channelType: "mb"));
                }
              } else {
                if (_localDataSource?.getMarketingBanners() != null) {
                  _splashBloc.add(GetStepperValueEvent());
                } else {
                  _splashBloc.add(GetMarketingBannersEvent(channelType: "mb"));
                }
              }
              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //   _deepLinkHandler?.appLinkInitial();
              // });
              // if (_localDataSource?.getMarketingBanners() != null) {
              //   _splashBloc.add(GetStepperValueEvent());
              // } else {
              //   _splashBloc.add(GetMarketingBannersEvent(channelType: "mb"));
              // }
            } else if (state is PushTokenSuccessState) {
              await _requestPermission();
             
            } else if (state is PushTokenFailedState) {
              if (state.code == 01) {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("no_internet_connection"),
                    ToastStatus.FAIL);
              } else {
                await _requestPermission();
              }
            } else if (state is GetMarketingBannersSuccessState) {
              _splashBloc.add(GetStepperValueEvent());
            } else if (state is ExchangeKeySuccessState) {
              _splashBloc.add(RequestPushToken());
            } else if (state is ExchangeKeyFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.ubGoSplashLogo,
                width: 130.w,
                height: 57.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context).translate("powered_by"),
                        style: size12weight400.copyWith(
                            color: colors(context).greyColor400)),
                    Text(
                      'Union Bank',
                      style: size14weight700.copyWith(
                          color: colors(context).blackColor),
                    ),
                    56.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Future<void> _requestPermission() async {
  // Request notification permission
  final notificationStatus = await Permission.notification.request();
  if (notificationStatus.isDenied) {
    await Permission.notification.request(); // Request again if denied
  }

  // Check if location services permission;
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    // Request location permission if services are enabled but permission is denied
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      await _showLocationPermissionDialog();
    } else {
      _splashBloc.add(SplashRequestEvent()); // Call splash request if permission is granted
      return;
    }
  } else {
    _splashBloc.add(SplashRequestEvent()); // Call splash request if permission is already granted
    return;
  }
}

Future<void> _showLocationPermissionDialog() async {
  await showAppDialog(
    title: AppLocalizations.of(context).translate("enable_location_services"),
    alertType: AlertType.WARNING,
    message: AppLocalizations.of(context).translate("enable_location_services_desk"),
    positiveButtonText: AppLocalizations.of(context).translate("enable"),
    negativeButtonText: AppLocalizations.of(context).translate("skip"),
    onPositiveCallback: () async {
      await Geolocator.requestPermission();
      _splashBloc.add(SplashRequestEvent()); // Call splash request after dialog finishes
      return;
    },
    onNegativeCallback: () async {
      _splashBloc.add(SplashRequestEvent()); // Call splash request if user skips
      return;
    },
  );
}


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _splashBloc;
  }
}
