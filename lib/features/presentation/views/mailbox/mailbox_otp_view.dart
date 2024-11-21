import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/responses/otp_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/otp/otp_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/otp/otp_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/otp/otp_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/compose_mail_result.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_sent_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/otp_count_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/mask.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_sizer.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';

class MailboxOtpResponseArgs {
  bool isOtpSend;
  String? otpTranId;
  String? otpType;
  String? email;
  String? mobile;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;
  String? previousRoute;

  MailboxOtpResponseArgs({
    this.otpTranId,
    this.otpType,
    this.email,
    this.mobile,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.isOtpSend = false,
    this.previousRoute,
  });
}

class MailboxOTPViewArgs {
  final MailboxOtpResponseArgs? otpResponseArgs;
  final MailComposeData? mailComposeData;
  final String? otpType;
  final bool requestOTP;
  final String? routeName;
  final String? appBarTitle;
  final String phoneNumber;
  final String email;

  MailboxOTPViewArgs({
    this.mailComposeData,
    this.otpResponseArgs,
    this.otpType,
    this.routeName,
    this.phoneNumber = "",
    this.email = "",
    this.appBarTitle,
    this.requestOTP = false,
  });
}

class MailBoxOtpView extends BaseView {
  final MailboxOTPViewArgs otpArgs;
  MailBoxOtpView({required this.otpArgs});

  @override
  _MailBoxOtpViewState createState() => _MailBoxOtpViewState();
}

class _MailBoxOtpViewState extends BaseViewState<MailBoxOtpView> {
  var otpBloc = injection<OTPBloc>();
  var mailboxBloc = injection<MailBoxBloc>();
  final localDataSource = injection<LocalDataSource>();

  bool _isOtpPinCodeComplete = false;
  OTPCountDown? _otpCountDown;
  bool _isCountDownFinished = false;
  String? _countDown;
  String _otpTranId = '';
  String _otpType= "";
  String? _mobileNumber;
  String? _email;
  OtpResponse? otpResponse;
  bool buttonClick = false;
  int _otpLength = 6;
  int _otpTimeInMS = 60 * 1000;
  int _resendAttempt = 0;
   String? otp;
  int invalidAttempst =3;
  final TextEditingController _otpController = TextEditingController();

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
    _otpController.addListener(_onSmsPinCodeChanged);
    if (widget.otpArgs.requestOTP == true) {
      otpBloc.add(RequestOTPEvent(OtpType: widget.otpArgs.otpType??_otpType));
      if (widget.otpArgs.otpResponseArgs?.isOtpSend == true) {
        // _startCountDown();
      }
    } else if (widget.otpArgs.otpResponseArgs != null) {
      updateUI(widget.otpArgs.otpResponseArgs);
      _otpTranId = widget.otpArgs.otpResponseArgs!.otpTranId!;

      if (widget.otpArgs.otpResponseArgs?.isOtpSend == true) {
        _startCountDown();
      }
    };
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

