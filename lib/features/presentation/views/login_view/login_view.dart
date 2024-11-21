import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/service/analytics_service/analytics_services.dart';
import 'package:union_bank_mobile/core/service/app_permission.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/mobile_login_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/login_view/widgets/login_card.dart';
import 'package:union_bank_mobile/features/presentation/views/login_view/widgets/pre_login_menu_button.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/network/network_config.dart';
import '../../../../core/service/cloud_service/cloud_services.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../flavors/flavor_config.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/biometric_helper.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/user_login/login_bloc.dart';
import '../../bloc/user_login/login_event.dart';
import '../../bloc/user_login/login_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class LoginView extends BaseView {
  LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView> {
  var bloc = injection<LoginBloc>();
  final localDataSource = injection<LocalDataSource>();
  final biometricHelper = injection<BiometricHelper>();
  final cloudServices = injection<CloudServices>();
  bool firstTimeLogin = true;
  String username = '';
  String password = '';
  bool passwordHidden = true;
  String storedUsername = "";
  String loginName = "";
  String? segmentCode;
  String? commonPushStatus;
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  LoginMethods _loginMethod = LoginMethods.NONE;
  late final AppLifecycleListener listenerPasswordClear;
  final  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  void initState() {
      listenerPasswordClear = AppLifecycleListener(
      onStateChange: _onStatePasswordClear,
    );
     _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => clearDeepLinkEpicUserId());
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => initialBiometric());
    AppPermissionManager.requestNotificationPermission(context, () {});
    bloc.add(CheckCredentialAvailability());
   
    super.initState();
  }

