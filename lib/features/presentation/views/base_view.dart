import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:freerasp/freerasp.dart';
import 'package:huawei_push/huawei_push.dart' as PushKit;
import 'package:installer_info/installer_info.dart';
import 'package:lottie/lottie.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/views/security/security_failure_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/flavors/flavor_banner.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/service/dependency_injection.dart';
import '../../../core/service/cloud_service/local_push_manager.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/theme_data.dart';
import '../../../error/messages.dart';
import '../../../utils/enums.dart';
import '../../../utils/navigation_routes.dart';
import '../../data/datasources/secure_storage.dart';
import '../bloc/base_bloc.dart';
import '../bloc/base_event.dart';
import '../bloc/base_state.dart';
import '../widgets/app_dialog.dart';

abstract class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  final secureStorage = injection<SecureStorage>();
  final pref = injection<LocalDataSource>();
  bool isRealDevice = false,
      isRealDevice2 = false,
      isJailBroken = false,
      isRoot = false,
      isRoot2 = false,
      isADBEnabled = false;
  SecurityFailureType _securityFailureType = SecurityFailureType.SECURE;
  InstallerInfo? installerInfo;

  bool _isProgressShow = false;
  bool _isLoadingShow = false;

  int? isDoNotify;

  static Timer? _timerBase;

  int? existMessage = 0;

  String? isDuShowAuthFailure;
  String? isDuShowSessionFailure;

  //Session Time Out
  DateTime? initialDateTimeBase;
  int countDownTimeMsBase = 0;
  bool isDuShowSessionTimeOut = true;
  late final AppLifecycleListener listenerBase;

  //  late final AppLifecycleListener listenerBasePermisson;

   bool _permissionDialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _initSecurityState();
    if (AppConstants.IS_USER_LOGGED) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _initializeTimer();
      });
    } else {
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }
    }
  }

  Widget buildView(BuildContext context);

  BaseBloc<BaseEvent, BaseState<dynamic>> getBloc();

  void _initializeTimer() {
    try {
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }
    } catch (e) {}
    countDownTimeMsBase = AppConstants.APP_SESSION_TIMEOUT;
    initialDateTimeBase = DateTime.now();
    setState(() {});
    _timerBase = Timer.periodic(const Duration(seconds: 1), (time) async {
      if (mounted) {
        setState(() {
          countDownTimeMsBase--;
        });
      }
      if (time.tick == AppConstants.APP_SESSION_TIMEOUT) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    if (mounted) {
      setState(() {
        countDownTimeMsBase = 0;
        initialDateTimeBase = null;
      });
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }

      if (_securityFailureType == SecurityFailureType.SECURE &&
          AppConstants.IS_USER_LOGGED) {
        if (isDuShowSessionTimeOut == true) {
          if (mounted) {
            setState(() {
              isDuShowSessionTimeOut = false;
            });
            showAppDialog(
                alertType: AlertType.WARNING,
                isSessionTimeout: true,
                title: ErrorHandler.TITLE_UBGO,
                message: AppLocalizations.of(context).translate("session_timeout_des"),
                positiveButtonText:
                    AppLocalizations.of(context).translate("login"),
                onPositiveCallback: () {
                  logout();
                });
          }
        }
      }
    }
  }


  // Future<void> _requestPermission() async {
  //     if(_securityFailureType==SecurityFailureType.SECURE){
  //     if(_permissionDialogShown)return;
  //     if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
  //       bool serviceEnabled;
  //       PermissionStatus permission;

  //       serviceEnabled =  await Permission.location.serviceStatus.isEnabled;

  //       if (!serviceEnabled) {
  //         await settingDialog();
  //         return;
  //       }

  //        permission = await Permission.location.status;

  //       if (permission == PermissionStatus.denied) {
  //         permission = await Permission.location.request();
  //         if (permission == PermissionStatus.denied) {
  //           await settingDialog();
  //           return;
  //         }
  //       }

  //       if (permission == PermissionStatus.permanentlyDenied) {
  //         await settingDialog();
  //         return;
  //       }

  //     } else {
  //       bool serviceEnabled;
  //       LocationPermission permission;

  //       serviceEnabled = await Geolocator.isLocationServiceEnabled();

  //       if (!serviceEnabled) {
  //         await settingDialog();
  //         return;
  //       }

  //       permission = await Geolocator.checkPermission();

  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //         if (permission == LocationPermission.denied) {
  //           await settingDialog();
  //           return;
  //         }
  //       }

  //       if (permission == LocationPermission.deniedForever) {
  //         await settingDialog();
  //         return;
  //       }
  //     }
  //     if(await Permission.location.status.isGranted){
  //       AppPermissionManager.requestNotificationPermission(context, () {});
  //     }
  //   }
    
  // }

  // dynamic settingDialog() {
  //   _permissionDialogShown =true;
  //   showAppDialog(
  //       alertType: AlertType.WARNING,
  //       title: AppLocalizations.of(context).translate("location_update_failed"),
  //       message:
  //           AppLocalizations.of(context).translate("please_enable_location"),
  //       onPositiveCallback: () async {
  //         await openAppSettings();
  //          _permissionDialogShown = false;
  //       },
  //       positiveButtonText: AppLocalizations.of(context).translate("settings"));
  // }

  @override
  void initState() {
    _initSecurityState();
     listenerBase = AppLifecycleListener(
      onStateChange: _onStateChangedBase,
    );

    // listenerBasePermisson =AppLifecycleListener(
    //   onStateChange:(state){
    //     if(state ==AppLifecycleState.resumed){
    //     _requestPermission();
    //     }
    //   }
    // );
    
    if (AppConstants.IS_USER_LOGGED) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _initializeTimer();
      });
    } else {
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }
    }
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
      _configureFirebaseNotification();
    } else {
      _configureHuaweiPushNotifications();
    }
    super.initState();
  }

  

  void _onStateChangedBase(AppLifecycleState state) {
    if (AppConstants.IS_USER_LOGGED) {
      switch (state) {
        case AppLifecycleState.resumed:
          if (initialDateTimeBase != null && mounted) {
            log("RESUME");
            Duration? initialBase =
                DateTime.now().difference(initialDateTimeBase!);
            countDownTimeMsBase = 0;
            countDownTimeMsBase =
                (AppConstants.APP_SESSION_TIMEOUT - initialBase.inSeconds);
            setState(() {});
            log("${countDownTimeMsBase} STATIC");
            if (0 < countDownTimeMsBase) {
              try {
                if (_timerBase?.isActive ?? false) {
                  _timerBase?.cancel();
                }
              } catch (e) {}

              _timerBase = Timer.periodic(const Duration(seconds: 1), (time) {
                if (mounted)
                  setState(() {
                    countDownTimeMsBase--;
                  });
                if (0 >= countDownTimeMsBase) {
                  _stopTimer();
                }
              });
            } else {
              _stopTimer();
            }
          }
          break;
        case AppLifecycleState.inactive:
          log("INACTIVE");
          _timerBase?.cancel();
          break;
        case AppLifecycleState.paused:
          log("PAUSE");
          _timerBase?.cancel();
          break;
        case AppLifecycleState.hidden:
          log("HIDDEN");
          _timerBase?.cancel();
          break;
        case AppLifecycleState.detached:
          break;
      }
    } else {
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }
    }
  }





