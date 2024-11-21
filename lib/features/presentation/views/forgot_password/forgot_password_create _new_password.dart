import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/app_validator.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class ForgotPasswordCreateNewPasswordView extends BaseView {
  ForgotPasswordCreateNewPasswordView({super.key});

  @override
  _ForgotPasswordCreateNewPasswordViewState createState() =>
      _ForgotPasswordCreateNewPasswordViewState();
}

class _ForgotPasswordCreateNewPasswordViewState
    extends BaseViewState<ForgotPasswordCreateNewPasswordView> {
  var bloc = injection<ForgetPasswordBloc>();
  bool firstTimeLogin = true;
  String newPW = '';
  String confirmPW = '';
  bool similarPswrd = false;

  final localDataSource = injection<LocalDataSource>();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final FocusNode _focusNode2 = FocusNode();
  bool passwordValidate = false;
  bool fieldValidator = false;
  bool passwordConfirm = false;
  bool passwordEntred = false;
  String username = '';
  String newPWOnlyLetters = '';
  String currentPW = '';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordPolicy();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("Create_a_New_Password"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ForgetPasswordBloc>(
        create: (context) => bloc,
        child: BlocListener<ForgetPasswordBloc, BaseState<ForgetPasswordState>>(
          listener: (context, state) async {
            if (state is ForgotPwResetReqSuccessState) {
              await localDataSource.clearEpicUserIdForDeepLink();
              ToastUtils.showCustomToast(
                  context,
                  AppLocalizations.of(context).translate("password_reset"),
                  ToastStatus.SUCCESS);
              Navigator.popUntil(
                  context, ModalRoute.withName(Routes.kLoginView));
            }
            if (state is ForgotPwResetReqFailedState) {
              await localDataSource.clearEpicUserIdForDeepLink();
              showAppDialog(
                  title: AppLocalizations.of(context).translate("failed"),
                  message: state.message ?? AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  alertType: AlertType.FAIL,
                  onPositiveCallback: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(Routes.kLoginView));
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
                                AppAssets.createNewPasswordView,
                              ),
                            ),
                            20.verticalSpace,
                            Text(
                              AppLocalizations.of(context)
                                  .translate("your_new_password"),
                              style: size16weight400.copyWith(
                                  color: colors(context).greyColor),
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
                              isInfoIconVisible: true,
                              focusNode: _focusNode2,
                              controller: newController,
                              infoIconText: passwordTooltip(),
                              successfullyValidated: pswrdValidate(),
                              toolTipTitle: AppLocalizations.of(context)
                                  .translate("password_requirements"),
                              hint: AppLocalizations.of(context)
                                  .translate("enter_new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("new_password"),
                              obscureText: true,
                              onTextChanged: (value) {
                                setState(() {
                                  newPW = value.trim();
                                });
                              },
                            ),
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
                              hint: AppLocalizations.of(context)
                                  .translate("confirm_new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("confirm_new_password"),
                              controller: confirmController,
                              textCapitalization: TextCapitalization.none,
                              successfullyValidated: (newPW == confirmPW),
                              obscureText: true,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  AppButton(
                    // buttonType: _isValidated()
                    //     ? ButtonType.PRIMARYENABLED
                    //     : ButtonType.PRIMARYDISABLED,
                    buttonText: AppLocalizations.of(context)
                        .translate("change_password"),
                    onTapButton: () {
                      if (_formKey.currentState?.validate() == false && !_isValidated()) {
                        return;
                      }
                      final validatePasswordState =
                          AppValidator.validatePassword(
                              newPW, AppConstants.passwordPolicy);
                      if (validatePasswordState.validate == true) {
                        bloc.add(ForgotPwResetReqEvent(
                          confirmPassword: confirmPW.toBase64(),
                          newPassword: newPW.toBase64(),
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

  bool _isValidated() {
    if (newPW == "" || confirmPW == "" || newPW != confirmPW) {
      return false;
    }
    return true;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
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

  bool fieldValidate() {
    if (newController.text.isEmpty) {
      return false;
    } else if (confirmController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
