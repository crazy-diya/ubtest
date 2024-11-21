// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/mask.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/just_pay_account_onboarding_response.dart';
import '../../../data/models/responses/otp_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../bloc/otp/otp_event.dart';
import '../../bloc/otp/otp_state.dart';
import '../../widgets/otp_count_down.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class OtpResponseArgs {
  bool isOtpSend;
  String? otpTranId;
  String? otpType;
  String? email;
  String? mobile;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;
  String? previousRoute;

  OtpResponseArgs({
    this.isOtpSend = false,
    this.otpTranId,
    this.otpType,
    this.email,
    this.mobile,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.previousRoute,
  });
}

class OTPViewArgs {
  final OtpResponseArgs? otpResponseArgs;
  final String? otpType;
  final bool requestOTP;
  final String? routeName;
  final String? appBarTitle;
  final String phoneNumber;
  final String email;
  final JustPayAccountOnboardingResponse? justPayAccountOnboardingDto;
  final bool isSingleOTP;
  final String? id;
  final String? action;
  final String? title;
  final List<int>? ids;
  final bool? iconChange;

  OTPViewArgs({
    this.otpResponseArgs,
    this.otpType,
    this.routeName,
    this.phoneNumber = "",
    this.email = "",
    this.appBarTitle,
    this.title,
    this.requestOTP = false,
    this.justPayAccountOnboardingDto,
    this.isSingleOTP = true,
    this.id,
    this.action,
    this.ids,
    this.iconChange = false,
  });
}

class OtpView extends BaseView {
  final OTPViewArgs otpArgs;

