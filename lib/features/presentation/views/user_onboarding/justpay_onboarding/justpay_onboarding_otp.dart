import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/just_pay_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/mask.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/add_just_pay_instruements_response.dart';
import '../../../../data/models/responses/just_pay_account_onboarding_response.dart';
import '../../../../data/models/responses/otp_response.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/otp/otp_bloc.dart';
import '../../../bloc/otp/otp_event.dart';
import '../../../bloc/otp/otp_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/otp_count_down.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import 'justpay_terms_and_conditions_view.dart';

class JustPayOtpResponseArgs {
  bool isOtpSend;
  String? otpTranId;
  String? otpType;
  String? email;
  String? mobile;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;

  JustPayOtpResponseArgs({
    this.otpTranId,
    this.otpType,
    this.email,
    this.mobile,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.isOtpSend = false,
  });
}

class JustPayOTPViewArgs {
  final JustPayOtpResponseArgs? justPayOtpResponseArgs;
  final String? otpType;
  final bool requestOTP;
  final String appBarTitle;
  final String mobileNumber;
  final JustPayData? justPayData;
  final JustPayAccountOnboardingResponse? justPayAccountOnboardingDto;
  final AddJustPayInstrumentsResponse? addJustPayInstrumentsResponse;

  JustPayOTPViewArgs(
      {this.justPayOtpResponseArgs,
      this.otpType,
      this.requestOTP = false,
      required this.appBarTitle,
      required this.mobileNumber,
      this.justPayAccountOnboardingDto,
      this.addJustPayInstrumentsResponse,
      this.justPayData});
}

class JustPayOTPView extends BaseView {
  final JustPayOTPViewArgs? args;

  JustPayOTPView({this.args});

  @override
  _JustPayOTPViewState createState() => _JustPayOTPViewState();
}

class _JustPayOTPViewState extends BaseViewState<JustPayOTPView> {
  OtpResponse? otpResponse;
  bool _isSmsPinCodeComplete = false;
  String? _mobileNumber;
  String? _email;
  int _otpLength = 4;
  OTPCountDown? _otpCountDown;
  String? _otpTranId = '';
  String _otpType = "";
  int _otpTimeInMS = 60 * 1000;
  int _resendAttempt = 0;
  bool buttonClick = false;
  bool firstAttempt = true;

  bool _isCountDownFinished = false;
  String? _countDown;
  String? justpayOtp;
  final TextEditingController _smsOtpController = TextEditingController();

  int invalidAttempst = 3;
  final OTPBloc _bloc = injection<OTPBloc>();
  var justpayForResend = injection<ContactInformationBloc>();

  //OTP TimeOut
  late final AppLifecycleListener listener;
  int countDownTimeMs = 0;
  int staticCountDown = 0;
  DateTime? initialDateTime;

  updateUI(JustPayAccountOnboardingResponse? justPayAccountOnboardingResponse) {
    setState(() {
      // _mobileNumber =
      //     justPayAccountOnboardingResponse!.mobile!.replaceAllMapped(
      //   RegExp(r'\d(?=\d{4})'),
      //   (match) => '*',
      // );
      // _email = justPayAccountOnboardingResponse.email!.replaceAllMapped(
      //   RegExp(r"^(.).*?(@.*)$"),
      //   (match) =>
      //       match.group(1)! +
      //       "*" * (match.group(0)!.length - 2) +
      //       match.group(2)!,
      // );
      _mobileNumber = widget.args?.justPayOtpResponseArgs?.mobile;
      _email =widget.args?.justPayOtpResponseArgs?.email ;
      _otpTimeInMS = widget.args?.justPayOtpResponseArgs?.countdownTime != null
          ? widget.args!.justPayOtpResponseArgs!.countdownTime! * 1000
          : AppConstants.otpTimeout;
      _otpLength = widget.args!.justPayOtpResponseArgs!.otpLength!;
      _otpTranId = widget.args!.justPayOtpResponseArgs!.otpTranId!;
      _otpType = widget.args!.justPayOtpResponseArgs!.otpType!;
      if (firstAttempt) {
        _resendAttempt = widget.args!.justPayOtpResponseArgs!.resendAttempt!;
        firstAttempt = false;
      }
    });
  }

