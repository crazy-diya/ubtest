import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/enums.dart';
import '../../../../../../utils/navigation_routes.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../bloc/reset_password/reset_password_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../otp/otp_view.dart';

class PasswordExpiredChangePasswordView extends BaseView {
  final bool isFromPwdExpired;

  PasswordExpiredChangePasswordView({this.isFromPwdExpired = false});

  @override
  _PasswordExpiredChangePasswordViewState createState() =>
      _PasswordExpiredChangePasswordViewState();
}

class _PasswordExpiredChangePasswordViewState
    extends BaseViewState<PasswordExpiredChangePasswordView> {
  var bloc = injection<ResetPasswordBloc>();
  final localDataSource = injection<LocalDataSource>();
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool firstTimeLogin = true;
  bool passwordValidate = false;
  bool passwordConfirm = false;
  bool similarPswrd = false;
  bool passwordEntred = false;
  bool fieldValidator = false;
  String username = '';
  String newPW = '';
  String newPWOnlyLetters = '';
  String currentPW = '';
  String confirmPW = '';

  int lowercaseCount = 0;
  int uppercaseCount = 0;
  int digitCount = 0;
  int specialCharCount = 0;
  Map<String, int> repeatedCharCount = {};
  bool isTooManyRepeatedCharacters = false;

  bool accordingToPPmaxlength = false;
  bool accordingToPPminlength = false;
  bool accordingToPPlowercaseCount = false;
  bool accordingToPPuppercaseCount = false;
  bool accordingToPPdigitCount = false;
  bool accordingToPPspecialCharCount = false;
  bool accordingToPPrepeatedCharCount = false;

  int lowercaseCountInPP = 0;
  int numericValueCountInPP = 0;
  int specialCharCountInPP = 0;
  int upperCaseCountInPP = 0;
  int repeatedCaseCountInPP = 0;
  int minLengthCountInPP = 0;

  @override
  void initState() {
    super.initState();
    _passwordPolicy();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("create_new_password"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => bloc,
        child: BlocListener<ResetPasswordBloc, BaseState<ResetPasswordState>>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              Navigator.pushNamed(context, Routes.kOtpView,
                  arguments: OTPViewArgs(
                    phoneNumber: AppConstants.profileData.mobileNo.toString(),
                    appBarTitle: 'otp_verification',
                    requestOTP: true,
                    otpType: "changepassword",
                  )).then((value) {
                if (value != null) {
                  // _validatePasswords();
                  if (value == true) {
                    ToastUtils.showCustomToast(
                        context,
                        state.responseDescription ?? AppLocalizations.of(context).translate("success"),
                        ToastStatus.SUCCESS);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kLoginView,
                      (route) => false,
                    );
                  }
                } else {}
              });
            }
            if (state is ResetPasswordFailState) {
              showAppDialog(
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                  message: state.message,
                  alertType: AlertType.FAIL,
                  onPositiveCallback: () {
                    _focusNode1.requestFocus();
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("ok"));
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.newPassword,
                              ),
                            ),
                            20.verticalSpace,
                            widget.isFromPwdExpired
                                ? Text(
                                    AppLocalizations.of(context)
                                        .translate("create_new_pw_des"),
                                    style: size16weight400.copyWith(
                                        color: colors(context).greyColor),
                                    textAlign: TextAlign.start,
                                  )
                                : Text( AppLocalizations.of(context).translate("pwd_reset_des"),
                                    style: size16weight400.copyWith(
                                        color: colors(context).greyColor),
                                    textAlign: TextAlign.start,
                                  ),
                            20.verticalSpace,
                            AppTextField(
                              validator: (a) {
                                if (currentController.text.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              isInfoIconVisible: false,
                              hint: AppLocalizations.of(context)
                                  .translate("current_password"),
                              title: AppLocalizations.of(context)
                                  .translate("current_password"),
                              controller: currentController,
                              focusNode: _focusNode1,
                              obscureText: true,
                              textCapitalization: TextCapitalization.none,
                              onTextChanged: (value) {
                                fieldValidator = fieldValidate();
                                setState(() {
                                  currentPW = value.trim();
                                });

                                if (currentPW == newPW) {
                                  similarPswrd = true;
                                  setState(() {});
                                } else {
                                  similarPswrd = false;
                                  setState(() {});
                                }
                              },
                            ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (a) {
                                if (newController.text.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else if (!pswrdValidate()) {
                                  return AppLocalizations.of(context)
                                      .translate("password_policy_des");
                                } else {
                                  return null;
                                }
                              },
                              toolTipRightPadding: 15.w,
                              controller: newController,
                              focusNode: _focusNode2,
                              isInfoIconVisible: true,
                              infoIconText: passwordTooltip(),
                              toolTipTitle: AppLocalizations.of(context)
                                  .translate("password_requirements"),
                              hint: AppLocalizations.of(context)
                                  .translate("new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("new_password"),
                              successfullyValidated: pswrdValidate(),
                              obscureText: true,
                              textCapitalization: TextCapitalization.none,
                              onTextChanged: (value) {
                                fieldValidator = fieldValidate();
                                newPW = value.trim();
                                passwordEntred = true;
                                if (currentPW == newPW) {
                                  similarPswrd = true;
                                  setState(() {});
                                } else {
                                  similarPswrd = false;
                                  setState(() {});
                                }
                                pswrdValidate();
                                setState(() {});
                              },
                            ),
                            // 0.96.verticalSpace,
                            // Visibility(
                            //   visible: pswrdValidate() == false &&
                            //       newController.text.isNotEmpty,
                            //   child: Text(
                            //     AppLocalizations.of(context)
                            //         .translate("password_policy_des"),
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 3.5.sp,
                            //       color: pswrdValidate() == true
                            //           ? colors(context).blackColor
                            //           : colors(context).negativeColor,
                            //     ),
                            //   ),
                            // ),
                            // 0.96.verticalSpace,
                            // Visibility(
                            //   visible: (similarPswrd == true),
                            //   child: Text(
                            //     AppLocalizations.of(context)
                            //         .translate("password_mismatch_des"),
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 3.5.sp,
                            //       color: colors(context).negativeColor,
                            //     ),
                            //   ),
                            // ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (a) {
                                if (confirmController.text.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else if (newPW != confirmPW) {
                                  return AppLocalizations.of(context)
                                      .translate("password_mismatch_des");
                                } else {
                                  return null;
                                }
                              },
                              isInfoIconVisible: false,
                              controller: confirmController,
                              hint: AppLocalizations.of(context)
                                  .translate("confirm_new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("confirm_new_password"),
                              obscureText: true,
                              textCapitalization: TextCapitalization.none,
                              successfullyValidated: (newPW == confirmPW),
                              onTextChanged: (value) {
                                fieldValidator = fieldValidate();
                                passwordConfirm = true;
                                confirmPW = value.trim();
                                if (currentPW == newPW) {
                                  similarPswrd = true;
                                  setState(() {});
                                } else {
                                  similarPswrd = false;
                                  setState(() {});
                                }
                                setState(() {});
                              },
                            ),
                            // 0.96.verticalSpace,
                            // if (passwordConfirm == true && newPW != confirmPW)
                            //   Text(
                            //     AppLocalizations.of(context)
                            //         .translate("password_does_not_match"),
                            //     style: TextStyle(
                            //       color: colors(context).negativeColor,
                            //     ),
                            //     textAlign: TextAlign.left,
                            //   ),
                            // 1.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  AppButton(
                    // buttonType: passwordConfirm == true &&
                    //         newPW == confirmPW &&
                    //         fieldValidator &&
                    //         pswrdValidate() &&
                    //         similarPswrd == false
                    //     ? ButtonType.PRIMARYENABLED
                    //     : ButtonType.PRIMARYDISABLED,
                    buttonText: AppLocalizations.of(context)
                        .translate("change_password"),
                    onTapButton: () {
                      if (_formKey.currentState?.validate() == false || passwordConfirm == false || newPW != confirmPW || !fieldValidate()) {
                        return;
                      }
                      _validatePasswords();
                      final validatePasswordState =
                          AppValidator.validatePassword(
                              newPW, AppConstants.passwordPolicy);
                      if (validatePasswordState.validate == true) {
                        bloc.add(ResetCurrentPasswordEvent(
                          oldPassword: currentPW.toBase64(),
                          newPassword: newPW.toBase64(),
                          confirmPassword: confirmPW.toBase64(),
                          isAdminPasswordReset: false
                        ));
                      } else {
                        String data;
                        if (validatePasswordState.isAppString) {
                          data = AppLocalizations.of(context)
                              .translate(validatePasswordState.description!);
                        } else {
                          data = validatePasswordState.description!;
                        }
                        // ToastUtils.showCustomToast(
                        //     context, data, ToastStatus.FAIL);
                      }
                      // _onTap();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validatePasswords() {
    if (newPW == confirmPW) {
      setState(() {
        //Navigator.pushNamed(context, Routes.kSecurityQuestionsView);
      });
    } else {}
  }

  bool pswrdValidate() {
    final validatePasswordState =
        AppValidator.validatePassword(newPW, AppConstants.passwordPolicy);
    if (validatePasswordState.validate == true) {
      return true;
    } else {
      return false;
    }
  }

  List<String> passwordTooltip() {
    return [
      "${AppLocalizations.of(context).translate("at_least")} $minLengthCountInPP ${AppLocalizations.of(context).translate("characters")}",
      "${AppLocalizations.of(context).translate("at_least")} $lowercaseCountInPP ${AppLocalizations.of(context).translate("lowercase")} ${lowercaseCountInPP >= 2 ? "${AppLocalizations.of(context).translate("letters")}" : "${AppLocalizations.of(context).translate("letter")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $upperCaseCountInPP ${AppLocalizations.of(context).translate("uppercase")} ${upperCaseCountInPP >= 2 ?  "${AppLocalizations.of(context).translate("letters")}" : "${AppLocalizations.of(context).translate("letter")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $numericValueCountInPP ${numericValueCountInPP >= 2 ? "${AppLocalizations.of(context).translate("numbers")}" : "${AppLocalizations.of(context).translate("number")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $specialCharCountInPP ${AppLocalizations.of(context).translate("special")} ${specialCharCountInPP >= 2 ? "${AppLocalizations.of(context).translate("characters")}" : "${AppLocalizations.of(context).translate("character")}"} ",
      "${AppLocalizations.of(context).translate("not_more_than")} $repeatedCaseCountInPP repeat ${repeatedCaseCountInPP >= 2 ? "${AppLocalizations.of(context).translate("characters")}" : "${AppLocalizations.of(context).translate("character")}"} ",
      "${AppLocalizations.of(context).translate("must_different_password")}",
      "${AppLocalizations.of(context).translate("no_part_your_name")}"
    ];
  }

  _passwordPolicy() {
    lowercaseCountInPP =
        localDataSource.getPasswordPolicy().minimumLowercaseChars!;
    numericValueCountInPP =
        localDataSource.getPasswordPolicy().minimumNumericalChars!;
    specialCharCountInPP =
        localDataSource.getPasswordPolicy().minimumSpecialChars!;
    upperCaseCountInPP =
        localDataSource.getPasswordPolicy().minimumUpperCaseChars!;
    repeatedCaseCountInPP = localDataSource.getPasswordPolicy().repeatedChars!;
    minLengthCountInPP = localDataSource.getPasswordPolicy().minLength!;
  }

  bool fieldValidate() {
    if (currentController.text.isEmpty) {
      return false;
    } else if (newController.text.isEmpty) {
      return false;
    } else if (confirmController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