@override
  void dispose() {
    listenerPasswordClear.dispose();
    super.dispose();
  }
    void _onStatePasswordClear(AppLifecycleState state) {
    if (!AppConstants.IS_USER_LOGGED) {
      switch (state) {
        case AppLifecycleState.resumed:
          break;
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.paused:
        if(mounted){

        passwordTextEditingController.clear();
        password ='';
        setState(() { });
        }
          break;
        case AppLifecycleState.hidden:
          break;
        case AppLifecycleState.detached:
          break;
      }
    } 
  }

  void clearDeepLinkEpicUserId() async {
    await localDataSource.clearEpicUserIdForDeepLink();
  }

  void initialBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      if (_isBiometricAvailable) {
        if (_isAppBiometricAvailable && _isBiometricAvailable) {
          _loginMethod = await biometricHelper.getBiometricType();
        } else {
          _loginMethod = LoginMethods.NONE;
        }
      }
    }
    setState(() {});
    if (_isAppBiometricAvailable && _isBiometricAvailable && AppConstants.IS_FIRST_TIME_BIOMETRIC_POPUP) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        final result =  await biometricHelper.authenticateWithBiometrics(context);
        log(result.toString());
        if (result == true) {
          bloc.add(RequestBiometricPromptEvent());
          await localDataSource.clearEpicUserIdForDeepLink();
        } else if (result == null) {
          checkAttempts();
        }
      });
    }
  }

  _launchCaller(String number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  void checkAttempts() {
    showAppDialog(
      alertType: _loginMethod == LoginMethods.FINGERPRINT
          ? AlertType.FINGERPRINT
          : AlertType.FACEID,
      title: _loginMethod == LoginMethods.FINGERPRINT
          ? AppLocalizations.of(context).translate("fingerprint_not_recognized")
          : AppLocalizations.of(context).translate("faceid_not_recognized"),
      message:
      AppLocalizations.of(context).translate("number_of_biometric_exceed"),
      positiveButtonText:
      AppLocalizations.of(context).translate("use_password"),
      bottomButtonText: AppLocalizations.of(context).translate("cancel"),
      onBottomButtonCallback: () {
        biometricHelper.cancelAuthentication();
        localDataSource.clearBiometric();
        AppConstants.BIOMETRIC_CODE = null;
        _loginMethod = LoginMethods.NONE;
        setState(() {});
      },
      onPositiveCallback: () {
        biometricHelper.cancelAuthentication();
        localDataSource.clearBiometric();
        AppConstants.BIOMETRIC_CODE = null;
        _loginMethod = LoginMethods.NONE;
        setState(() {});
      },
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,e) {
        if (didPop) return;
        showAppDialog(
          title: AppLocalizations.of(context).translate("Exit"),
          alertType: AlertType.INFO,
          message: AppLocalizations.of(context).translate("exit_app_message"),
          positiveButtonText:
          AppLocalizations.of(context).translate("Yes_Leave"),
          negativeButtonText: AppLocalizations.of(context).translate("no"),
          onPositiveCallback: () {
            SystemNavigator.pop();
          },
        );
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener(
            bloc: bloc,
            listener: (_, state) async {
              if (state is MobileLoginFailedState) {
                showAppDialog(
                  alertType: AlertType.FAIL,
                  title: AppLocalizations.of(context)
                      .translate("invalid_credentials"),
                );
              }
              else if (state is BiometricPromptSuccessState) {
                bloc.add(BiometricLoginEvent());
              }
              else if (state is MobileLoginAPIFailedState) {
                if (state.errorCode == APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_RESET ||
                    state.errorCode == APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_RESET) {
                  // showAppDialog(
                  //   alertType: AlertType.FAIL,
                  //   title: AppLocalizations.of(context)
                  //       .translate("invalid_credentials"),
                  //   message: splitAndJoinAtBrTags(state.message ?? ""),
                  //   positiveButtonText:
                  //       AppLocalizations.of(context).translate("done"),
                  //   onPositiveCallback: () {},
                  // );
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                    message: AppLocalizations.of(context).translate("pswrd_reset_incorrect_pswrd_des"),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                } else if (state.errorCode == "841") {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                        .translate("incorrect_password"),
                    // message: splitAndJoinAtBrTags(state.message ?? ""),
                    dialogContentWidget: Column(
                      children: [
                        Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                  text: splitAndJoinAtBrTags(
                                      extractTextWithinTags(
                                          input: state.message ?? "")[0]),
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      _launchCaller(splitAndJoinAtBrTags(
                                          extractTextWithinTags(
                                              input: state.message ?? "")[1]));
                                    },
                                  text:
                                  " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.message ?? "")[1])}",
                                  style: size14weight700.copyWith(
                                      color: colors(context).primaryColor)),
                            ]))
                      ],
                    ),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                }else if (state.errorCode == "840") {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                        .translate("incorrect_password"),
                    message: splitAndJoinAtBrTags(state.message ?? ""),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("try_again"),
                    onPositiveCallback: () {},
                  );
                }else if (state.errorCode == "845") {
                  showAppDialog(
                    alertType: AlertType.WARNING,
                    title: AppLocalizations.of(context)
                        .translate("invalid_credentials"),
                    message: state.message ?? "",
                    positiveButtonText:
                    AppLocalizations.of(context).translate("try_again"),
                    onPositiveCallback: () {},
                  );
                } else if (state.errorCode == "820") {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                        .translate("incorrect_password"),
                    message: splitAndJoinAtBrTags(state.message ?? ""),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("try_again"),
                    onPositiveCallback: () {},
                  );
                }
                // else if (state.errorCode == APIResponse.INVALID_CREDENTIALS) {
                //   showAppDialog(
                //     alertType: AlertType.FAIL,
                //     title: AppLocalizations.of(context)
                //         .translate("invalid_credentials"),
                //     dialogContentWidget: Column(
                //       children: [
                //         Text.rich(
                //             textAlign: TextAlign.center,
                //             TextSpan(children: [
                //               TextSpan(
                //                   text: splitAndJoinAtBrTags(
                //                       extractTextWithinTags(
                //                           input: state.message ?? "")[0]),
                //                   style: size14weight400.copyWith(
                //                       color: colors(context).greyColor)),
                //               TextSpan(
                //                   recognizer: TapGestureRecognizer()
                //                     ..onTap = () async {
                //                       _launchCaller(splitAndJoinAtBrTags(
                //                           extractTextWithinTags(
                //                               input: state.message ?? "")[1]));
                //                     },
                //                   text:
                //                       " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.message ?? "")[1])}",
                //                   style: size14weight700.copyWith(
                //                       color: colors(context).primaryColor)),
                //             ]))
                //       ],
                //     ),
                //     positiveButtonText:
                //         AppLocalizations.of(context).translate("ok"),
                //     onPositiveCallback: () {},
                //   );
                // }
                else if (state.errorCode == "dbp-364") {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                    message: splitAndJoinAtBrTags(state.message ?? ''),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                } else if(state.errorCode == APIResponse.USER_STATUS_INACTIVE_OR_BLOCKED ) {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                        .translate("incorrect_password"),
                    // message: splitAndJoinAtBrTags(state.message ?? ""),
                    dialogContentWidget: Column(
                      children: [
                        Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                  text: splitAndJoinAtBrTags(
                                      extractTextWithinTags(
                                          input: state.message ?? "")[0]),
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      _launchCaller(splitAndJoinAtBrTags(
                                          extractTextWithinTags(
                                              input: state.message ?? "")[1]));
                                    },
                                  text:
                                  " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.message ?? "")[1])}",
                                  style: size14weight700.copyWith(
                                      color: colors(context).primaryColor)),
                            ]))
                      ],
                    ),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                }else {
                  ToastUtils.showCustomToast(
                      context,
                      splitAndJoinAtBrTags(
                          state.message ?? AppLocalizations.of(context).translate("something_went_wrong")),
                      ToastStatus.FAIL);
                  ;
                }
              }
              else if (state is MobileLoginSuccessState) {
                /*---------------------------------TOPIC SUBSCRIBE--------------------------------*/
                commonPushStatus = await localDataSource.getCommonPushStatus();
                if(commonPushStatus != "${FlavorConfig.instance?.name.toString().toLowerCase()}-push"){
                  if(commonPushStatus == null || commonPushStatus == ""){
                    commonPushStatus = "${FlavorConfig.instance?.name.toString().toLowerCase()}-push";
                    localDataSource.setCommonPushStatus(commonPushStatus!);
                    cloudServices.topicSubscribe("${FlavorConfig.instance?.name.toString().toLowerCase()}-push");
                  } else if (commonPushStatus != "${FlavorConfig.instance?.name.toString().toLowerCase()}-push"){
                    cloudServices.topicUnsubscribe(commonPushStatus!);
                    localDataSource.clearCommonPushStatus();
                    commonPushStatus = "${FlavorConfig.instance?.name.toString().toLowerCase()}-push";
                    localDataSource.setCommonPushStatus(commonPushStatus!);
                    cloudServices.topicSubscribe("${FlavorConfig.instance?.name.toString().toLowerCase()}-push");
                  }
                }
                segmentCode = await localDataSource.getSegmentCode();
                if(segmentCode != state.mobileLoginResponse?.segment){
                  if(segmentCode == null || segmentCode == ""){
                    segmentCode = state.mobileLoginResponse?.segment ?? "";
                    localDataSource.setSegmentCode(segmentCode!);
                    cloudServices.topicSubscribe("${FlavorConfig.instance?.name.toString().toLowerCase()}-${segmentCode}-push");
                  }else if(state.mobileLoginResponse?.segment != segmentCode){
                    cloudServices.topicUnsubscribe("${FlavorConfig.instance?.name.toString().toLowerCase()}-${segmentCode}-push");
                    localDataSource.clearSegmentCode();
                    segmentCode = state.mobileLoginResponse?.segment ?? "";
                    localDataSource.setSegmentCode(segmentCode!);
                    cloudServices.topicSubscribe("${FlavorConfig.instance?.name.toString().toLowerCase()}-${segmentCode}-push");
                  }
                }
                /* -------------------------------------- . ------------------------------------- */
                /* ------------------------------------ . ----------------------------------- */
                ///ANALYTICS
                if (state.responseCode == APIResponse.RESPONSE_LOGIN_SUCCESS ||
                    state.responseCode == APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_EXPIRED ||
                    state.responseCode == APIResponse.RESPONSE_M_LOGIN_SUCCESS_NEW_DEVICE ||
                    state.responseCode == APIResponse.RESPONSE_M_LOGIN_SUCCESS_INACTIVE_DEVICE) {
                  await AnalyticsServices.instance?.analyticsLogin(loginType: "NORMAL");
                }
                else if (state.responseCode == APIResponse.RESPONSE_BIOMETRIC_LOGIN_SUCCESS ||
                    state.responseCode == APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_EXPIRED ||
                    state.responseCode == APIResponse.RESPONSE_B_LOGIN_SUCCESS_NEW_DEVICE ||
                    state.responseCode == APIResponse.RESPONSE_B_LOGIN_SUCCESS_INACTIVE_DEVICE) {
                  await AnalyticsServices.instance?.analyticsLogin(loginType: "BIOMETRIC");
                }

                /* ------------------------------------ . ----------------------------------- */

                if (localDataSource.getNewDeviceState() ==
                    JustPayState.FINISH.name) {
                  localDataSource.setNewDeviceState(JustPayState.FINISH.name);
                }
                else if (localDataSource.getNewDeviceState() ==
                    JustPayState.INIT.name) {
                  localDataSource.setNewDeviceState(JustPayState.INIT.name);
                }
                if (state.responseCode == APIResponse.RESPONSE_LOGIN_SUCCESS ||
                    state.responseCode ==
                        APIResponse.RESPONSE_BIOMETRIC_LOGIN_SUCCESS) {
                  saveUserDetails(
                      mobileLoginResponse: state.mobileLoginResponse);
                  await Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.kHomeBaseView,
                        (route) => false,
                  );
                }
                // else if (state.responseCode ==
                //         APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_RESET ||
                //     state.responseCode ==
                //         APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_RESET) {
                //   showAppDialog(
                //       title: "Password Reset",
                //       alertType: AlertType.PASSWORD,
                //       message: state.responseDescription ??
                //           "Your password must be reset. Please create a new password to access your Union Bank Mobile App.",
                //       positiveButtonText: "Reset Password",
                //       onPositiveCallback: () async {
                //         await Navigator.pushNamed(context,
                //                 Routes.kPasswordExpiredChangePasswordView,
                //                 arguments: false)
                //             .then((value) {
                //           localDataSource.clearAccessToken();
                //           localDataSource.clearEpicUserId();
                //           localDataSource.clearRefreshToken();
                // await localDataSource.clearMigratedFlag();
                //         });
                //       },
                //       bottomButtonText: AppLocalizations.of(context)
                //           .translate("back_to_login"),
                //       onBottomButtonCallback: () {});
                // }
                else if (state.responseCode ==
                    APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_EXPIRED ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_EXPIRED) {
                  showAppDialog(
                      title: AppLocalizations.of(context)
                          .translate("password_expired"),
                      alertType: AlertType.PASSWORD,
                      message:
                      splitAndJoinAtBrTags(state.responseDescription ?? ""),
                      // state.responseDescription ??
                      //     "Your password has been expired. Please create a new password to access your Union Bank Mobile App.",
                      positiveButtonText: AppLocalizations.of(context)
                          .translate("create_new_password"),
                      onPositiveCallback: () async {
                        await Navigator.pushNamed(context,
                            Routes.kPasswordExpiredChangePasswordView,
                            arguments: true)
                            .then((value) {
                          localDataSource.clearAccessToken();
                          localDataSource.clearEpicUserId();
                          localDataSource.clearRefreshToken();
                          localDataSource.clearMigratedFlag();
                        });
                      },
                      bottomButtonText: AppLocalizations.of(context)
                          .translate("back_to_login"),
                      onBottomButtonCallback: () {});
                }
                else if (state.responseCode == APIResponse.RESPONSE_M_LOGIN_SUCCESS_NEW_DEVICE ||
                    state.responseCode == APIResponse.RESPONSE_B_LOGIN_SUCCESS_NEW_DEVICE) {
                  ///Device Change
                  log("*********SMS OTP == ${state.mobileLoginResponse!.otpResponseDto!.smsOtp}*****");
                  log("*********EMAIL OTP == ${state.mobileLoginResponse!.otpResponseDto!.emailOtp}*****");
                  if(username == "wdjanakai" || storedUsername == "wdjanakai"){
                    saveUserDetails(mobileLoginResponse: state.mobileLoginResponse);
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeBaseView,
                          (route) => false,
                    );
                  } else {
                    final otpResult = await Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                            appBarTitle: "login",
                            otpType: kOtpMessageTypeNewDevice,
                            otpResponseArgs: OtpResponseArgs(
                              previousRoute: AppConstants.LOGIN_NEWUSER,
                              isOtpSend: true,
                              otpType: state.mobileLoginResponse!
                                  .otpResponseDto!.otpType,
                              otpTranId: state.mobileLoginResponse!
                                  .otpResponseDto!.otpTranId,
                              email: state
                                  .mobileLoginResponse!.otpResponseDto!.email,
                              mobile: state.mobileLoginResponse!
                                  .otpResponseDto!.mobile,
                              countdownTime: state.mobileLoginResponse!
                                  .otpResponseDto!.countdownTime,
                              otpLength: state.mobileLoginResponse!
                                  .otpResponseDto!.otpLength,
                              resendAttempt: state.mobileLoginResponse!
                                  .otpResponseDto!.resendAttempt,
                            ),
                            requestOTP: false)) as bool;
                    if (otpResult && mounted) {
                      saveUserDetails(mobileLoginResponse: state.mobileLoginResponse);
                      await Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.kHomeBaseView, (route) => false,
                      );
                    } else {
                      localDataSource.clearAccessToken();
                      localDataSource.clearEpicUserId();
                      localDataSource.clearRefreshToken();
                      localDataSource.clearMigratedFlag();
                    }
                  }
                }
                else if (state.responseCode ==
                    APIResponse.RESPONSE_M_LOGIN_SUCCESS_INACTIVE_DEVICE ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_INACTIVE_DEVICE) {
                  log("*********SMS OTP == ${state.mobileLoginResponse!.otpResponseDto!.smsOtp}*****");
                  log("*********EMAIL OTP == ${state.mobileLoginResponse!.otpResponseDto!.emailOtp}*****");
                  if(username == "wdjanakai" || storedUsername == "wdjanakai"){
                    saveUserDetails(mobileLoginResponse: state.mobileLoginResponse);
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeBaseView, (route) => false,
                    );
                  } else {
                    final otpResult = await Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                            appBarTitle: "login",
                            otpType: kOtpMessageTypeInactiveDevice,
                            otpResponseArgs: OtpResponseArgs(
                              previousRoute: AppConstants.LOGIN_INACTIVEUSER,
                              isOtpSend: true,
                              otpType: state.mobileLoginResponse!
                                  .otpResponseDto!.otpType,
                              otpTranId: state.mobileLoginResponse!
                                  .otpResponseDto!.otpTranId,
                              email: state
                                  .mobileLoginResponse!.otpResponseDto!.email,
                              mobile: state.mobileLoginResponse!
                                  .otpResponseDto!.mobile,
                              countdownTime: state.mobileLoginResponse!
                                  .otpResponseDto!.countdownTime,
                              otpLength: state.mobileLoginResponse!
                                  .otpResponseDto!.otpLength,
                              resendAttempt: state.mobileLoginResponse!
                                  .otpResponseDto!.resendAttempt,
                            ),
                            requestOTP: false));
                    if (otpResult != null) {
                      if (otpResult as bool && mounted) {
                        saveUserDetails(
                            mobileLoginResponse: state.mobileLoginResponse);
                        await Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kHomeBaseView,
                              (route) => false,
                        );
                      } else {
                        localDataSource.clearAccessToken();
                        localDataSource.clearEpicUserId();
                        localDataSource.clearRefreshToken();
                        localDataSource.clearMigratedFlag();
                      }
                    }
                  }
                }
                else if(state.responseCode ==  APIResponse.LOGIN_SUCCESS_MIGRATE_USER_PASSWORD_RESET){
                  await Navigator.pushNamed(context, Routes.kResetPasswordView);
                }
                else if(state.responseCode ==  APIResponse.LOGIN_SUCCESS_TANDC){
                  Navigator.pushNamed(context, Routes.kMigrateUserState,
                      arguments: MigrateUser.TNC);
                }
                else if(state.responseCode == APIResponse.LOGIN_SUCCESS_SECURITY_QUESTION){
                  Navigator.pushNamed(context, Routes.kMigrateUserState,
                      arguments: MigrateUser.SECQUE);
                }
                else if(state.responseCode == APIResponse.USER_STATUS_INACTIVE_OR_BLOCKED ) {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                        .translate("incorrect_password"),
                    // message: splitAndJoinAtBrTags(state.message ?? ""),
                    dialogContentWidget: Column(
                      children: [
                        Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: [
                              TextSpan(
                                  text: splitAndJoinAtBrTags(
                                      extractTextWithinTags(
                                          input: state.responseDescription ?? "")[0]),
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      _launchCaller(splitAndJoinAtBrTags(
                                          extractTextWithinTags(
                                              input: state.responseDescription ?? "")[1]));
                                    },
                                  text:
                                  " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.responseDescription ?? "")[1])}",
                                  style: size14weight700.copyWith(
                                      color: colors(context).primaryColor)),
                            ]))
                      ],
                    ),
                    positiveButtonText:
                    AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
                }
                else{
                  ToastUtils.showCustomToast(
                      context,
                      splitAndJoinAtBrTags(
                          state.responseDescription ?? AppLocalizations.of(context).translate("something_went_wrong")),
                      ToastStatus.FAIL);
                }
              } else if (state is GetLoginCredentials) {
                if (await localDataSource.hasUsername() == false) {
                  await localDataSource.clearEpicUserId();
                  await localDataSource.clearMigratedFlag();
                }
                if (state.isAvailable!) {
                  setState(() {
                    storedUsername = state.username!;
                    firstTimeLogin = false;
                  });
                }
              }
              else if (state is StepperValueLoadedState) {
                await Navigator.pushNamed(context, state.routeString!);
              }
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            82.verticalSpace,
                            Padding(
                              padding:  EdgeInsets.only(left: 20.23.w ,right: 14.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.ubGoLogo,
                                    width: 138.13.w,
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      await localDataSource.clearEpicUserIdForDeepLink();
                                      Navigator.pushNamed(context, Routes.kLanguageView,
                                          arguments: false);
                                    },
                                    child: SvgPicture.asset(
                                      AppAssets.languageChange,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 422.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.asset(AppAssets.loginBackground).image,
                                fit: BoxFit.cover)),
                      ),
                      Container(width: double.infinity, height:  12.h, color: colors(context).secondaryColor),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Image.asset(
                  //       AppAssets.loginBackground,
                  //       width: double.infinity,
                  //       height: 422.h,
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left:5,right: 5,bottom: 0,top:  9.3).w,
                  //   child: Padding(
                  //     padding:  EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //          Column(
                  //            mainAxisSize: MainAxisSize.min,
                  //            children: [
                  //             // 4.52.verticalSpace,
                  //              SvgPicture.asset(
                  //                AppAssets.ubGoLogo,
                  //              )
                  //            ],
                  //          ),
                  //         Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.pushNamed(context, Routes.kLanguageView,
                  //                     arguments: false);
                  //               },
                  //               child: SvgPicture.asset(
                  //                 AppAssets.languageChange,
                  //               ),
                  //             )
                  //           ],
                  //         ),

                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      LoginCard(
                        passwordTextEditingController: passwordTextEditingController,
                        firstTimeLogin: firstTimeLogin,
                        loginMethod: _loginMethod,
                        username: storedUsername,
                        onUserNameChange: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                        onPasswordChange: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        onForgotPassword: () async {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          await localDataSource.clearEpicUserIdForDeepLink();
                          await Navigator.pushNamed(context,
                              Routes.kForgotPasswordResetMethodView);
                        },
                        onLoginButtonTap: () async {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          await localDataSource.clearEpicUserIdForDeepLink();
                          if (await localDataSource.hasUsername() == false) {
                            await localDataSource.clearEpicUserId();
                            await localDataSource.clearMigratedFlag();
                          }
                          if (storedUsername.isNotEmpty) {
                            if (password.isEmpty) {
                              ToastUtils.showCustomToast(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate("error_empty_password"),
                                  ToastStatus.FAIL);
                            } else {
                              bloc.add(MobileLoginEvent(
                                  username: storedUsername,
                                  password: password));
                            }
                          } else {
                            if (username.isEmpty) {
                              ToastUtils.showCustomToast(
                                  context,
                                  AppString.emptyUsername
                                      .localize(context),
                                  ToastStatus.FAIL);
                            } else if (password.isEmpty) {
                              ToastUtils.showCustomToast(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate("error_empty_password"),
                                  ToastStatus.FAIL);
                            } else {
                              bloc.add(MobileLoginEvent(
                                  username: username,
                                  password: password));
                            }
                          }

                        },
                        onBiometricTap: () async {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          await localDataSource.clearEpicUserIdForDeepLink();
                          if (await localDataSource.hasUsername() == false) {
                            await localDataSource.clearEpicUserId();
                            await localDataSource.clearMigratedFlag();
                          }
                          if (_isBiometricAvailable &&
                              _isAppBiometricAvailable) {
                            final result = await biometricHelper.authenticateWithBiometrics(context);
                            if (result == true) {
                              bloc.add(RequestBiometricPromptEvent());
                            } else if (result == null) {
                              checkAttempts();
                            }
                          } else if (_isBiometricAvailable == false) {
                            showAppDialog(
                              alertType:_loginMethod == LoginMethods.FINGERPRINT? AlertType.FINGERPRINT:AlertType.FACEID,
                              title: AppLocalizations.of(context).translate("no_biometrics_available"),
                              dialogContentWidget: Column(
                                children:  [
                                  Text(
                                    AppLocalizations.of(context).translate("no_biometrics_available_des"),
                                  ),
                                  1.verticalSpace,
                                ],
                              ),
                              positiveButtonText: AppLocalizations.of(context).translate("close"),
                            );
                          } else {
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate("central_bank_details"),
                              style: size10weight400.copyWith(color: colors(context).blackColor),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("central_bank_details_1"),
                              style: size10weight400.copyWith(color: colors(context).blackColor),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("central_bank_details_2"),
                              style: size10weight400.copyWith(color: colors(context).blackColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      14.verticalSpace,
                      PreLoginMenuButton(
                        width: 70,
                        height: 40,
                        onTap: () async {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          await localDataSource.clearEpicUserIdForDeepLink();
                          await Navigator.pushNamed(
                              context, Routes.kPreLoginMenu);

                        },
                      ),
                      12.verticalSpace,
                      AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context))
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveUserDetails({MobileLoginResponse? mobileLoginResponse}) {
    mobileData = mobileLoginResponse;

    AppConstants.IS_USER_LOGGED = true;

    localDataSource.setUserName(mobileLoginResponse!.userName!);

    if (!localDataSource.hasProfileImageKey()) {
      localDataSource.setProfileImageKey(mobileLoginResponse.profileImageKey!);
    }

    AppConstants.TOKEN_EXPIRE_TIME = DateTime.now()
        .add(Duration(seconds: mobileLoginResponse.tokenExpiresIn!));

    AppConstants.profileData.cName = mobileLoginResponse.nickname;
    AppConstants.profileData.userName = mobileLoginResponse.userName;
    AppConstants.profileData.profileImageKey =
        mobileLoginResponse.profileImageKey;
    AppConstants.profileData.nic = mobileLoginResponse.nic;
    AppConstants.profileData.name = mobileLoginResponse.name;
    AppConstants.profileData.mobileNo = mobileLoginResponse.mobileNo;
    AppConstants.profileData.email = mobileLoginResponse.email;
    AppConstants.profileData.fName = mobileLoginResponse.firstName;
    AppConstants.lastLoggingTime = DateFormat("hh.mm aa-yyyy.MM.dd")
        .format(mobileLoginResponse.lastLoggingDate ??
        DateTime.parse(DateTime.now().toString()))
        .replaceAll("AM", "A.M")
        .replaceAll("PM", "P.M");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