  updateUI1(AddJustPayInstrumentsResponse? justPayAccountOnboardingResponse) {
    setState(() {
      _otpTimeInMS = justPayAccountOnboardingResponse?.countdownTime != null
          ? justPayAccountOnboardingResponse!.countdownTime! * 1000
          : AppConstants.otpTimeout;
      _otpLength = justPayAccountOnboardingResponse!.otpLength!;
      _otpTranId = justPayAccountOnboardingResponse.otpTranId;
      _otpType = justPayAccountOnboardingResponse.otpType!;
      if (firstAttempt) {
        _resendAttempt = justPayAccountOnboardingResponse.resendAttempt!;
        firstAttempt = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    _smsOtpController.addListener(_onSmsPinCodeChanged);
    if (widget.args!.requestOTP) {
      _bloc.add(RequestOTPEvent(
        OtpType: ObType.JUSTPAY.name.toLowerCase(),
      ));
      // _startCountDown();
    } else if (widget.args!.justPayAccountOnboardingDto != null) {
      updateUI(widget.args!.justPayAccountOnboardingDto);
      _startCountDown();
    } else if (widget.args!.addJustPayInstrumentsResponse != null) {
      updateUI1(widget.args!.addJustPayInstrumentsResponse);
      _startCountDown();
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

  void _startCountDown({bool isNew = true,bool invalidAttemptReset =false}) {
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
        if(invalidAttemptReset){
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
    }
    super.dispose();
  }

  void _onSmsPinCodeChanged() {
    setState(() {
      _isSmsPinCodeComplete =
          _smsOtpController.text.length == _otpLength ? true : false;
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).whiteColor,
        appBar: UBAppBar(
          title: widget.args!.appBarTitle,
        ),
        body: BlocProvider<OTPBloc>(
          create: (_) => _bloc,
          child: BlocProvider<ContactInformationBloc>(
            create: (context) => justpayForResend,
            child: BlocListener<ContactInformationBloc,
                BaseState<ContactInformationState>>(
              bloc: justpayForResend,
              listener: (_, state) async {
                if (state is JustPayOnboardingSuccessState) {
                  hideProgressBar();
                  setState(() {
                    _otpTranId = state
                        .justPayAccountOnboardingDto?.otpResult?.otpTranId;
                    _otpTimeInMS = state.justPayAccountOnboardingDto
                                ?.otpResult?.countdownTime !=
                            null
                        ? state.justPayAccountOnboardingDto!.otpResult!
                                .countdownTime! *
                            1000
                        : AppConstants.otpTimeout;
                    _otpLength = state
                        .justPayAccountOnboardingDto!.otpResult!.otpLength!;
                    _otpType = state
                        .justPayAccountOnboardingDto!.otpResult!.otpType!;
                    if (buttonClick == false) {
                      _resendAttempt = state.justPayAccountOnboardingDto
                              ?.otpResult?.resendAttempt ??
                          3;
                    }
                  });
                  _startCountDown();
                } else if (state is JustPayOnboardingFailedState) {
                  hideProgressBar();
                  _smsOtpController.clear();
                  ToastUtils.showCustomToast(
                      context, state.message!, ToastStatus.FAIL);
                }
              },
              child: BlocListener<OTPBloc, BaseState<OTPState>>(
                listener: (_, state) {
                  if (state is OTPVerificationSuccessState) {
                    if (widget.args!.requestOTP) {
                      Navigator.pop(context, true);
                    } else {
                      if (widget.args!.justPayAccountOnboardingDto != null) {
                        Navigator.pushReplacementNamed(
                            context, Routes.kJustPayTnCView,
                            arguments: TermsJustPayArgs(
                                termsType: ObType.DO.name,
                                justPayData: widget.args!.justPayData));
                      } else {
                        Navigator.pop(context, true);
                      }
                    }
                  } else if (state is OTPVerificationFailedState) {
                    _smsOtpController.clear();
                    if (invalidAttempst == 0) {
                      showAppDialog(
                        alertType: AlertType.FAIL,
                        title: AppLocalizations.of(context).translate("limit_exceeded"),
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
                        title: AppLocalizations.of(context).translate("incorrect_oTP"),
                        message:splitAndJoinAtBrTags(state.message ?? "${AppLocalizations.of(context).translate("otp_incorrect_des_1")} $invalidAttempst ${AppLocalizations.of(context).translate("otp_incorrect_des_2")}"),
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
                  }
                  // else if (state is OTPRequestSuccessState) {
        
                  // } else if (state is OTPRequestFailedState) {
                  //   _smsOtpController.clear();
        
                  //   ToastUtils.showCustomToast(
                  //       context, state.message!, ToastStatus.fail);
                  //   Navigator.pop(context, false);
                  // }
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w,0,20.w,20.h+ AppSizer.getHomeIndicatorStatus(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                           physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                               40.verticalSpace,
                              SvgPicture.asset(
                                AppAssets.ubOnboardingOtp,
                                 width: 200.w,
                                  height: 200.w,
                              ),
                          28.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20).w,
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
                                  text:  "${AppLocalizations.of(context).translate("we_sent_a")}$_otpLength${AppLocalizations.of(context).translate("code_to_your")}",
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
                                  text: " ${AppLocalizations.of(context).translate("otp_sent_mail_des_2")}",
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),if (_email != "")
                                  TextSpan(
                                    text:
                                        " ${Mask().maskEmailAddress(_email.toString() ?? "")}",
                                    style: size16weight700.copyWith(
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                                70.71.verticalSpace,
                              PinCodeTextField(
                                textStyle: size24weight700.copyWith(
                                    color: colors(context).blackColor),
                                cursorColor: colors(context).blackColor,
                                mainAxisAlignment: MainAxisAlignment.center,
                                autoDisposeControllers: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                appContext: context,
                                length: _otpLength,
                                controller: _smsOtpController,
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
                                  justpayOtp = value;
                                  setState(() {});
                                },
                                onCompleted: (_) {
                                  if (invalidAttempst != 0 && _isCountDownFinished == false) {
                                    setState(() {
                                      invalidAttempst--;
                                      _bloc.add(OTPVerificationEvent(
                                          justpayOtp: justpayOtp,
                                          smsOtp: justpayOtp,
                                          emailOtp: justpayOtp,
                                          otpType: kOtpMessageTypeOnBoarding,
                                          otpTranId: _otpTranId));
                                    });
                                  }
                                },
                              ),
                              // if (_isCountDownFinished && _resendAttempt != 0)
                              //   GestureDetector(
                              //     onTap: () {
                              //       setState(() {
                              //         _resendAttempt--;
                              //         _smsOtpController.clear();
                              //         buttonClick = true;
                              //         invalidAttempst = 3;
                              //       });
                              //       showProgressBar();
        
                              //       justpayForResend
                              //           .add(JustPayAccountOnboardingEvent(
                              //         fullName:
                              //             widget.args?.justPayData?.fullName,
                              //         bankCode:
                              //             widget.args?.justPayData?.bankCode,
                              //         accountType: widget
                              //             .args?.justPayData?.accountType,
                              //         accountNo:
                              //             widget.args?.justPayData?.accountNo,
                              //         nickName:
                              //             widget.args?.justPayData?.nickName,
                              //         enableAlert: widget
                              //             .args?.justPayData?.isSelected,
                              //       ));
                              //     },
                                //   child: Text(
                                //     "Resend Code",
                                //     style: size14weight700.copyWith(
                                //       color: colors(context).primaryColor,
                                //     ),
                                //   ),
                                // )
                              // else if (_resendAttempt == 0)
                              //   Text(
                              //     "Resend Code",
                              //     style: size14weight400.copyWith(
                              //       color: colors(context).greyColor100,
                              //     ),
                              //   )
                               16.verticalSpace,
                               if(!_isCountDownFinished && _resendAttempt != 0)
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
                                60.62.verticalSpace,
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
                                  text: formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??""),
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
                        buttonType:_isCountDownFinished && _resendAttempt != 0?ButtonType.PRIMARYENABLED: _isSmsPinCodeComplete&&
                            invalidAttempst != 0
                                ? ButtonType.PRIMARYENABLED
                                : ButtonType.PRIMARYDISABLED,
                        buttonText:
                             AppLocalizations.of(context).translate(_isCountDownFinished && _resendAttempt != 0? "resend_otp":"verify"),
                        onTapButton: () {
                         WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                           if(_isCountDownFinished && _resendAttempt != 0){
                          setState(() {
                                _resendAttempt--;
                                _smsOtpController.clear();
                                 invalidAttempst = 3;
                                 buttonClick = true;
                              });
                                setState(() {
                                  justpayForResend
                                        .add(JustPayAccountOnboardingEvent(
                                      fullName:
                                          widget.args?.justPayData?.fullName,
                                      bankCode:
                                          widget.args?.justPayData?.bankCode,
                                      accountType: widget
                                          .args?.justPayData?.accountType,
                                      accountNo:
                                          widget.args?.justPayData?.accountNo,
                                      nickName:
                                          widget.args?.justPayData?.nickName,
                                      enableAlert: widget
                                          .args?.justPayData?.isSelected,
                                    ));
                                });
                      }else{
                          if (invalidAttempst != 0) {
                            setState(() {
                              invalidAttempst--;
                              _bloc.add(OTPVerificationEvent(
                                  justpayOtp: justpayOtp,
                                  smsOtp: justpayOtp,
                                  emailOtp: justpayOtp,
                                  otpType: kOtpMessageTypeOnBoarding,
                                  otpTranId: _otpTranId));
                            });
                          }}
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  _launchCaller(int number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
