
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/mask.dart';

import '../../../data/models/responses/add_just_pay_instruements_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../bloc/otp/otp_event.dart';
import '../../bloc/otp/otp_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/otp_count_down.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class OtherBankOtpResponseArgs {
  bool isOtpSend;
  String? otpTranId;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;
  String? otpType;

  OtherBankOtpResponseArgs({
    this.otpTranId,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.otpType,
    this.isOtpSend = false,
  });
}

class OtherBankOTPViewArgs {
  final OtherBankOtpResponseArgs? otherBankOtpResponseArgs;
  final bool requestOTP;
  final String appBarTitle;
  final String mobileNumber;
  final String? otpType;
  final String? routeName;

  final AddJustPayInstrumentsResponse? addJustPayInstrumentsResponse;

  OtherBankOTPViewArgs({
    this.otpType,
    this.routeName,
    this.otherBankOtpResponseArgs,
    this.requestOTP = false,
    required this.appBarTitle,
    required this.mobileNumber,
    this.addJustPayInstrumentsResponse,
  });
}

class OtherBankOTPView extends BaseView {
  final OtherBankOTPViewArgs? otherBankOTPViewArgs;

  OtherBankOTPView({this.otherBankOTPViewArgs});

  @override
  _OtherBankOTPViewState createState() => _OtherBankOTPViewState();
}

class _OtherBankOTPViewState extends BaseViewState<OtherBankOTPView> {
  AddJustPayInstrumentsResponse? addJustPayInstrumentsResponse;
  
  bool _isSmsPinCodeComplete = false;
  String? justpayOtp;
  int _otpLength = 4;
  OTPCountDown? _otpCountDown;
  String? _otpTranId = '';
  String? challengeReqId = '';
  int _otpTimeInMS = 60 * 1000;
  int _resendAttempt = 0;
  bool buttonClick = false;
  bool firstAttempt = true;
  bool initialTimerStarted = false;
  bool _isCountDownFinished = false;
  String? _countDown;
  String? smsOtp;
  final TextEditingController _smsOtpController = TextEditingController();
  int invalidAttempst = 3;

  final OTPBloc _bloc = injection<OTPBloc>();

   //OTP TimeOut
  late final AppLifecycleListener listener;
  int countDownTimeMs = 0;
  int staticCountDown = 0;
  DateTime? initialDateTime;