String _checkLocalStrings(String error) {
    switch (error) {
      case "connection_timed_out":
        return AppLocalizations.of(context).translate("connection_timed_out");
      case "request_timed_out":
        return AppLocalizations.of(context).translate("request_timed_out");
      case "response_timed_out":
        return AppLocalizations.of(context).translate("response_timed_out");
      case "server_encountered_an_error":
        return AppLocalizations.of(context)
            .translate("server_encountered_an_error");
      case "request_canceled":
        return AppLocalizations.of(context).translate("request_canceled");
      case "unable_to_connect_please_check":
        return AppLocalizations.of(context)
            .translate("unable_to_connect_please_check");
      case "certificate_is_invalid":
        return AppLocalizations.of(context).translate("certificate_is_invalid");
      case "unable_connect_server_des":
        return AppLocalizations.of(context)
            .translate("unable_connect_server_des");
      case "something_went_wrong":
        return AppLocalizations.of(context).translate("something_went_wrong");
      default:
        return error;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: BlocProvider<BaseBloc>(
        create: (_) => getBloc(),
        child: BlocListener<BaseBloc, BaseState>(
          listener: (context, state) {
            if (state is APILoadingState) {
              showProgressBar();
            } else if (state is AuthorizedFailureState) {
              hideProgressBar();
              if (isDuShowAuthFailure != state.error) {
                isDuShowAuthFailure = state.error;
                showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_AUTHORIZED_FAILURE),
                    message: _checkLocalStrings(state.error),
                    onPositiveCallback: () {
                      isDuShowAuthFailure = null;
                      if (AppConstants.IS_USER_LOGGED) {
                        logout();
                      }
                    });
              }
              setState(() {});
            } else if (state is SessionExpireState) {
              hideProgressBar();
              if (isDuShowSessionFailure != state.error) {
                isDuShowSessionFailure = state.error;
                showAppDialog(
                    title:AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_SESSION_EXPIRED),
                    alertType: AlertType.WARNING,
                    // message: splitAndJoinAtBrTags(state.error ?? ""),
                    dialogContentWidget: Column(
                      children: [
                        Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                  text: splitAndJoinAtBrTags(
                                      extractTextWithinTags(
                                          input: state.error)[0]),
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor)),
                               if(extractTextWithinTags(
                               input: state.error).length>1)TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      _launchCaller(splitAndJoinAtBrTags(
                                          extractTextWithinTags(
                                              input: state.error)[1]));
                                    },
                                  text:
                                  " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.error)[1])}",
                                  style: size14weight700.copyWith(
                                      color: colors(context).primaryColor)),
                            ]))
                      ],
                    ),
                    onPositiveCallback: () {
                      isDuShowSessionFailure = null;
                      if (AppConstants.IS_USER_LOGGED) {
                        logout();
                      }
                    });
              }
              setState(() {});
            } else if (state is ConnectionFailureState) {
              hideProgressBar();
              ToastUtils.showCustomToast(
                  context,_checkLocalStrings(state.error), ToastStatus.FAIL);
            } else if (state is ServerFailureState) {
              hideProgressBar();
              showAppDialog(
                alertType: AlertType.CONNECTION,
                title: AppLocalizations.of(context)
                    .translate("unable_connect_server"),
                message: state.error == null || state.error == ""
                    ? AppLocalizations.of(context)
                        .translate("unable_connect_server_des")
                    : splitAndJoinAtBrTags(_checkLocalStrings(state.error)),
                onPositiveCallback: () {
                  setState(() {
                    onRetryPressedEvent();
                  });
                },
                positiveButtonText:
                    AppLocalizations.of(context).translate("ok"),
              );
            } else {
              hideProgressBar();
              if (state is APIFailureState) {
                showAppDialog(
                    title: ErrorHandler.TITLE_OOPS,
                    message:_checkLocalStrings(state.error),
                    onPositiveCallback: () {});
              }
            }
          },
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerCancel: _handleUserInteraction,
            onPointerDown: _handleUserInteraction,
            onPointerMove: _handleUserInteraction,
            onPointerSignal: _handleUserInteraction,
            onPointerUp: _handleUserInteraction,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                child: _securityFailureType == SecurityFailureType.SECURE
                    ? buildView(context)
                    : SecurityFailureView(
                        securityFailureType: _securityFailureType,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onRetryPressedEvent(){
  }

  void _handleUserInteraction(s) {
    if (AppConstants.IS_USER_LOGGED) {
      _initializeTimer();
    } else {
      if (_timerBase?.isActive ?? false) {
        _timerBase?.cancel();
      }
    }
  }

  logout() async {
    AppConstants.IS_USER_LOGGED = false;
    AppConstants.IS_FIRST_TIME_BIOMETRIC_POPUP = false;
   await Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.kLoginView,
      (Route<dynamic> route) => route.settings.name == Routes.kSplashView,
    );
  }

 Future<void> _initSecurityState() async {
    if (AppConfig.isSourceVerificationAvailable) {
      installerInfo = await getInstallerInfo();
      if (installerInfo != null) {
        if (!(appMarkets.contains(installerInfo!.installerName))) {
          setState(() {
            _securityFailureType = SecurityFailureType.SOURCE;
          });
        }
      } else {
        setState(() {
          _securityFailureType = SecurityFailureType.SOURCE;
        });
      }
    }

    if (Platform.isAndroid) {
      if (AppConfig.isADBCheckAvailable) {
        isADBEnabled = await PlatformServices.getADBStatus;
        if (isADBEnabled) {
          dev.log("Debugging checked using native call");
          setState(() {
            _securityFailureType = SecurityFailureType.ADB;
          });
        }
      }
      if (AppConfig.isEmulatorCheckAvailable) {
        var deviceInfo = DeviceInfo();
        await deviceInfo.initDeviceInfo();
        if (deviceInfo.isRealDevice == false) {
          dev.log("Emulator");
          setState(() {
            _securityFailureType = SecurityFailureType.EMU;
          });
        }
      }
      if (AppConfig.isEmulatorCheckAvailable) {
        isRealDevice = await PlatformServices.isEmu;
        if (isRealDevice) {
          dev.log("Emlatr check 1st method!");
          setState(() {
            _securityFailureType = SecurityFailureType.EMU;
          });
        }
      }

      if (AppConfig.isEmulatorCheckAvailable) {
        isRealDevice2 = await PlatformServices.isRealDevice;
        if (isRealDevice2) {
          dev.log("Emlatr check 2nd method!");
          setState(() {
            _securityFailureType = SecurityFailureType.EMU;
          });
        }
      }

      if (AppConfig.isRootCheckAvailable) {
        isRoot = await PlatformServices.isRooted;
        if (isRoot) {
          dev.log("Rooted!");
          setState(() {
            _securityFailureType = SecurityFailureType.ROOT;
          });
        }
      }
      if (AppConfig.isRootCheckAvailable) {
        isRoot2 = await PlatformServices.isRoot;
        if (isRoot2) {
          dev.log("Rooted new!");
          setState(() {
            _securityFailureType = SecurityFailureType.ROOT;
          });
        }
      }
    } else if (Platform.isIOS) {
      if (AppConfig.isSimulatorCheckAvailable) {
        var deviceInfo = DeviceInfo();
        await deviceInfo.initDeviceInfo();
        if (deviceInfo.isRealDevice == false) {
          dev.log("Simulator");
          setState(() {
            _securityFailureType = SecurityFailureType.EMU;
          });
        }
      }
      if (AppConfig.isCheckJailBroken) {
        isJailBroken = await PlatformServices.isJailBroken;
        if (isJailBroken) {
          dev.log("Jail Broken!");
          setState(() {
            _securityFailureType = SecurityFailureType.JAILBROKEN;
          });
        }
      }
    }
    // _requestPermission();
    
    if (!mounted) return;
  }
  

  showAppDialog(
      {required String title,
      String? message,
      Color? messageColor,
      String? subDescription,
      Color? subDescriptionColor,
      AlertType alertType = AlertType.SUCCESS,
      String? positiveButtonText,
      String? negativeButtonText,
      String? bottomButtonText,
      VoidCallback? onPositiveCallback,
      VoidCallback? onNegativeCallback,
      VoidCallback? onBottomButtonCallback,
      Widget? dialogContentWidget,
      bool shouldDismiss = false,
      bool? shouldEnableClose,
      bool isSessionTimeout = false,
      bool isAlertTypeEnable = true}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: shouldDismiss,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
                bottomButtonText: bottomButtonText,
                onBottomButtonCallback: onBottomButtonCallback,
                isAlertTypeEnable: isAlertTypeEnable,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }

  // void showNotificationAppDialog(
  //     {required String title,
  //     required String message,
  //     required String? payFromAccount,
  //     required String? payToAccount,
  //     required String? payToNumber,
  //     VoidCallback? onPositiveCallback,
  //     required String? payFromAccountNumber,
  //     required String? dateAndTime,
  //     required String? remarks,
  //     required String? referenceNumber,
  //     Color? messageColor,
  //     AlertType alertType = AlertType.SUCCESS,
  //     Widget? dialogContentWidget,
  //     bool shouldDismiss = false,
  //     bool? shouldEnableClose,
  //     bool isSessionTimeout = false}) {
  //   showGeneralDialog(
  //       context: context,
  //       barrierDismissible: shouldDismiss,
  //       transitionBuilder: (context, a1, a2, widget) {
  //         return Transform.scale(
  //           scale: a1.value,
  //           child: Opacity(
  //             opacity: a1.value,
  //             child: NotificationAppDialog(
  //               title: title,
  //               description: message,
  //               descriptionColor: messageColor,
  //               alertType: alertType,
  //               onPositiveCallback: onPositiveCallback,
  //               isSessionTimeout: isSessionTimeout,
  //               payFromAccount: payFromAccount.toString(),
  //               payFromAccountNumber: payFromAccountNumber.toString(),
  //               payToAccount: payToAccount.toString(),
  //               payToNumber: payToNumber.toString(),
  //               dateAndTime: dateAndTime.toString(),
  //               remarks: remarks.toString(),
  //               referenceNumber: referenceNumber.toString(),
  //             ),
  //           ),
  //         );
  //       },
  //       transitionDuration: const Duration(milliseconds: 250),
  //       pageBuilder: (BuildContext context, Animation<double> animation,
  //           Animation<double> secondaryAnimation) {
  //         return const SizedBox.shrink();
  //       });
  // }

  // void showNoticeAppDialog(
  //     {required String title,
  //     required String message,
  //     required String? dateAndTime,
  //     Color? messageColor,
  //     Widget? dialogContentWidget,
  //     bool shouldDismiss = false,
  //     VoidCallback? onPositiveCallback,
  //     bool? shouldEnableClose,
  //     bool isSessionTimeout = false}) {
  //   showGeneralDialog(
  //       context: context,
  //       barrierDismissible: shouldDismiss,
  //       transitionBuilder: (context, a1, a2, widget) {
  //         return Transform.scale(
  //           scale: a1.value,
  //           child: Opacity(
  //             opacity: a1.value,
  //             child: NoticeAppDialog(
  //               title: title,
  //               description: message,
  //               onPositiveCallback: onPositiveCallback,
  //               descriptionColor: messageColor,
  //               isSessionTimeout: isSessionTimeout,
  //               dateAndTime: dateAndTime.toString(),
  //             ),
  //           ),
  //         );
  //       },
  //       transitionDuration: const Duration(milliseconds: 250),
  //       pageBuilder: (BuildContext context, Animation<double> animation,
  //           Animation<double> secondaryAnimation) {
  //         return const SizedBox.shrink();
  //       });
  // }

  showProgressBar() {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return PopScope(
              canPop: false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      alignment: FractionalOffset.center,
                      child: Lottie.asset(
                        width: 200.w,
                        height: 200.w,
                        fit: BoxFit.contain,
                        AppAssets.loadingAnimation,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }

  hideLoading() {
    if (_isLoadingShow) {
      Navigator.pop(context);
      _isLoadingShow = false;
    }
  }

  void _configureFirebaseNotification() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message?.data != null) {
        // _handleFCM(message);
        //Implement If you want navigate screen to clicking notification app terminate state
        // if (message?.data["type"] == "sometype") {
        //   _handleNotification();
        // }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //Foreground Notification
      log(message.data.toString());
      if (isDoNotify != message.hashCode && !Platform.isIOS) {
        _showNotification(
          DeviceOS.ANDROID,
          fcmMessage: message,
        );
        if (mounted) {
          setState(() {
            isDoNotify = message.hashCode;
          });
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      // log(message?.data.toString() ?? "");
      // _handleFCM(message);
      //Implement If you want navigate screen to clicking notification app background state
      // if (message?.data != null) {
      //   _handleNotification();
      // }
    });
  }

  _configureHuaweiPushNotifications() {
    PushKit.Push.onMessageReceivedStream.listen((message) {
      // final data = jsonDecode(message.data ?? "") as Map<String, dynamic>;
      _showNotification(
        DeviceOS.HUAWEI,
        hcmMessage: message,
      );
    });

    PushKit.Push.onNotificationOpenedApp.listen((remoteMessage) {});
  }

  void _handleNotification() {
    //Navigate Implemantation
    // Navigator.pushNamed(context, Routes.routename);
  }

  Future<void> _showNotification(
    DeviceOS deviceOS, {
    RemoteMessage? fcmMessage,
    PushKit.RemoteMessage? hcmMessage,
  }) async {
    final hcmData = hcmMessage?.data != null
        ? jsonDecode(hcmMessage?.data ?? "") as Map<String, dynamic>
        : {};

    await LocalPushManager.instance?.showNotification(
      LocalNotification(
        deviceOS: deviceOS,
        id: deviceOS == DeviceOS.ANDROID
            ? fcmMessage.hashCode
            : hcmMessage.hashCode,
        title: deviceOS == DeviceOS.ANDROID
            ? fcmMessage?.notification?.title ?? fcmMessage?.data["title"] ?? ""
            : hcmMessage?.notification?.title ?? hcmData["title"] ?? "",
        body: deviceOS == DeviceOS.ANDROID
            ? fcmMessage?.notification?.body ?? fcmMessage?.data["body"] ?? ""
            : hcmMessage?.notification?.body ?? hcmData["body"] ?? "",
      ),
    );
  }

  _launchCaller(String number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

// void _showNotification(RemoteMessage? message) async {
//   if (existMessage != message.hashCode) {
//     existMessage = message.hashCode;
//     await LocalPushManager.instance?.showNotification(
//       LocalNotification(
//         id: message.hashCode,
//         title: message?.data["title"] ?? message?.notification?.title,
//         body: message?.data["body"] ?? message?.notification?.body,
//       ),
//     );
//   }
// }
}
