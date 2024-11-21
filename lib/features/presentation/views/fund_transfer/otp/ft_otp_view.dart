import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/mask.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/otp_response.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/fund_transfer/fund_transfer_bloc.dart';
import '../../../bloc/fund_transfer/fund_transfer_event.dart';
import '../../../bloc/fund_transfer/fund_transfer_state.dart';
import '../../../bloc/otp/otp_bloc.dart';
import '../../../bloc/otp/otp_event.dart';
import '../../../bloc/otp/otp_state.dart';
import '../../../widgets/otp_count_down.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../notifications/data/request_money_data.dart';
import '../data/fund_transfer_args.dart';
import '../data/fund_transfer_recipt_view_args.dart';

class FtOtpResponseArgs {
  bool isOtpSend;
  String? otpTranId;
  String? otpType;
  String? email;
  String? mobile;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;

  FtOtpResponseArgs({this.isOtpSend = false,
    this.otpTranId,
    this.otpType,
    this.email,
    this.mobile,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
  });
}

class FtOtpArgs {
  final String? otpType;
  final bool? requestOTP;
  final String? routeName;
  final String appBarTitle;
  final String phoneNumber;
  final String? email;
  final FundTransferArgs fundTransferArgs;
  final FtOtpResponseArgs? ftOtpResponseArgs;
  final bool isIntraFT;
  FtRouteType ftRouteType;

  FtOtpArgs({this.otpType,
    this.requestOTP,
    this.routeName,
    required this.appBarTitle,
    required this.phoneNumber,
    this.email,
    required this.fundTransferArgs,
    this.ftOtpResponseArgs,
    required this.isIntraFT,
    required this.ftRouteType,
  });
}

class FTOtpView extends BaseView {
  final FtOtpArgs ftOtpArgs;

  FTOtpView({required this.ftOtpArgs});

  @override
  _FTOtpViewState createState() => _FTOtpViewState();
}

class _FTOtpViewState extends BaseViewState<FTOtpView> {
  var otpBloc = injection<OTPBloc>();
  var fundTransferBloc = injection<FundTransferBloc>();