  updateUI(OtherBankOtpResponseArgs? otherBankOtpResponseArgs) {
    setState(() {
      // _mobileNumber =
      //     addJustPayInstrumentsResponse!.mobile!.replaceAllMapped(
      //       RegExp(r'\d(?=\d{4})'),
      //           (match) => '*',
      //     );
      // _email = addJustPayInstrumentsResponse.email!.replaceAllMapped(
      //   RegExp(r"^(.).*?(@.*)$"),
      //       (match) =>
      //   match.group(1)! +
      //       "*" * (match.group(0)!.length - 2) +
      //       match.group(2)!,
      // );
      _otpTimeInMS = otherBankOtpResponseArgs?.countdownTime != null
          ? otherBankOtpResponseArgs!.countdownTime! * 1000
          : AppConstants.otpTimeout;

      _otpLength = otherBankOtpResponseArgs!.otpLength!;
      _otpTranId = otherBankOtpResponseArgs.otpTranId;

      if (firstAttempt) {
        _resendAttempt = otherBankOtpResponseArgs.resendAttempt!;
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
    if (widget.otherBankOTPViewArgs!.requestOTP) {
      // Start the initial timer with the hard-coded value
      initialTimerStarted = true;
      // _startCountDown();
      _bloc.add(OtherBankRequestEvent(
        otpType: widget.otherBankOTPViewArgs?.otpType,
      ));
    }
    else if (widget.otherBankOTPViewArgs!.addJustPayInstrumentsResponse !=
        null) {
      updateUI(widget.otherBankOTPViewArgs!.otherBankOtpResponseArgs);
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
      _isSmsPinCodeComplete = _smsOtpController.text.length == _otpLength ? true:false;
    });
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).whiteColor,
        appBar: UBAppBar(
          title: widget.otherBankOTPViewArgs!.appBarTitle,
        ),
        body: BlocProvider<OTPBloc>(
          create: (_) => _bloc,
          child: BlocListener<OTPBloc, BaseState<OTPState>>(
            listener: (_, state) {
              if (state is OTPVerificationSuccessState) {
                challengeReqId = state.id;
                _smsOtpController.clear();
                // if (widget.otherBankOTPViewArgs!.requestOTP) {
                  Navigator.pop(context, state.id);
                // } else {
                //   if (widget.otherBankOTPViewArgs!
                //           .addJustPayInstrumentsResponse !=
                //       null) {
                //     Navigator.pushNamed(context, Routes.kJustPayTnCView,
                //         arguments: TermsArgs(
                //           termsType: ObType.justPay.name,
                //         )).then((value) {
                //       if (value is bool && value) {
                //         Navigator.pushReplacementNamed(
                //             context, Routes.kOtherBankAccountAddSuccessView);
                //       }
                //     });
                //   } else {
                //     Navigator.pop(context, true);
                //   }
                // }
              } else if (state is OTPVerificationFailedState) {
                 _smsOtpController.clear();
        
                if(invalidAttempst==0){
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
                }else if (state.code == "dbp-576") {
                  showAppDialog(
                   alertType: AlertType.FAIL,
                    isSessionTimeout: true,
                    title: AppLocalizations.of(context).translate("incorrect_oTP"),
                    message:splitAndJoinAtBrTags(state.message ?? "OTP entered is incorrect. You have $invalidAttempst more attempt/s left. Please enter a valid One Time Password"),
                    positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  );
                }else{
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context).translate(
                        "incorrect_oTP"),
                    message: state.message,
                    onPositiveCallback: () {
                    },
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  );
        
                }
              } else if (state is JustPayOTPRequestSuccessState) {
                setState(() {
                  addJustPayInstrumentsResponse =
                      state.addJustPayInstrumentsResponse;
                  _otpTranId = state.addJustPayInstrumentsResponse!.otpTranId;
                  _otpTimeInMS = state
                              .addJustPayInstrumentsResponse?.countdownTime !=
                          null
                      ? (state.addJustPayInstrumentsResponse!.countdownTime! *
                          1000)
                      : AppConstants.otpTimeout;
        
                  _otpLength =
                      state.addJustPayInstrumentsResponse!.otpLength!;
                  if (buttonClick == false) {
                    _resendAttempt =
                        state.addJustPayInstrumentsResponse?.resendAttempt ??
                            4;
                  }
                });
        
                _startCountDown();
              } else if (state is JustPayOTPRequestFailedState) {
                 _smsOtpController.clear();
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
                Navigator.pop(context, false);
              }
            },
            child: Padding(
               padding:  EdgeInsets.fromLTRB(20.w,0,20.w,20.h+ AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
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
                                  text:  "${AppLocalizations.of(context).translate("we_sent_a")}$_otpLength${AppLocalizations.of(context).translate("code_to_your")}",
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),
                                if (AppConstants.profileData.mobileNo.toString() != "")
                                  TextSpan(
                                    text: AppConstants.profileData.mobileNo.toString().length == 10 && AppConstants.profileData.mobileNo.toString().startsWith("07") ?
                                    " +94${Mask().maskMobileNumber(AppConstants.profileData.mobileNo.toString() ?? "")}" :
                                    " ${Mask().maskMobileNumber(AppConstants.profileData.mobileNo.toString() ?? "")}",
                                        // " +94 ${Mask().maskMobileNumber(AppConstants.profileData.mobileNo.toString())}",
                                    style: size16weight700.copyWith(
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                                TextSpan(
                                  text: " ${AppLocalizations.of(context).translate("otp_sent_mail_des_1")}",
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),
                                if (AppConstants.profileData.email.toString() != "")
                                  TextSpan(
                                    text:
                                        " ${Mask().maskEmailAddress(AppConstants.profileData.email.toString())}",
                                    style: size16weight700.copyWith(
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                               70.71.verticalSpace,
                              PinCodeTextField(
                                textStyle: size24weight700.copyWith(color: colors(context).blackColor),
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
                                          otp: justpayOtp,
                                          justpayOtp: justpayOtp,
                                          smsOtp: justpayOtp,
                                          emailOtp: justpayOtp,
                                          otpType: 'justpay',
                                          otpTranId: _otpTranId));
                                    });
                                  }
                                },
                              ),
                          // if (_isCountDownFinished && _resendAttempt != 0)
                          //   GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //       _resendAttempt--;
                          //       _smsOtpController.clear();
                          //        invalidAttempst = 3;
                          //     });
                          //       setState(() {
                          //         _bloc.add(OtherBankRequestEvent(
                          //           otpType: 'justpay',
                          //         ));
                          //       });
                          //     },
                          //     child: Text(
                          //       "Resend Code",
                          //       style: size14weight700.copyWith(color: colors(context).primaryColor,),
                          //     ),
                          //   )
                          //   else 
                          //   if (_resendAttempt == 0)
                          //   Text(
                          //     "Resend Code",
                          //      style: size14weight400.copyWith(color: colors(context).greyColor100,),
                          //   )
                          // else
                          16.verticalSpace,
                          if(!_isCountDownFinished && _resendAttempt != 0)  Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                          .translate("resend_code_in"),
                                        style: size14weight400.copyWith(color: colors(context).greyColor,),
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
                      _launchCaller(int.parse(AppConstants.CALL_CENTER_TEL_NO!));
                    },
                  ),
                  3.80.verticalSpace,
                  AppButton(
                    buttonType: _isCountDownFinished && _resendAttempt != 0?ButtonType.PRIMARYENABLED: _isSmsPinCodeComplete&&
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
                                  _bloc.add(OtherBankRequestEvent(
                                    otpType: 'justpay',
                                  ));
                                });
                      }else{
                         if (invalidAttempst != 0) {
                        setState(() {
                           invalidAttempst--;
                          _bloc.add(OTPVerificationEvent(
                              otp: justpayOtp,
                              justpayOtp: justpayOtp,
                              smsOtp: justpayOtp,
                              emailOtp: justpayOtp,
                              otpType: 'justpay',
                              otpTranId: _otpTranId));
                        });
                      } 

                      }
                      
                     
                      
                      // else {
                      //   showAppDialog(
                      //     alertType: AlertType.WARNING,
                      //     title: 'Resend Attempts is Over ',
                      //     positiveButtonText: 'Cancel',
                      //   );
                      // }
                    },
                  )
                ],
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