  OtpView({required this.otpArgs});

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends BaseViewState<OtpView> {
  var bloc = injection<OTPBloc>();
  final localDataSource = injection<LocalDataSource>();

  bool _isSmsPinCodeComplete = false;
  bool _isEmailPinCodeComplete = false;
  OTPCountDown? _otpCountDown;
  bool _isCountDownFinished = false;
  String? _countDown;
  String _otpTranId = '';
  String _otpType = "";
  String? _mobileNumber;
  String? _email;
  OtpResponse? otpResponse;
  bool buttonClick = false;
  int _otpLength = 6;
  int _otpTimeInMS = 60 * 1000;
  int resendAttempts = 0;
  bool firstAttempt = true;
  String? smsOtp;
  String? emailOtp;
  final TextEditingController _smsOtpController = TextEditingController();
  final TextEditingController _emailOtpController = TextEditingController();
  int invalidAttempst = 3;

  //OTP TimeOut
  late final AppLifecycleListener listener;
  int countDownTimeMs = 0;
  int staticCountDown = 0;
  DateTime? initialDateTime;

  @override
  void initState() {
    super.initState();
     listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    _smsOtpController.addListener(_onSmsPinCodeChanged);
    _emailOtpController.addListener(_onEmailPinCodeChanged);
    if (widget.otpArgs.requestOTP == true) {
      bloc.add(RequestOTPEvent(OtpType: widget.otpArgs.otpType));
      if (widget.otpArgs.otpResponseArgs?.isOtpSend == true) {
        // _startCountDown();
      }
    } else if (widget.otpArgs.otpResponseArgs != null) {
      updateUI(widget.otpArgs.otpResponseArgs);
      _otpTranId = widget.otpArgs.otpResponseArgs!.otpTranId!;

      if (widget.otpArgs.otpResponseArgs?.isOtpSend == true) {
        _startCountDown();
      }
    }

   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        log("RESUME");
        if (initialDateTime != null && mounted) {
          Duration? initial = DateTime.now().difference(initialDateTime!);
          countDownTimeMs = 0;
          countDownTimeMs = staticCountDown - initial.inMilliseconds;
          _countDown = _otpCountDown?.formattedTime(countDownTimeMs);
          _otpTimeInMS = countDownTimeMs;
          setState(() {});
          log("${_otpTimeInMS} STATIC");
          if (0 < countDownTimeMs) {
            _startCountDown(isNew: false);
          } else {
            if (mounted) {
              _otpCountDown?.cancelTimer();
              _countDown = "00:00";
              countDownTimeMs = 0;
              _otpTimeInMS = 0;
              initialDateTime = null;
              _isCountDownFinished = true;
              setState(() {});
            }
          }
        }
        break;
      case AppLifecycleState.inactive:
        log("INACTIVE");
        break;
      case AppLifecycleState.paused:
        log("PAUSE");
        break;
      case AppLifecycleState.hidden:
        log("HIDDEN");
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  updateUI(OtpResponseArgs? otpResponseDto) {
    setState(() {
      _mobileNumber = otpResponseDto?.mobile;
      _email = otpResponseDto?.email;
      _otpTimeInMS = otpResponseDto!.countdownTime != null
          ? otpResponseDto.countdownTime! * 1000
          : AppConstants.otpTimeout;
      _otpLength = otpResponseDto.otpLength!;
      _otpTranId = otpResponseDto.otpTranId!;
      _otpType = otpResponseDto.otpType!;

      if (firstAttempt) {
        resendAttempts = otpResponseDto.resendAttempt!;
        firstAttempt = false;
      }
    });
  }

  void _startCountDown({bool isNew = true, bool invalidAttemptReset = false}) {
    if (isNew) {
      if (mounted) {
        initialDateTime = DateTime.now();
        staticCountDown = _otpTimeInMS;
        setState(() {});
      }
    }

    _otpCountDown?.cancelTimer();
    _isCountDownFinished = false;
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDownMs: (countDown) {
        countDownTimeMs = countDown;
        setState(() {});
      },
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        _otpCountDown?.cancelTimer();
        _countDown = "00:00";
        countDownTimeMs = 0;
        _otpTimeInMS = 0;
        initialDateTime = null;
        _isCountDownFinished = true;
        if(invalidAttempst != 0){
          showAppDialog(
            alertType: AlertType.FAIL,
            isSessionTimeout: true,
            title: AppLocalizations.of(context).translate("otp_expired"),
            message: AppLocalizations.of(context).translate("otp_expired_des"),
          );
        }
        if (invalidAttemptReset) {
          invalidAttempst = 3;
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    if (mounted) {
      if (_otpCountDown != null) {
        _otpCountDown!.cancelTimer();
      }
      _smsOtpController.dispose();
      _emailOtpController.dispose();
    }
    super.dispose();
  }

  void _onSmsPinCodeChanged() {
    setState(() {
      _isSmsPinCodeComplete =
          _smsOtpController.text.length == _otpLength ? true : false;
    });
  }

  void _onEmailPinCodeChanged() {
    setState(() {
      _isEmailPinCodeComplete =
          _emailOtpController.text.length == _otpLength ? true : false;
    });
  }

  // void saveLocal()  {
  //   localDataSource.setOtpHandler(OtpHandler(
  //       previousRoute: widget.otpArgs.otpResponseArgs?.previousRoute,
  //       otpSendTime: DateTime.now(),
  //       isResendAttemptOver: false,
  //       otpTranId: _otpTranId,
  //       otpType: widget.otpArgs.otpType,
  //       email: widget.otpArgs.otpResponseArgs?.email,
  //       mobile: widget.otpArgs.otpResponseArgs?.mobile,
  //       resendAttempt: resendAttempts,
  //       countdownTime: _countDown,
  //       otpLength: _otpLength));
  // }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        // saveLocal();
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
        appBar: UBAppBar(
          onBackPressed: () async {
            // saveLocal();
            Navigator.pop(context, false);
          },
          title: widget.otpArgs.appBarTitle != null
              ? AppLocalizations.of(context)
                  .translate(widget.otpArgs.appBarTitle!)
              : '',
        ),
        body: BlocProvider<OTPBloc>(
          create: (_) => bloc,
          child: BlocListener<OTPBloc, BaseState<OTPState>>(
            bloc: bloc,
            listener: (_, state) {
              if (state is OTPVerificationSuccessState) {
                _smsOtpController.clear();
                _emailOtpController.clear();
                _otpCountDown?.cancelTimer();
                localDataSource.clearOtpHandler();
                switch (widget.otpArgs.routeName) {
                  case Routes.kUBSetupLoginDetailsView:
                    Navigator.pushReplacementNamed(
                        context, Routes.kUBSetupLoginDetailsView,
                        arguments: widget.otpArgs.appBarTitle);
                    break;
                  case Routes.kJustPayUserScheduleForVerificationView:
                    Navigator.pushReplacementNamed(context,
                        Routes.kJustPayUserScheduleForVerificationView);
                    break;
                  case Routes.kForgotPasswordCreateNewPasswordView:
                    Navigator.pushReplacementNamed(
                        context, Routes.kForgotPasswordCreateNewPasswordView);
                    break;
                  default:
                    Navigator.pop(context, true);
                }
              } else if (state is OTPVerificationFailedState) {
                _smsOtpController.clear();
                _emailOtpController.clear();

                if (invalidAttempst == 0) {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context)
                        .translate("limit_exceeded"),
                    message: _countDown != "00:00"
                        // ? "Maximum allowed limit for OTP retrials exceeded. Please try again after $_countDown seconds"
                        ? AppLocalizations.of(context).translate("maximun_allowed_otp_attempts")
                        : AppLocalizations.of(context).translate("maximun_allowed_otp_attempts"),
                    onPositiveCallback: () {
                      _otpTimeInMS = 60000;
                      _startCountDown(invalidAttemptReset: true);
                    },
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  );
                } else if (state.code == "dbp-576") {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    isSessionTimeout: true,
                    title:
                        AppLocalizations.of(context).translate("incorrect_oTP"),
                    message: splitAndJoinAtBrTags(state.message ??
                        "${AppLocalizations.of(context).translate("otp_incorrect_des_1")} $invalidAttempst ${AppLocalizations.of(context).translate("otp_incorrect_des_2")}"),
                    onPositiveCallback: () {},
                    positiveButtonText:
                        AppLocalizations.of(context).translate("try_again"),
                  );
                } else {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                    message: state.message,
                    onPositiveCallback: () {},
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  );
                }
              } else if (state is OTPRequestSuccessState) {
                _mobileNumber = state.otpResponse!.mobile!;
                otpResponse = state.otpResponse!;
                _otpTranId = state.otpResponse!.otpTranId!;
                _otpTimeInMS = state.otpResponse?.countdownTime != null
                    ? (state.otpResponse!.countdownTime! * 1000)
                    : AppConstants.otpTimeout;
                _otpLength = state.otpResponse!.otpLength!;
                _otpType = state.otpResponse!.otpType!;
                if (buttonClick == false) {
                  resendAttempts = state.otpResponse!.resendAttempt ?? 3;
                }
                if (state.otpResponse!.email != null ||
                    state.otpResponse!.email != "") {
                  _email = state.otpResponse!.email!;
                }
                setState(() {});
                _startCountDown();
              } else if (state is OTPRequestFailedState) {
                _smsOtpController.clear();
                _emailOtpController.clear();
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
                Navigator.pop(context, false);
              }
            },
            child: Padding(
               padding:  EdgeInsets.fromLTRB(20.w,0,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                           40.verticalSpace,
                          SizedBox(
                            height: 200.w,
                            child: SvgPicture.asset(
                              AppAssets.ubOnboardingOtp,
                               width: 200.w,
                               height: 200.w,
                            ),
                          ),
                          28.verticalSpace,
                          if (widget.otpArgs.title != null)
                            Padding(
                               padding:
                                const EdgeInsets.symmetric(horizontal: 20).w,
                              child: Text(
                                textAlign: TextAlign.center,
                                widget.otpArgs.title ?? "",
                                style: size18weight700.copyWith(
                                  color: colors(context).greyColor,
                                ),
                              ),
                            ),
                          if (widget.otpArgs.isSingleOTP)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20).w,
                              child: Text(
                                textAlign: TextAlign.center,
                                "${AppLocalizations.of(context).translate("enter_the_otp")}$_otpLength${AppLocalizations.of(context).translate("otp_you_recieved")}",
                                style: size18weight700.copyWith(
                                  color: colors(context).greyColor,
                                ),
                              ),
                            ),
                          12.verticalSpace,

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.otpArgs.isSingleOTP == false
                                      ? "${AppLocalizations.of(context).translate("we_sent_two_different")}$_otpLength${AppLocalizations.of(context).translate("code_to_your")}"
                                      : "${AppLocalizations.of(context).translate("we_sent_a")}$_otpLength${AppLocalizations.of(context).translate("code_to_your")}",
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),
                                if (_mobileNumber != "" &&
                                    _mobileNumber != null)
                                  TextSpan(
                                    text:
                                    _mobileNumber?.length == 10 && _mobileNumber!.startsWith("07") ?
                                    " +94${Mask().maskMobileNumber(_mobileNumber ?? "")}" :
                                    " ${Mask().maskMobileNumber(_mobileNumber ?? "")}",
                                        // " +94 ${Mask().maskMobileNumber(_mobileNumber ?? "")}",
                                    style: size16weight700.copyWith(
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                                TextSpan(
                                  text: widget.otpArgs.isSingleOTP == false
                                      ? " ${AppLocalizations.of(context).translate("otp_sent_mail_des_1")}"
                                      : " ${AppLocalizations.of(context).translate("otp_sent_mail_des_2")}",
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),
                                if (_email != "" && _email != null)
                                  TextSpan(
                                    text:
                                        " ${Mask().maskEmailAddress(_email ?? "")}",
                                    style: size16weight700.copyWith(
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (!widget.otpArgs.isSingleOTP) 32.verticalSpace,
                          if (!widget.otpArgs.isSingleOTP)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20).w,
                              child: Text(
                                textAlign: TextAlign.center,
                                "${AppLocalizations.of(context).translate("enter_the_otp")}$_otpLength${AppLocalizations.of(context).translate("sms_you_recieved")}",
                                style: size18weight700.copyWith(
                                  color: colors(context).greyColor,
                                ),
                              ),
                            ),
                          !widget.otpArgs.isSingleOTP
                              ? 13.71.verticalSpace
                              : 70.71.verticalSpace,
                          PinCodeTextField(
                            textStyle: size24weight700.copyWith(
                                color: colors(context).blackColor),
                            cursorColor: colors(context).blackColor,
                            mainAxisAlignment: MainAxisAlignment.center,
                            autoDisposeControllers: false,
                            controller: _smsOtpController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            appContext: context,
                            length: _otpLength,
                            pinTheme: PinTheme.defaults(
                                fieldHeight: 32,
                                activeBorderWidth: 1,
                                borderWidth: 1,
                                selectedBorderWidth: 1,
                                disabledBorderWidth: 1,
                                inactiveBorderWidth: 1,
                                errorBorderWidth: 1,
                                fieldWidth: 38,
                                fieldOuterPadding: EdgeInsets.only(left: 12),
                              selectedColor: colors(context).secondaryColor300!,
                              inactiveColor: colors(context).secondaryColor300!,
                              activeColor: colors(context).secondaryColor300!,
                            ),
                            onChanged: (value) {
                              smsOtp = value;
                              setState(() {});
                            },
                            onCompleted: (_) {
                              if ((smsOtp?.length == _otpLength &&
                                      emailOtp?.length == _otpLength) ||
                                  widget.otpArgs.isSingleOTP == true) {
                                if (invalidAttempst != 0 && _isCountDownFinished == false) {
                                  setState(() {
                                    invalidAttempst--;
                                    String? otp;
                                    if (widget.otpArgs.isSingleOTP) {
                                      otp = smsOtp;
                                      smsOtp = null;
                                      emailOtp = null;
                                    }
                                    bloc.add(OTPVerificationEvent(
                                        id: widget.otpArgs.id,
                                        ids: widget.otpArgs.ids,
                                        action: widget.otpArgs.action,
                                        smsOtp: smsOtp,
                                        emailOtp: emailOtp,
                                        otp: otp,
                                        otpType: widget.otpArgs.otpType,
                                        otpTranId: _otpTranId));
                                  });
                                }
                              }
                            },
                          ),
                          // if (_isCountDownFinished && resendAttempts != 0)
                          //   GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         resendAttempts--;
                          //         _smsOtpController.clear();
                          //         _emailOtpController.clear();
                          //         buttonClick = true;
                          //         invalidAttempst = 3;
                          //       });
                          //       setState(() {
                          //         bloc.add(RequestOTPEvent(
                          //             OtpType:
                          //                 widget.otpArgs.otpType ?? _otpType));
                          //       });
                          //     },
                          //     child: Text(
                          //       "Resend Code",
                          //       style: size14weight700.copyWith(
                          //         color: colors(context).primaryColor,
                          //       ),
                          //     ),
                          //   )
                          // else if (resendAttempts == 0)
                          //   Text(
                          //     "Resend Code",
                          //     style: size14weight400.copyWith(
                          //       color: colors(context).greyColor100,
                          //     ),
                          //   )
                          16.verticalSpace,
                          if (!_isCountDownFinished && resendAttempts != 0)
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                          .translate("resend_code_in"),
                                      style: size14weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: (_countDown != null)
                                          ? '${_countDown == "00:00" ? "" : _countDown}'
                                          : '',
                                      style: size14weight700.copyWith(
                                        color: colors(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (!widget.otpArgs.isSingleOTP)
                            Column(
                              children: [
                                if (!widget.otpArgs.isSingleOTP)
                                  32.verticalSpace,
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20)
                                          .w,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "${AppLocalizations.of(context).translate("enter_the_otp")}$_otpLength${AppLocalizations.of(context).translate("email_you_recieved")}",
                                    style: size18weight700.copyWith(
                                      color: colors(context).greyColor,
                                    ),
                                  ),
                                ),
                                13.71.verticalSpace,
                                PinCodeTextField(
                                  textStyle: size24weight700.copyWith(
                                      color: colors(context).blackColor),
                                  cursorColor: colors(context).blackColor,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  autoDisposeControllers: false,
                                  controller: _emailOtpController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  appContext: context,
                                  length: _otpLength,
                                  pinTheme: PinTheme.defaults(
                                fieldHeight: 32,
                                activeBorderWidth: 1,
                                borderWidth: 1,
                                selectedBorderWidth: 1,
                                disabledBorderWidth: 1,
                                inactiveBorderWidth: 1,
                                errorBorderWidth: 1,
                                fieldWidth: 38,
                                fieldOuterPadding: EdgeInsets.only(left: 12),
                                    selectedColor:
                                        colors(context).secondaryColor300!,
                                    inactiveColor:
                                        colors(context).secondaryColor300!,
                                    activeColor:
                                        colors(context).secondaryColor300!,
                                  ),
                                  onChanged: (value) {
                                    emailOtp = value;
                                    setState(() {});
                                  },
                                  onCompleted: (_) {
                                    if ((smsOtp?.length == _otpLength) &&
                                        (emailOtp?.length == _otpLength)) {
                                      if (invalidAttempst != 0 && _isCountDownFinished == false) {
                                        setState(() {
                                          invalidAttempst--;
                                          String? otp;
                                          bloc.add(OTPVerificationEvent(
                                              id: widget.otpArgs.id,
                                              ids: widget.otpArgs.ids,
                                              action: widget.otpArgs.action,
                                              smsOtp: smsOtp,
                                              emailOtp: emailOtp,
                                              otp: otp,
                                              otpType: widget.otpArgs.otpType,
                                              otpTranId: _otpTranId));
                                        });
                                      }
                                    }
                                  },
                                ),
                                // if (_isCountDownFinished && resendAttempts != 0)
                                //   GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         resendAttempts--;
                                //         _smsOtpController.clear();
                                //         _emailOtpController.clear();
                                //         buttonClick = true;
                                //         invalidAttempst = 3;
                                //       });
                                //       // _startCountDown();
                                //       setState(() {
                                //         bloc.add(RequestOTPEvent(
                                //             OtpType: widget.otpArgs.otpType ??
                                //                 _otpType));
                                //       });
                                //     },
                                //     child: Text(
                                //       "Resend Code",
                                //       style: size14weight700.copyWith(
                                //         color: colors(context).primaryColor,
                                //       ),
                                //     ),
                                //   )
                                // else if (resendAttempts == 0)
                                //   Text(
                                //     "Resend Code",
                                //     style: size14weight400.copyWith(
                                //       color: colors(context).greyColor100,
                                //     ),
                                //     textAlign: TextAlign.center,
                                //   )
                                 16.verticalSpace,
                                if (!_isCountDownFinished &&
                                    resendAttempts != 0)
                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)
                                                .translate("resend_code_in"),
                                            style: size14weight400.copyWith(
                                              color: colors(context).greyColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: (_countDown != null)
                                                ? '${_countDown == "00:00" ? "" : _countDown}'
                                                : '',
                                            style: size14weight700.copyWith(
                                              color:
                                                  colors(context).primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                // if (!widget.otpArgs.isSingleOTP)
                                12.verticalSpace,
                               
                              ],
                            ),
                             if (widget.otpArgs.isSingleOTP) 60.62.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("call_for"),
                            style: size14weight400.copyWith(
                              color: colors(context).greyColor,
                            ),
                          ),
                          TextSpan(
                              text:formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??""),
                              style: size14weight700.copyWith(
                                  color: colors(context).primaryColor))
                        ],
                      ),
                    ),
                    onTap: () {
                      _launchCaller(int.parse(AppConstants.CALL_CENTER_TEL_NO !));
                    },
                  ),
                  32.verticalSpace,
                  AppButton(
                    buttonType: _isCountDownFinished && resendAttempts != 0
                        ? ButtonType.PRIMARYENABLED
                        : (widget.otpArgs.isSingleOTP
                                    ? true
                                    : _isEmailPinCodeComplete) &&
                                _isSmsPinCodeComplete &&
                                invalidAttempst != 0
                            ? ButtonType.PRIMARYENABLED
                            : ButtonType.PRIMARYDISABLED,
                    buttonText: AppLocalizations.of(context).translate(
                        _isCountDownFinished && resendAttempts != 0
                            ? "resend_otp"
                            : "verify"),
                    onTapButton: () {
                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      if (_isCountDownFinished && resendAttempts != 0) {
                        setState(() {
                          resendAttempts--;
                          _smsOtpController.clear();
                          _emailOtpController.clear();
                          buttonClick = true;
                          invalidAttempst = 3;
                        });
                        setState(() {
                          bloc.add(RequestOTPEvent(
                              OtpType: widget.otpArgs.otpType ?? _otpType));
                        });
                      } else {
                        if (invalidAttempst != 0) {
                          setState(() {
                            invalidAttempst--;
                            String? otp;
                            if (widget.otpArgs.isSingleOTP) {
                              otp = smsOtp;
                              smsOtp = null;
                              emailOtp = null;
                            }
                            bloc.add(OTPVerificationEvent(
                                id: widget.otpArgs.id,
                                ids: widget.otpArgs.ids,
                                action: widget.otpArgs.action,
                                smsOtp: smsOtp,
                                emailOtp: emailOtp,
                                otp: otp,
                                otpType: widget.otpArgs.otpType,
                                otpTranId: _otpTranId));
                          });
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

_launchCaller(int number) async {
  var url = 'tel:${number.toString()}';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Cannot direct to $url';
  }
}
