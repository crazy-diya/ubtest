import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/user_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/datasources/local_data_source.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/on_boarding/create_user/create_user_bloc.dart';
import '../../../bloc/on_boarding/create_user/create_user_event.dart';
import '../../../bloc/on_boarding/create_user/create_user_state.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';

class OtherBankSetupLoginDetailsView extends BaseView {
  OtherBankSetupLoginDetailsView({super.key});

  @override
  _OtherBankSetupLoginDetailsViewState createState() =>
      _OtherBankSetupLoginDetailsViewState();
}

class _OtherBankSetupLoginDetailsViewState
    extends BaseViewState<OtherBankSetupLoginDetailsView> {
  final _bloc = injection<CreateUserBloc>();
  String username = '';
  final localDataSource = injection<LocalDataSource>();
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
  String newPW = '';
  String confirmPW = '';
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

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    
    super.initState();
    _passwordPolicy();
    _userNamePolicy();
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
                 Navigator.pushNamed(
                        context, Routes.kOtherBankSecurityQuestionsView,
                        arguments: UserData(
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
              padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,(20.h + AppSizer.getHomeIndicatorStatus(context))),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
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
                              AppLocalizations.of(context)
                                  .translate("create_user_name_and"),
                              style: size16weight400.copyWith(color: colors(context).greyColor) ,
                            ),
                            24.verticalSpace,

                            AppTextField(
                               validator: (value) {
                                  if (value == null || value == '') {
                                    return AppLocalizations.of(context).translate("mandatory_field_msg");
                                  } else if (!userNameValidate()) {
                                    return AppLocalizations.of(context)
                                        .translate("username_policy_des");
                                  }else {
                                    return null;
                                  }
                                },
                              isInfoIconVisible: true,
                              infoIconText: userNameTooltip(),
                              toolTipTitle:  AppLocalizations.of(context)
                                  .translate("username_requirements"),
                              hint: AppLocalizations.of(context)
                                  .translate("user_name"),
                              isLabel: false,
                              title: AppLocalizations.of(context)
                                  .translate("user_name"),
                              onTextChanged: (value) {
                                setState(() {
                                  username = value.trim();
                                });
                              },
                            ),
                            24.verticalSpace,
                            AppTextField(
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return AppLocalizations.of(context).translate("mandatory_field_msg");
                                  } else if (!pswrdValidate()) {
                                    return AppLocalizations.of(context)
                                        .translate("password_policy_des");
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                isInfoIconVisible: true,

                                infoIconText: passwordTooltip(),
                              toolTipTitle: AppLocalizations.of(context)
                                  .translate("password_requirements"),
                                hint: AppLocalizations.of(context)
                                    .translate("new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("new_password"),
                                isLabel: false,
                                obscureText: true,
                                // inputFormatter: [
                                //   FilteringTextInputFormatter.allow(RegExp(
                                //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                                // ],
                                onTextChanged: (value) {
                                  setState(() {
                                    newPW = value.trim();
                                  });
                                },
                              ),
                            24.verticalSpace,
                            AppTextField(
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return AppLocalizations.of(context).translate("mandatory_field_msg");
                                  } else if(newPW != confirmPW){
                                    return AppLocalizations.of(context).translate("password_does_not_match");
                                  }else {
                                    return null;
                                  }
                                },
                              onTextChanged: (value){
                                confirmPW = value.trim();
                                setState(() {});
                              },
                                isInfoIconVisible: false,
                                hint: AppLocalizations.of(context)
                                    .translate("confirm_new_password"),
                              title: AppLocalizations.of(context)
                                  .translate("confirm_new_password"),
                                isLabel: false,
                                obscureText: true,
                                // inputFormatter: [
                                //   FilteringTextInputFormatter.allow(RegExp(
                                //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                                // ],
                                // inputTextStyle:
                                //     (confirmPW.length >= 3 && newPW != confirmPW)
                                //         ?
                                //     size16weight700.copyWith(
                                //         color: colors(context).negativeColor)
                                //         : null,
                                // onTextChanged: (value) {
                                //   setState(() {
                                //     confirmPW = value;
                                //   });
                                // },
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                 20.verticalSpace,
                  AppButton(
                    buttonText: AppLocalizations.of(context).translate("next"),
                    buttonType:ButtonType.PRIMARYENABLED,
                    onTapButton: () {
                         if (_formkey.currentState?.validate() == false) {
                          return;
                        }
                     final validatePasswordState = AppValidator.validatePassword(
                          newPW, AppConstants.passwordPolicy);
                      final validateUsernameState = AppValidator.validateUsername(
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
                        ToastUtils.showCustomToast(
                            context, data, ToastStatus.FAIL);
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
      "${AppLocalizations.of(context).translate("should_not_exceed")} $maxLengthCountInPP ${AppLocalizations.of(context).translate("characters")} ",
      "${AppLocalizations.of(context).translate("at_least")} $lowercaseCountInPP ${AppLocalizations.of(context).translate("lowercase")} ${lowercaseCountInPP >= 2 ? "${AppLocalizations.of(context).translate("letters")}" : "${AppLocalizations.of(context).translate("letter")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $upperCaseCountInPP ${AppLocalizations.of(context).translate("uppercase")} ${upperCaseCountInPP >= 2 ?  "${AppLocalizations.of(context).translate("letters")}" : "${AppLocalizations.of(context).translate("letter")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $numericValueCountInPP ${numericValueCountInPP >= 2 ? "${AppLocalizations.of(context).translate("numbers")}" : "${AppLocalizations.of(context).translate("number")}"} ",
      "${AppLocalizations.of(context).translate("at_least")} $specialCharCountInPP ${AppLocalizations.of(context).translate("special")} ${specialCharCountInPP >= 2 ? "${AppLocalizations.of(context).translate("characters")}" : "${AppLocalizations.of(context).translate("character")}"} ",
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
    

    // if (newPW.contains(RegExp(r'[^0-9]'))) {
    //   newPWOnlyLetters = newPW.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    // }
    // lowercaseCount = newPWOnlyLetters.codeUnits
    //     .where((charCode) =>
    //         String.fromCharCode(charCode).toLowerCase() ==
    //         String.fromCharCode(charCode))
    //     .length;

    // RegExp digitRegExp = RegExp(r'\d');
    // Iterable<Match> matches = digitRegExp.allMatches(newPW);
    // digitCount = matches.length;

    // RegExp specialCharRegExp = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]');
    // Iterable<Match> specialChar = specialCharRegExp.allMatches(newPW);
    // specialCharCount = specialChar.length;

    // uppercaseCount = newPW.codeUnits
    //     .where((charCode) =>
    //         String.fromCharCode(charCode).toUpperCase() ==
    //         String.fromCharCode(charCode))
    //     .length;

    // repeatedCharCount.clear();
    // newPW.runes.forEach((int rune) {
    //   var char = String.fromCharCode(rune).toLowerCase();
    //   repeatedCharCount[char] = (repeatedCharCount[char] ?? 0) + 1;
    // });
    // repeatedCharCount.forEach((key, value) {
    //   if (value > repeatedCaseCountInPP) {
    //     isTooManyRepeatedCharacters = true;
    //   } else {
    //     isTooManyRepeatedCharacters = false;
    //   }
    // });
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

    // if (newUN.contains(RegExp(r'[^0-9]'))) {
    //   newUNOnlyLetters = newUN.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    // }
    // lowercaseCount = newUNOnlyLetters.codeUnits
    //     .where((charCode) =>
    //         String.fromCharCode(charCode).toLowerCase() ==
    //         String.fromCharCode(charCode))
    //     .length;

    // RegExp digitRegExp = RegExp(r'\d');
    // Iterable<Match> matches = digitRegExp.allMatches(newUN);
    // digitCount = matches.length;

    // RegExp specialCharRegExp = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]');
    // Iterable<Match> specialChar = specialCharRegExp.allMatches(newUN);
    // specialCharCount = specialChar.length;

    // uppercaseCount = newUN.codeUnits
    //     .where((charCode) =>
    //         String.fromCharCode(charCode).toUpperCase() ==
    //         String.fromCharCode(charCode))
    //     .length;

    // repeatedCharCount.clear();
    // newUN.runes.forEach((int rune) {
    //   var char = String.fromCharCode(rune).toLowerCase();
    //   repeatedCharCount[char] = (repeatedCharCount[char] ?? 0) + 1;
    // });
    // repeatedCharCount.forEach((key, value) {
    //   if (value > repeatedCaseCountInPP) {
    //     isTooManyRepeatedCharacters = true;
    //   } else {
    //     isTooManyRepeatedCharacters = false;
    //   }
    // });
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