  updateUI(MailboxOtpResponseArgs? otpResponseDto) {
    setState(() {
      //  _mobileNumber = otpResponseDto!.mobile;
      // _email = otpResponseDto.email!.replaceAllMapped(
      //   RegExp(r"^(.).*?(@.*)$"),
      //   (match) =>
      //       match.group(1)! +
      //       "*" * (match.group(0)!.length - 2) +
      //       match.group(2)!,
      // );
      _mobileNumber = otpResponseDto?.mobile;
      _email = otpResponseDto?.email;
      _otpTimeInMS = otpResponseDto?.countdownTime != null
          ? otpResponseDto!.countdownTime! * 1000
          : AppConstants.otpTimeout;

      _otpLength = otpResponseDto!.otpLength!;
      _otpTranId = otpResponseDto.otpTranId!;
      _otpType = otpResponseDto.otpType!;
      if (buttonClick == false) {
        _resendAttempt = otpResponseDto.resendAttempt!;
      }
    });
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
     _otpController.dispose();

    }
    super.dispose();
  }

 void _onSmsPinCodeChanged() {
    setState(() {
      _isOtpPinCodeComplete = _otpController.text.length == _otpLength ? true:false;
    });
  }

  // void saveLocal()  {
  //   localDataSource.setOtpHandler(OtpHandler(
  //       previousRoute: widget.otpArgs.otpResponseArgs?.previousRoute,
  //       otpSendTime: DateTime.now(),
  //       isResendAttemptOver: false,
  //       otpTranId: _otpTranId,
  //       otpType: widget.otpArgs.otpType,
  //       email: _email,
  //       mobile:_mobileNumber,
  //       resendAttempt: _resendAttempt,
  //       countdownTime: _countDown,
  //       otpLength: _otpLength));
  // }


  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
        onPopInvoked: () async{
        Navigator.pop(context, true);
        return false;
        },
        child: Scaffold(
          appBar: UBAppBar(
            onBackPressed: () {
              // saveLocal();
              Navigator.pop(context, true);
              // Navigator.pop(context, true);
            },
            title: AppLocalizations.of(context).translate("otp_verification"),
          ),
          body: BlocProvider<OTPBloc>(
            create: (_) => otpBloc,
            child: BlocProvider<MailBoxBloc>(
              create: (context) => mailboxBloc,
              child: BlocListener<OTPBloc, BaseState<OTPState>>(
                bloc: otpBloc,
                listener: (_, state) {
                  if (state is OTPVerificationSuccessState) {
                 
                    showProgressBar();
                    _otpCountDown!.cancelTimer();
                    localDataSource.clearOtpHandler();
                    log(widget.otpArgs.mailComposeData?.inboxId.toString()??"SD");
                     log(widget.otpArgs.mailComposeData?.msgId.toString()??"BG");
                    mailboxBloc.add(widget.otpArgs.mailComposeData?.isNewCompose == false
                        ? ComposeMailEvent(
                          replyType:  "SENT",
                          isDraft: false,
                          message: widget.otpArgs.mailComposeData!.message!,
                          recipientTypeCode: widget.otpArgs.mailComposeData!.requestType!,
                          subject: widget.otpArgs.mailComposeData!.subject!,
                          attachment: widget.otpArgs.mailComposeData?.attachment,
                          msgId: widget.otpArgs.mailComposeData?.msgId,
                          inboxId: widget.otpArgs.mailComposeData?.inboxId
                            )
                        : ComposeMailEvent(
                          replyType:  "SENT",
                          isDraft: false,
                          message: widget.otpArgs.mailComposeData!.message!,
                          recipientTypeCode: widget.otpArgs.mailComposeData!.requestType!,
                          subject: widget.otpArgs.mailComposeData!.subject!,
                          attachment: widget.otpArgs.mailComposeData?.attachment));
                  } else if (state is OTPVerificationFailedState) {
                    hideProgressBar();
                      _otpController.clear();

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
                        message:splitAndJoinAtBrTags(state.message ?? "${AppLocalizations.of(context).translate("otp_incorrect_des_1")} $invalidAttempst ${AppLocalizations.of(context).translate("otp_incorrect_des_2")}"),
                      );
                    }  else{
                      showAppDialog(
                        alertType: AlertType.FAIL,
                        title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                        message: state.message,
                        onPositiveCallback: () {
                        },
                        positiveButtonText: AppLocalizations.of(context).translate("ok"),
                      );

                    }
                  } else if (state is OTPRequestSuccessState) {
                    setState(() {
                      _mobileNumber = state.otpResponse!.mobile!;
                      otpResponse = state.otpResponse!;
                      _otpTranId = state.otpResponse!.otpTranId!;
                      _otpTimeInMS = state.otpResponse?.countdownTime != null
                          ? (state.otpResponse!.countdownTime! * 1000)
                          : AppConstants.otpTimeout;

                      _otpLength = state.otpResponse!.otpLength!;
                      _otpType = state.otpResponse!.otpType!;
                      if (buttonClick == false) {
                        _resendAttempt = state.otpResponse!.resendAttempt ?? 3;
                      }
                    });
                    if (state.otpResponse!.email != null ||
                        state.otpResponse!.email != "") {
                      _email = state.otpResponse!.email!;
                    }
                    _startCountDown();
                  } else if (state is OTPRequestFailedState) {
                      _otpController.clear();
                    ToastUtils.showCustomToast(
                        context, state.message!, ToastStatus.FAIL);
                    Navigator.pop(context, false);
                  }
                },
                child: BlocListener<MailBoxBloc, BaseState<MailBoxState>>(
                  listener: (context, state) {
                    if (state is ComposeMailSuccessState) {
                      hideProgressBar();
                    
                          Navigator.pop(context, true);
                          Navigator.pop(context, ComposeMailResult(result: true,message: state.message??"",where: WHERE.NEW));
                    } else if (state is ComposeMailFailedState) {
                      hideProgressBar();
                      ToastUtils.showCustomToast(
                          context, state.message ?? "", ToastStatus.FAIL);
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
                                if (_mobileNumber != "" &&
                                    _mobileNumber != null)
                                  TextSpan(
                                    text: _mobileNumber?.length == 10 && _mobileNumber!.startsWith("07") ?
                                        " +94${Mask().maskMobileNumber(_mobileNumber ?? "")}" :
                                    " ${Mask().maskMobileNumber(_mobileNumber ?? "")}",
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
                                70.71.verticalSpace,
                                PinCodeTextField(
                                  textStyle: size24weight700.copyWith(color: colors(context).blackColor),
                                  cursorColor: colors(context).blackColor,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  autoDisposeControllers: false,
                                  controller: _otpController,
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
                                    otp = value;
                                    setState(() {});
                                  },
                                  onCompleted: (_) {
                                    if (invalidAttempst != 0 && _isCountDownFinished == false) {
                                      setState(() {
                                        invalidAttempst --;
                                        otpBloc.add(OTPVerificationEvent(
                                            otp: otp,
                                            otpType: widget.otpArgs.otpType,
                                            otpTranId: _otpTranId));
                                      });
                                    }
                                  },
                                ),
                          //       if (_isCountDownFinished && _resendAttempt != 0)
                          //         GestureDetector(
                          //           onTap: () {
                          //             setState(() {
                          //               _resendAttempt--;
                          //               _otpController.clear();
                          //               buttonClick = true;
                          //               invalidAttempst =3;
                          //             });
                                     
                          //             setState(() {
                          //               otpBloc.add(RequestOTPEvent(OtpType:widget.otpArgs.otpType??_otpType));
                          //             });
                          //           },
                          //           child: Text(
                          //             "Resend Code",
                          //              style: size14weight700.copyWith(color: colors(context).primaryColor,),
                          //           ),
                          //         )
                          //  else if( _resendAttempt == 0)
                          // Text(
                          //     "Resend Code",
                          //      style: size14weight400.copyWith(color: colors(context).greyColor100,),
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
                            _launchCaller(int.parse(AppConstants.CALL_CENTER_TEL_NO !));
                          },
                        ),
                         32.verticalSpace,
                        AppButton(
                          buttonType:   _isCountDownFinished && _resendAttempt != 0?ButtonType.PRIMARYENABLED: _isOtpPinCodeComplete&&
                            invalidAttempst != 0
                              ? ButtonType.PRIMARYENABLED
                              : ButtonType.PRIMARYDISABLED,
                          buttonText:
                              AppLocalizations.of(context).translate(_isCountDownFinished && _resendAttempt != 0? "resend_otp":"verify"),
                          onTapButton: () {
                           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            // setState(() {
                            //   buttonClick = true;
                            // });

                             if(_isCountDownFinished && _resendAttempt != 0){

                             setState(() {
                                        _resendAttempt--;
                                        _otpController.clear();
                                        buttonClick = true;
                                        invalidAttempst =3;
                                      });
                                     
                                      setState(() {
                                        otpBloc.add(RequestOTPEvent(OtpType:widget.otpArgs.otpType??_otpType));
                                      });

                             }else{
                            if (invalidAttempst != 0) {
                              setState(() {
                                invalidAttempst --;
                                otpBloc.add(OTPVerificationEvent(
                                    otp: otp,
                                    otpType: widget.otpArgs.otpType,
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
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return otpBloc;
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
