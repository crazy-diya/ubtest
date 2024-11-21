import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../otp/otp_view.dart';
import '../data/service_req_args.dart';
import '../data/service_req_entity.dart';

class chequeBookPasswordView extends BaseView {
  final ServiceReqArgs? serviceReqArgs;
  final bool? isFromHome;
  chequeBookPasswordView({super.key, this.isFromHome, this.serviceReqArgs});

  @override
  _BiometricsEnterPasswordViewState createState() =>
      _BiometricsEnterPasswordViewState();
}

class _BiometricsEnterPasswordViewState
    extends BaseViewState<chequeBookPasswordView> {
  var bloc = injection<BiometricBloc>();
  bool _isInputValid = false;
  String? password;
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  final biometricHelper = injection<BiometricHelper>();
  final localDataSource = injection<LocalDataSource>();
  bool isAuth = false;
  LoginMethods _loginMethod = LoginMethods.NONE;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => initialBiometric());
    _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    super.initState();
  }

  bool validateFields() {
    if (password == null || password == "") {
      return false;
    } else {
      return true;
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
      message: AppLocalizations.of(context).translate("re_enable_biometric"),
      positiveButtonText: AppLocalizations.of(context).translate("close"),
      onPositiveCallback: () {
        biometricHelper.cancelAuthentication();
        localDataSource.clearBiometric();
        AppConstants.BIOMETRIC_CODE = null;
        setState(() {});
      },
    );
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
    checkBiometric();
    setState(() {});
  }

  checkBiometric() {
    if (_isAppBiometricAvailable && _isBiometricAvailable) {
      biometricHelper.authenticateWithBiometrics(context).then((value) {
        if (value == true) {
          biometricSuccess();
          setState(() {});
        } else if (value == null) {
          checkAttempts();
        }
      });
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: UBAppBar(
          title: widget.serviceReqArgs?.serviceReqType == ServiceReqType.CHEQUE
              ? AppLocalizations.of(context).translate("cheque_book")
              : AppLocalizations.of(context).translate("statement"),
          goBackEnabled:
              (Navigator.of(context).canPop() == true) ? true : false,
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener(
            bloc: bloc,
            listener: (_, state) {
              if (state is PasswordValidationSuccessState) {
                biometricSuccess();
                setState(() {});
              }
              if (state is CheckBookRequestPasswordSuccessState) {
                Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                            phoneNumber:
                                AppConstants.profileData.mobileNo.toString(),
                            appBarTitle: 'otp_verification',
                            requestOTP: true,
                            otpType: kChequeBookOtpType,
                            id: state.code))
                    .then((value) {
                  final result = value as bool;
                  if (result == true) {
                    showAppDialog(
                      title: AppLocalizations.of(context)
                          .translate("request_success"),
                      message: widget.serviceReqArgs?.serviceReqType ==
                              ServiceReqType.CHEQUE
                          ? AppLocalizations.of(context)
                              .translate("request_success_des")
                          : AppLocalizations.of(context)
                              .translate("request_success_des_statement"),
                      alertType: AlertType.SUCCESS,
                      onPositiveCallback: () {
                        widget.serviceReqArgs?.serviceReqEntity =
                            ServiceReqEntity();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kChequeBookReqView,
                          arguments: widget.serviceReqArgs,
                          (Route<dynamic> route) =>
                              route.settings.name ==
                              Routes.kSeviceReqCategoryView,
                        );
                        setState(() {});
                      },
                      positiveButtonText:
                          AppLocalizations.of(context).translate("ok"),
                    );
                  }
                });
                setState(() {});
              }
              if (state is StatementRequestSuccessState) {
                Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                            phoneNumber:
                                AppConstants.profileData.mobileNo.toString(),
                            appBarTitle: 'otp_verification',
                            requestOTP: true,
                            otpType: kStatementOtpType,
                            id: state.code))
                    .then((value) {
                  final result = value as bool;
                  if (result == true) {
                    showAppDialog(
                      title: AppLocalizations.of(context)
                          .translate("request_success"),
                      message: widget.serviceReqArgs?.serviceReqType ==
                              ServiceReqType.CHEQUE
                          ? AppLocalizations.of(context)
                              .translate("request_success_des")
                          : AppLocalizations.of(context)
                              .translate("request_success_des_statement"),
                      alertType: AlertType.SUCCESS,
                      onPositiveCallback: () {
                        widget.serviceReqArgs?.serviceReqEntity =
                            ServiceReqEntity();
                        Navigator.pushNamedAndRemoveUntil(
                          // context,Routes.kChequeBookHistoryView, arguments: widget.serviceReqArgs?.serviceReqType == ServiceReqType.CHEQUE ?
                          context, Routes.kChequeBookReqView,
                          arguments: widget.serviceReqArgs,
                          (Route<dynamic> route) =>
                              route.settings.name ==
                              Routes.kSeviceReqCategoryView,
                        );
                        setState(() {});
                      },
                      positiveButtonText:
                          AppLocalizations.of(context).translate("ok"),
                    );
                  }
                });
                setState(() {});
              }
              if (state is PasswordValidationFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              }
              if (state is CheckBookRequestPasswordFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate("to_access_settings"),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: colors(context).blackColor,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextField(
                            isInfoIconVisible: false,
                            hint: AppLocalizations.of(context)
                                .translate("password"),
                            isLabel: true,
                            obscureText: true,
                            // inputFormatter: [
                            //   FilteringTextInputFormatter.allow(RegExp(
                            //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                            // ],
                            onTextChanged: (value) {
                              password = value;
                              _isInputValid = validateFields();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    buttonType: _isInputValid
                        ? ButtonType.PRIMARYENABLED
                        : ButtonType.PRIMARYDISABLED,
                    buttonText:
                        AppLocalizations.of(context).translate("continue"),
                    onTapButton: () {
                      bloc.add(PasswordValidationEvent(password: password));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  biometricSuccess() {
    widget.serviceReqArgs?.serviceReqType == ServiceReqType.CHEQUE
        ? bloc.add(
            CheckBookPasswordRequestEvent(
                accountNumber:
                    widget.serviceReqArgs?.serviceReqEntity?.payFromNum ?? "",
                collectionMethod:
                    widget.serviceReqArgs?.serviceReqEntity?.collectionMethod ??
                        "",
                branch:
                    widget.serviceReqArgs?.serviceReqEntity?.branchCode ?? "",
                address: widget.serviceReqArgs?.serviceReqEntity?.address ?? "",
                numberOfLeaves: int.parse(
                    widget.serviceReqArgs?.serviceReqEntity?.noOfLeaves ?? "0"),
                serviceCharge:
                    widget.serviceReqArgs?.serviceReqEntity?.noOfLeaves == "10"
                        ? widget.serviceReqArgs?.serviceChargeEntity
                            .serviceChargeNumOfLeaves10
                            .toString()
                        : widget.serviceReqArgs?.serviceChargeEntity
                            .serviceChargeNumOfLeaves20
                            .toString()),
          )
        : bloc.add(
            StatementRequestEvent(
                accountNumber:
                    widget.serviceReqArgs?.serviceReqEntity?.payFromNum ?? "",
                collectionMethod:
                    widget.serviceReqArgs?.serviceReqEntity?.collectionMethod ??
                        "",
                branch:
                    widget.serviceReqArgs?.serviceReqEntity?.branchCode ?? "",
                startDate: widget.serviceReqArgs?.serviceReqEntity?.startDate,
                endDate: widget.serviceReqArgs?.serviceReqEntity?.endDate,
                address: widget.serviceReqArgs?.serviceReqEntity?.address ?? "",
                // numberOfLeaves:int.parse(widget.serviceReqArgs
                //     ?.serviceReqEntity.noOfLeaves ?? "0"),
                serviceCharge: widget
                    .serviceReqArgs?.serviceChargeEntity.serviceChargeStatement
                    .toString()),
          );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
