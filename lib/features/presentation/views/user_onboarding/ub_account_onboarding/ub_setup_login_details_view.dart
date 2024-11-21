// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/user_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/datasources/local_data_source.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';

class UBSetupLoginDetailsView extends BaseView {
  final String? appBarTitle;
  UBSetupLoginDetailsView({
    this.appBarTitle,
  });

  @override
  _UBSetupLoginDetailsViewState createState() =>
      _UBSetupLoginDetailsViewState();
}

class _UBSetupLoginDetailsViewState
    extends BaseViewState<UBSetupLoginDetailsView> {
  final _bloc = injection<CreateUserBloc>();

  bool firstTimeLogin = true;
  final localDataSource = injection<LocalDataSource>();
  String username = '';
  String newPW = '';
  String confirmPW = '';
  bool passwordHidden = true;
  bool confirmPasswordHidden = true;
  int lowercaseCount = 0;
  int uppercaseCount = 0;
  int digitCount = 0;
  int specialCharCount = 0;
  Map<String, int> repeatedCharCount = {};
  bool isTooManyRepeatedCharacters = false;

  String newUN = '';
  String newPWOnlyLetters = '';
  String newUNOnlyLetters = '';
  final _formkey = GlobalKey<FormState>();
  int lowercaseCountInPP = 0;
  int numericValueCountInPP = 0;
  int specialCharCountInPP = 0;
  int upperCaseCountInPP = 0;
  int repeatedCaseCountInPP = 0;
  int minLengthCountInPP = 0;
  int lowercaseCountInUN = 0;
  int numericValueCountInUN = 0;
  int specialCharCountInUN = 0;
  int upperCaseCountInUN = 0;
  int repeatedCaseCountInUN = 0;
  int minLengthCountInUN = 0;
  int maxLengthCountInPP = 0;
  int maxLengthCountInUN = 0;
  final _scrollController = ScrollController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController confirmPWdController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordPolicy();
    _userNamePolicy();
    _scrollController.addListener(_onScrollDraft);
  }

  _onScrollDraft(){
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("setup_login_detail"),
        goBackEnabled: true,
      ),
      body: BlocProvider<CreateUserBloc>(
        create: (context) => _bloc,
        child: BlocListener<CreateUserBloc, BaseState<CreateUserState>>(
          listener: (context, state) {
            if (state is CheckUserSuccessState) {
              Navigator.pushNamed(context, Routes.kUBSecurityQuestionsView,
                  arguments: UserData(
                      appBarTitle: widget.appBarTitle!,
                      username: username,
                      confirmPass: confirmPW,
                      currentPass: newPW));
            }
            else if (state is CheckUserFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context) ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.fogotPasswordRecovery,
                                width: 200.w,
                              ),
                            ),
                            28.verticalSpace,
                            Text(
                              AppLocalizations.of(context).translate("create_user_name_and"),
                                style: size16weight400.copyWith(color: colors(context).greyColor) ,
                            ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (a){
                                if(userNameController.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else if(!userNameValidate()) {
                                  return AppLocalizations.of(context)
                                      .translate("username_policy_des");
                                } else{
                                  return null;
                                }
                              },
                              isInfoIconVisible: true,
                              controller: userNameController,
                              successfullyValidated: userNameValidate(),
                              infoIconText: userNameTooltip(),
                              toolTipTitle: AppLocalizations.of(context).translate("username_requirements"),
                              hint: AppLocalizations.of(context).translate("enter_username"),
                              isLabel: false,
                              title: AppLocalizations.of(context).translate("user_name"),
                              // action: SvgPicture.asset(
                              //   AppImages.icInfo2,
                              // ),
                              onTextChanged: (value) {
                                setState(() {
                                  username = value.trim();
                                  userNameValidate();
                                });
                              },
                            ),
                            // 0.96.verticalSpace,
                            // Visibility(
                            //   visible: userNameValidate() == false &&
                            //       userNameController.text.isNotEmpty,
                            //   child: Text(
                            //     AppLocalizations.of(context)
                            //         .translate("username_policy_des"),
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 3.5.sp,
                            //       color: userNameValidate() == true
                            //           ? colors(context).blackColor
                            //           : colors(context).negativeColor,
                            //     ),
                            //   ),
                            // ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (a){
                                if(passwordController.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else if(!pswrdValidate()) {
                                  return AppLocalizations.of(context)
                                      .translate("password_policy_des");
                                } else{
                                  return null;
                                }
                              },
                              // validator: (a){
                              //   if(passwordController.text.isEmpty){
                              //     return AppLocalizations.of(context)
                              //         .translate("mandatory_field_msg");
                              //   } else if(!pswrdValidate()) {
                              //     return AppLocalizations.of(context)
                              //         .translate("password_policy_des");
                              //   } else{
                              //     return null;
                              //   }
                              // },
                              isInfoIconVisible: true,
                              controller: passwordController,
                              infoIconText: passwordTooltip(),
                              successfullyValidated: pswrdValidate(),
                              toolTipTitle: AppLocalizations.of(context).translate("password_requirements"),
                              hint: AppLocalizations.of(context).translate("enter_password"),
                              isLabel: false,
                              obscureText: true,
                              title:AppLocalizations.of(context).translate("password"),
                              // inputFormatter: [
                              //   FilteringTextInputFormatter.allow(RegExp(
                              //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                              // ],
                              onTextChanged: (value) {
                                setState(() {
                                  newPW = value.trim();
                                  pswrdValidate();
                                });
                              },
                            ),
                            // 0.96.verticalSpace,
                            // Visibility(
                            //   visible: pswrdValidate() == false &&
                            //       passwordController.text.isNotEmpty,
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
                            24.verticalSpace,
                            AppTextField(
                              validator: (a){
                                if(confirmPWdController.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else if(newPW != confirmPW){
                                  return AppLocalizations.of(context)
                                      .translate("your_entered_passwords_mismatch_des");
                                }else{
                                  return null;
                                }
                              },
                              controller: confirmPWdController,
                              isInfoIconVisible: false,
                              hint: AppLocalizations.of(context)
                                  .translate("confirm_password"),
                              title: AppLocalizations.of(context)
                                  .translate("confirm_password"),
                              isLabel: false,
                              obscureText: true,
                              // inputFormatter: [
                              //   FilteringTextInputFormatter.allow(RegExp(
                              //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                              // ],
                              // inputTextStyle:
                              //     (confirmPW.length >= 3 && newPW != confirmPW)
                              //         ? TextStyle(
                              //             fontSize: 5.sp,
                              //             fontWeight: FontWeight.w600,
                              //             letterSpacing: 10.0,
                              //             color: colors(context).negativeColor,
                              //           )
                              //         : null,
                              onTextChanged: (value) {
                                setState(() {
                                  confirmPW = value.trim();
                                });
                              },
                            ),
                            // if (confirmPW.length >= 3 && newPW != confirmPW)
                            //   Text(
                            //     AppLocalizations.of(context)
                            //         .translate("password_does_not_match"),
                            //     style: TextStyle(
                            //       color: colors(context).negativeColor,
                            //     ),
                            //     textAlign: TextAlign.left,
                            //   ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  AppButton(
                    buttonText: AppLocalizations.of(context).translate("next"),
                    buttonType: ButtonType.PRIMARYENABLED,
                    onTapButton: () {
                      if (_formkey.currentState?.validate() == false || pswrdValidate == false || userNameValidate == false) {
                        return;
                      }
                      final validatePasswordState =
                          AppValidator.validatePassword(
                              newPW, AppConstants.passwordPolicy);
                      final validateUsernameState =
                          AppValidator.validateUsername(
                              username, AppConstants.userNamePolicy);
                      if (validateUsernameState.validate == true) {
                        if (validatePasswordState.validate == true) {
                          _bloc.add(CheckUserEvent(username: username));
                        } else {
                          String data;
                          if (validatePasswordState.isAppString) {
                            data = AppLocalizations.of(context)
                                .translate(validatePasswordState.description!);
                          } else {
                            data = validatePasswordState.description!;
                          }
                          ToastUtils.showCustomToast(
                              context, data, ToastStatus.FAIL);
                        }
                      } else {
                        String data;
                        if (validateUsernameState.isAppString) {
                          data = AppLocalizations.of(context)
                              .translate(validateUsernameState.description!);
                        } else {
                          data = validateUsernameState.description!;
                        }
                        // ToastUtils.showCustomToast(
                        //     context, data, ToastStatus.FAIL);
                      }
                    },
                  ),
                  AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  bool userNameValidate() {
    final validateUserNameState =
    AppValidator.validateUsername(username, AppConstants.userNamePolicy);
    if (validateUserNameState.validate == true) {
      return true;
    } else {
      return false;
    }
  }

  List<String> passwordTooltip() {
    return [
      "${AppLocalizations.of(context).translate("at_least")} $minLengthCountInPP ${AppLocalizations.of(context).translate("characters")}",
      "${AppLocalizations.of(context).translate("should_not_exceed")} $maxLengthCountInPP ${AppLocalizations.of(context).translate("characters")}",
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
    maxLengthCountInPP = localDataSource.getPasswordPolicy().maxLength!;
  }

  List<String> userNameTooltip() {
    return [
      "${AppLocalizations.of(context).translate("at_least")} $minLengthCountInUN ${AppLocalizations.of(context).translate("characters")}.",
      "${AppLocalizations.of(context).translate("should_not_exceed")} $maxLengthCountInUN ${AppLocalizations.of(context).translate("characters")}",
      "${AppLocalizations.of(context).translate("at_least")} $lowercaseCountInUN ${AppLocalizations.of(context).translate("lowercase_letter")}",
      "${AppLocalizations.of(context).translate("at_least")} $upperCaseCountInUN ${AppLocalizations.of(context).translate("uppercase_letter")}",
      "${AppLocalizations.of(context).translate("should_not")} $repeatedCaseCountInUN ${AppLocalizations.of(context).translate("repeated_characters")}",
      "${AppLocalizations.of(context).translate("at_least")} $numericValueCountInUN ${AppLocalizations.of(context).translate("numerical_characters")}",
      "${AppLocalizations.of(context).translate("at_least")} $specialCharCountInUN  ${AppLocalizations.of(context).translate("specials_character")}",
    ];
  }

  _userNamePolicy() {
    lowercaseCountInUN =
        localDataSource.getUserNamePolicy().minimumLowercaseChars!;
    numericValueCountInUN =
        localDataSource.getUserNamePolicy().minimumNumericalChars!;
    specialCharCountInUN =
        localDataSource.getUserNamePolicy().minimumSpecialChars!;
    upperCaseCountInUN =
        localDataSource.getUserNamePolicy().minimumUpperCaseChars!;
    repeatedCaseCountInUN = localDataSource.getUserNamePolicy().repeatedChars!;
    minLengthCountInUN = localDataSource.getUserNamePolicy().minLength!;
    maxLengthCountInUN = localDataSource.getUserNamePolicy().maxLength!;
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