  bool _isOtpPinCodeComplete = false;
  OTPCountDown? _otpCountDown;
  bool _isCountDownFinished = false;
  String? _countDown;
  String _otpTranId = '';
  String _otpType = "";
  String? _mobileNumber;
  bool firstAttempt = true;
  String? _email;
  OtpResponse? otpResponse;
  bool buttonClick = false;
  int _otpLength = 6;
  int _otpTimeInMS = 60 * 1000;
  int _resendAttempt = 0;
  String? otp;
  final TextEditingController _otpController = TextEditingController();
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
    _otpController.addListener(_onSmsPinCodeChanged);
    if (widget.ftOtpArgs.requestOTP == true) {
      otpBloc.add(RequestOTPEvent(OtpType: widget.ftOtpArgs.otpType));
      if (widget.ftOtpArgs.ftOtpResponseArgs?.isOtpSend == true) {
        // _startCountDown();
      }
    } else if (widget.ftOtpArgs.ftOtpResponseArgs != null) {
      updateUI(widget.ftOtpArgs.ftOtpResponseArgs);
      _otpTranId = widget.ftOtpArgs.ftOtpResponseArgs!.otpTranId!;

      if (widget.ftOtpArgs.ftOtpResponseArgs?.isOtpSend == true) {
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

  updateUI(FtOtpResponseArgs? otpResponseDto) {
    setState(() {
      _mobileNumber = otpResponseDto!.mobile;
      _email = otpResponseDto.email!;
      _otpTimeInMS = otpResponseDto.countdownTime != null
          ? otpResponseDto.countdownTime! * 1000
          : AppConstants.otpTimeout;

      _otpLength = otpResponseDto.otpLength!;
      _otpTranId = otpResponseDto.otpTranId!;
      _otpType = otpResponseDto.otpType!;

      if (firstAttempt) {
        _resendAttempt = otpResponseDto.resendAttempt!;
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
      _otpController.dispose();
    }
    super.dispose();
  }

  void _onSmsPinCodeChanged() {
    setState(() {
      _isOtpPinCodeComplete =
      _otpController.text.length == _otpLength ? true : false;
    });
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: widget.ftOtpArgs.appBarTitle,
      ),
      body: BlocProvider<OTPBloc>(
        create: (context) => otpBloc,
        child: BlocProvider<FundTransferBloc>(
          create: (_) => fundTransferBloc,
          child: BlocListener<OTPBloc, BaseState<OTPState>>(
            bloc: otpBloc,
            listener: (_, state) {
              if (state is OTPVerificationSuccessState) {
                //    if (_smsOtpController != null) _smsOtpController.clear();
                // if (_emailOtpController != null) _emailOtpController.clear();
                _otpCountDown?.cancelTimer();
                _countDown = "00:00";
                countDownTimeMs = 0;
                _otpTimeInMS = 0;
                initialDateTime = null;
                _isCountDownFinished = true;
                setState(() {});
                showProgressBar();
                if (widget.ftOtpArgs.isIntraFT) {
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.SAVEDNOW) {
                    fundTransferBloc.add(AddIntraFundTransferEvent(
                      transactionCategory: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.transactionCategory,
                      toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                      toAccountNo: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr,
                      toAccountName: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctname,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark,
                      reference: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                      instrumentId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.instrumentId,
                      beneficiaryMobileNo: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.beneficiaryMobile,
                      beneficiaryEmail: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.beneficiaryEmail,
                      amount: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                    ));
                  } else {
                    fundTransferBloc.add(AddIntraFundTransferEvent(
                      transactionCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      toBankCode: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.bankCode
                          .toString(),
                      toAccountNo: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctnmbr,
                      toAccountName: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctname,
                      remarks: widget
                          .ftOtpArgs.fundTransferArgs.fundTransferEntity.remark,
                      reference: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.reference,
                      instrumentId: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.instrumentId,
                      beneficiaryMobileNo: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      beneficiaryEmail: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryEmail,
                      amount: widget
                          .ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                    ));
                  }
                } else {
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.OWNLATER) {
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                    toAccountNo:widget.ftOtpArgs.fundTransferArgs
                        .fundTransferEntity.payToacctnmbr,
                    toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                    // widget.fundTransferArgs.fundTransferEntity.payTo?.bankCode,
                    toAccountName: widget.ftOtpArgs.fundTransferArgs
                        .fundTransferEntity.payToacctname,
                    scheduleSource: "SCHEDULE",
                    scheduleType: "OneTime",
                    scheduleTitle: "",
                    startDay: 0,
                    failCount: 0,
                    modifiedUser: pref.getEpicUserId(),
                    status: "active",
                    paymentInstrumentId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.instrumentId,
                    tranType: "FT",
                    startDate:DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.transactionDate!))),
                    createdUser: pref.getEpicUserId(),
                    reference: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                    endDate: DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.transactionDate!))),
                    frequency: "Daily",
                    transCategory: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.transactionCategory,
                    amount: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                    remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                  ));
                  }else if(widget.ftOtpArgs.ftRouteType == FtRouteType.OWNRECUURING){
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                      toAccountNo: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctnmbr,
                      toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                      // widget.fundTransferArgs.fundTransferEntity.payTo?.bankCode,
                      toAccountName: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctname,
                      scheduleSource: "SCHEDULE",
                      scheduleType: "Repeat",
                      scheduleTitle: "",
                      startDay: 0,
                      failCount: 0,
                      modifiedUser: pref.getEpicUserId(),
                      status: "active",
                      paymentInstrumentId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.instrumentId,
                     
                      tranType: "FT",
                      startDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .startDate!))),
                      createdUser: pref.getEpicUserId(),
                      reference: widget
                          .ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                      endDate:DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .endDate!))) ,
                      frequency: AppUtils.getFrequencyWithoutLocalization(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                          .scheduleFrequency??"daily"),
                      transCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      amount:
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                      beneficiaryMobile: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                    ));
                  } else
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.SAVEDLATER) {
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                        toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                        toAccountNo: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr,
                        toAccountName: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctname,
                      scheduleSource: "SCHEDULE",
                      scheduleType: "OneTime",
                      scheduleTitle: "",
                      startDay: 0,
                      failCount: 0,
                      modifiedUser: pref.getEpicUserId(),
                      status: "active",
                      paymentInstrumentId:widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.instrumentId,
                      tranType: "FT",
                      startDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .transactionDate!))),
                      createdUser: pref.getEpicUserId(),
                      reference: widget.ftOtpArgs
                          .fundTransferArgs.fundTransferEntity.reference,
                      endDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .transactionDate!))),
                      frequency: "Daily",
                      transCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      amount:
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                      beneficiaryMobile: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                    ));
                  } else if (widget.ftOtpArgs.ftRouteType ==
                      FtRouteType.SAVEDRECURRING) {
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                        toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                        toAccountNo: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr,
                        toAccountName: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctname,
                      scheduleSource: "SCHEDULE",
                      scheduleType: "Repeat",
                      scheduleTitle: "",
                      startDay: 0,
                      failCount: 0,
                      modifiedUser: pref.getEpicUserId(),
                      status: "active",
                      paymentInstrumentId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.instrumentId,
                     
                      tranType: "FT",
                      startDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .startDate!))),
                      createdUser: pref.getEpicUserId(),
                  
                      reference: widget
                          .ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                      endDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .endDate!))),
                      frequency: AppUtils.getFrequencyWithoutLocalization(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                          .scheduleFrequency??"daily"),
                      transCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      amount:
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                      beneficiaryMobile: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                    ));
                  } else
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.NEWRECURRING
                  ) {
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                      toAccountNo: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctnmbr,
                      toBankCode: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.bankCode.toString(),
                      // widget.fundTransferArgs.fundTransferEntity.payTo?.bankCode,
                      toAccountName: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctname,
                      scheduleSource: "SCHEDULE",
                      scheduleType: "Repeat",
                      scheduleTitle: "",
                      startDay: 0,
                      failCount: 0,
                      modifiedUser: pref.getEpicUserId(),
                      status: "active",
                      paymentInstrumentId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.instrumentId,
                 
                      tranType: "FT",
                      startDate: DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .startDate!))),
                      createdUser: pref.getEpicUserId(),
                  
                      reference: widget
                          .ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                      endDate:  DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .endDate!))),
                      frequency: AppUtils.getFrequencyWithoutLocalization(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                          .scheduleFrequency??"daily"),
                      transCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      amount:
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                      beneficiaryMobile: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                    ));
                  } else
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.NEWLATER
                  ) {
                    fundTransferBloc.add(SchedulingFundTransferEvent(
                      toAccountNo: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctnmbr,
                      toBankCode:widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.bankCode.toString(),
                      // widget.fundTransferArgs.fundTransferEntity.payTo?.bankCode,
                      toAccountName: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.payToacctname,
                      scheduleSource: "SCHEDULE",
                      scheduleType: "OneTime",
                      scheduleTitle: "",
                      startDay: 0,
                      failCount: 0,
                      modifiedUser: pref.getEpicUserId(),
                      status: "active",
                      paymentInstrumentId:widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.instrumentId,
                   
                      tranType: "FT",
                      startDate: DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .transactionDate!))),
                      createdUser: pref.getEpicUserId(),
                    
                      reference: widget.ftOtpArgs
                          .fundTransferArgs.fundTransferEntity.reference,
                      endDate:DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget
                              .ftOtpArgs .fundTransferArgs
                              .fundTransferEntity
                              .transactionDate!))),
                      frequency: "Daily",
                      transCategory: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.transactionCategory,
                      amount:
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.amount,
                      beneficiaryMobile: widget.ftOtpArgs.fundTransferArgs
                          .fundTransferEntity.beneficiaryMobile,
                      remarks: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.remark
                    ));
                  }
                }
              }
              else if (state is OTPVerificationFailedState) {
                _otpController.clear();
                if (invalidAttempst == 0) {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context).translate(
                        "limit_exceeded"),
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
                    title: AppLocalizations.of(context).translate(
                        "incorrect_oTP"),
                    message: splitAndJoinAtBrTags(state.message ??
                        "${AppLocalizations.of(context).translate("otp_incorrect_des_1")} $invalidAttempst ${AppLocalizations.of(context).translate("otp_incorrect_des_2")}"),
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
              else if (state is OTPRequestSuccessState) {
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

                if (state.otpResponse!.email != null ||
                    state.otpResponse!.email != "") {
                  _email = state.otpResponse!.email!;
                }
                setState(() {});
                _startCountDown();
              }
              else if (state is OTPRequestFailedState) {
                _otpController.clear();
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
                Navigator.pop(context, false);
              }
            },
            child: BlocListener<FundTransferBloc, BaseState<FundTransferState>>(
              bloc: fundTransferBloc,
              listener: (context, state2) async {
                if (state2 is ReqMoneyFundTranStatusSuccessState) {
                  AppConstants.requestMoneyData = RequestMoneyData();
                  setState(() {});
                }
                if (state2 is ReqMoneyFundTranStatusFailedState) {
                  ToastUtils.showCustomToast(
                      context, state2.message ?? AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                      ToastStatus.FAIL);
                }
                if (state2 is IntraFundTransferSuccessState) {
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId =
                      state2.intraFundTransferResponse!.transactionId;
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                      .reference =
                      state2.intraFundTransferResponse!.referenceNumber;
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.OWNNOW) {
                  await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity: widget
                            .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  }else if(widget.ftOtpArgs.ftRouteType == FtRouteType.SAVEDNOW){
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity:
                        widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  }else if(widget.ftOtpArgs.ftRouteType == FtRouteType.NEWNOW){
                    if(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.route == Routes.kNotificationsView && widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr == AppConstants.requestMoneyData.accountNumber){
                      fundTransferBloc.add(ReqMoneyFundTranStatusEvent(
                          messageType: "requestMoney",
                          requestMoneyId: AppConstants.requestMoneyData.id.toString(),
                          status: "accepted",
                        transactionStatus: "success",
                        transactionId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId ?? widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference
                      ));
                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget
                              .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    } else {
                      await  Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget
                              .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    }
                  }
                }
                else if (state2 is SchedulingFundTransferSuccessState) {
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId =
                      state2.schedulingFundTransferResponse!.scheduleId
                          .toString();
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                      .reference =
                      state2.schedulingFundTransferResponse!.reference;
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                      .scheduleTypeId =
                      state2.schedulingFundTransferResponse!.scheduleId;
                  if (widget.ftOtpArgs.ftRouteType == FtRouteType.OWNLATER) {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity: widget
                            .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  }else if(widget.ftOtpArgs.ftRouteType == FtRouteType.SAVEDLATER){
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity:
                        widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  }else if(widget.ftOtpArgs.ftRouteType == FtRouteType.NEWLATER){
                    if(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.route == Routes.kNotificationsView && widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr == AppConstants.requestMoneyData.accountNumber){
                      fundTransferBloc.add(ReqMoneyFundTranStatusEvent(
                          messageType: "requestMoney",
                          requestMoneyId: AppConstants.requestMoneyData.id.toString(),
                          status: "accepted",
                        transactionStatus: "success",
                        transactionId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId ?? widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference
                      ));
                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget
                              .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    } else {
                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity:
                          widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    }
                  } else if (widget.ftOtpArgs.ftRouteType ==
                      FtRouteType.OWNRECUURING) {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity:
                        widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  } else if (widget.ftOtpArgs.ftRouteType ==
                      FtRouteType.SAVEDRECURRING) {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentSucessView,
                      arguments: FundTransferReceiptViewArgs(
                        fundTransferEntity:
                        widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                        paymentSuccess: true,
                        // message: state.intraFundTransferResponse.transactionStatus,
                      ),
                    );
                  } else if (widget.ftOtpArgs.ftRouteType ==
                      FtRouteType.NEWRECURRING) {
                    if (widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                        .route == Routes.kNotificationsView && widget.ftOtpArgs
                        .fundTransferArgs.fundTransferEntity.payToacctnmbr ==
                        AppConstants.requestMoneyData.accountNumber) {
                      fundTransferBloc.add(ReqMoneyFundTranStatusEvent(
                          messageType: "requestMoney",
                          requestMoneyId: AppConstants.requestMoneyData.id.toString(),
                          status: "accepted",
                        transactionStatus: "success",
                        transactionId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId ?? widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference
                      ));
                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget
                              .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    } else {
                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.kOwnAcctNowPaymentSucessView,
                        arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget
                              .ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: true,
                          // message: state.intraFundTransferResponse.transactionStatus,
                        ),
                      );
                    }
                  }
                  setState(() {});
                }
                else if (state2 is IntraFundTransferFailedState) {
                  widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference = state2.transactionReferenceNumber;
                  if(widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.route == Routes.kNotificationsView && widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.payToacctnmbr == AppConstants.requestMoneyData.accountNumber){
                    fundTransferBloc.add(ReqMoneyFundTranStatusEvent(
                      messageType: "requestMoney",
                      requestMoneyId: AppConstants.requestMoneyData.id.toString(),
                      status: "accepted",
                      transactionStatus: "fail",
                      transactionId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId ?? widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference
                    ));
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  }
                  if (state2.code == "01") {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  }
                  else if (state2.code == "804") {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  } else if (state2.code == "502") {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  } else {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  }
                }
                else if (state2 is SchedulingFundTransferFailedState) {
                  if (widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                      .route == Routes.kNotificationsView &&
                      widget.ftOtpArgs.fundTransferArgs.fundTransferEntity
                          .payToacctnmbr ==
                          AppConstants.requestMoneyData.accountNumber) {
                    fundTransferBloc.add(ReqMoneyFundTranStatusEvent(
                      messageType: "requestMoney",
                      requestMoneyId: AppConstants.requestMoneyData.id.toString(),
                      status: "accepted",
                      transactionStatus: "fail",
                      transactionId: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.tranId ?? widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference
                    ));
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  }
                  if (state2.code == "804") {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs
                              .fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  } else if (state2.code == "502") {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  } else {
                    await Navigator.pushReplacementNamed(
                      context,
                      Routes.kOwnAcctNowPaymentFailView,
                      arguments: FundTransferReceiptViewArgs(
                          fundTransferEntity:
                          widget.ftOtpArgs.fundTransferArgs.fundTransferEntity,
                          paymentSuccess: false,
                          message: state2.message),
                    );
                  }
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
                                selectedColor: colors(context)
                                    .secondaryColor300!,
                                inactiveColor: colors(context)
                                    .secondaryColor300!,
                                activeColor: colors(context).secondaryColor300!,
                              ),
                              onChanged: (value) {
                                otp = value;
                                setState(() {});
                              },
                              onCompleted: (_) {
                                if (invalidAttempst != 0 &&
                                    _isCountDownFinished == false) {
                                  setState(() {
                                    invalidAttempst --;
                                    otpBloc.add(OTPVerificationEvent(
                                        otp: otp,
                                        otpType: widget.ftOtpArgs.otpType,
                                        otpTranId: _otpTranId));
                                  });
                                }
                              },
                            ),
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
                                          color: colors(context).greyColor,),
                                      ),
                                      TextSpan(
                                        text: (_countDown != null)
                                            ? '${_countDown == "00:00"
                                            ? ""
                                            : _countDown}'
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
                                text:formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??""),
                                style: size14weight700.copyWith(
                                    color: colors(context).primaryColor))
                          ],
                        ),
                      ),
                      onTap: () {
                        _launchCaller(int.parse(AppConstants.CALL_CENTER_TEL_NO!));
                      },
                    ),
                    32.verticalSpace,
                    AppButton(
                      buttonType: _isCountDownFinished && _resendAttempt != 0
                          ? ButtonType.PRIMARYENABLED
                          : _isOtpPinCodeComplete &&
                          invalidAttempst != 0
                          ? ButtonType.PRIMARYENABLED
                          : ButtonType.PRIMARYDISABLED,
                      buttonText:
                      AppLocalizations.of(context).translate(
                          _isCountDownFinished && _resendAttempt != 0
                              ? "resend_otp"
                              : "verify"),
                      onTapButton: () {
                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        if (_isCountDownFinished && _resendAttempt != 0) {
                          setState(() {
                            _resendAttempt--;
                            _otpController.clear();
                            buttonClick = true;
                            invalidAttempst = 3;
                          });
                          setState(() {
                            otpBloc.add(RequestOTPEvent(
                                OtpType: widget.ftOtpArgs.otpType ?? _otpType));
                          });
                        } else {
                          if (invalidAttempst != 0) {
                            setState(() {
                              invalidAttempst --;
                              otpBloc.add(OTPVerificationEvent(
                                  otp: otp,
                                  otpType: widget.ftOtpArgs.otpType,
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
      ),
    );
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
