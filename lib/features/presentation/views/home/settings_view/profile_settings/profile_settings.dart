
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../../../utils/app_validator.dart';
import '../../../../../../utils/enums.dart';
import '../../../../../../utils/navigation_routes.dart';
import '../../../../../data/datasources/local_data_source.dart';
import '../../../../bloc/settings/settings_bloc.dart';
import '../../../../bloc/settings/settings_event.dart';
import '../../../../bloc/settings/settings_state.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/text_fields/app_text_field.dart';
import '../../../../widgets/toast_widget/toast_widget.dart';
import '../../../base_view.dart';
import '../../../otp/otp_view.dart';
import 'full_view_of_profile_pic_view.dart';

class ProfileSettingsView extends BaseView {
  ProfileSettingsView({super.key});

  @override
  _ProfileSettingsViewState createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends BaseViewState<ProfileSettingsView> {
  final _bloc = injection<SettingsBloc>();

  // File? profileImage;
  bool isButtonEnabled = false;
  bool isUserEdit = false;

  TextEditingController? _cName;
  TextEditingController? _uName;
  TextEditingController? _name;
  TextEditingController? _mobileNum;
  TextEditingController? _email;
  TextEditingController? _nic;

  // TextEditingController? _fName;
  final localDataSource = injection<LocalDataSource>();
  final appValidator = injection<AppValidator>();
  String newUnameOnlyLetters = '';

  int lowercaseCount = 0;
  int uppercaseCount = 0;
  int digitCount = 0;
  int specialCharCount = 0;
  Map<String, int> repeatedCharCount = {};
  bool isTooManyRepeatedCharacters = false;
  bool isEmailValidated = true;
  int lowercaseCountInPP = 0;
  int numericValueCountInPP = 0;
  int specialCharCountInPP = 0;
  int upperCaseCountInPP = 0;
  int repeatedCharCountInPP = 0;
  int minLengthCountInPP = 0;
  int maxLengthCountInPP = 0;
  String userName = "";
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodeNickName = FocusNode();
  final FocusNode _focusNodeFullName = FocusNode();
  final FocusNode _focusNodeMobile = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cName = TextEditingController(
        text: (AppConstants.profileData.cName != null ||
                AppConstants.profileData.cName != "")
            ? AppConstants.profileData.cName
            : AppConstants.profileData.fName);
    _uName = TextEditingController(text: AppConstants.profileData.userName);
    _name = TextEditingController(text: AppConstants.profileData.name);
    _mobileNum = TextEditingController(
        text: AppConstants.profileData.mobileNo!.length == 10
            ? AppConstants.profileData.mobileNo!.substring(1)
            : AppConstants.profileData.mobileNo);
    _email = TextEditingController(text: AppConstants.profileData.email);
    _nic = TextEditingController(text: AppConstants.profileData.nic);
    // _fName = TextEditingController(text: AppConstants.profileData.fName);
    //nameParts.first = AppConstants.profileData.fName!;
    validateFields();
    _userNamePolicy();
    _savedDetails();
   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    super.initState();
  }

  void validateFields() {
    if (_cName?.text == null ||
        _cName?.text == "" ||
        _name?.text == null ||
        _name?.text == "" ||
        _uName?.text == null ||
        _uName?.text == "" ||
        _mobileNum?.text == null ||
        _mobileNum?.text.length == 9 ||
        _mobileNum?.text == "" ||
        _email?.text == null ||
        _email?.text == "" ||
        _validateUsernamePolicy() == false ||
        _mobileNumValidate() == false ||
        _emailValidate() == false ||
        _savedDetails() == true) {
      setState(() {
        isButtonEnabled = false;
      });
    } else {
      setState(() {
        isButtonEnabled = true;
      });
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("profile"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (context, state) {
            if (state is EditProfileDetailsSuccessState) {
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      phoneNumber: AppConstants.profileData.mobileNo.toString(),
                      appBarTitle: 'otp_verification',
                      requestOTP: true,
                      otpType: kProfileData,
                    )).then((value) {
                  if (value != null) {
                    if (value != false) {
                      ToastUtils.showCustomToast(
                          context,
                          AppLocalizations.of(context)
                              .translate("your_profile_setting_updated"),
                          ToastStatus.SUCCESS);
                      localDataSource.setLoginName(
                          _uName?.text ?? AppConstants.profileData.userName!);
                      localDataSource.setUserName(
                          _uName?.text ?? AppConstants.profileData.userName!);
                      AppConstants.profileData.mobileNo =
                          _mobileNum?.text ?? AppConstants.profileData.mobileNo!;
                      AppConstants.profileData.email =
                          _email?.text ?? AppConstants.profileData.email!;
                      AppConstants.profileData.userName =
                          _uName?.text ?? AppConstants.profileData.userName!;
                      AppConstants.profileData.name =
                          _name?.text ?? AppConstants.profileData.name!;
                      AppConstants.profileData.cName =
                          _cName?.text ??AppConstants.profileData.cName?? AppConstants.profileData.fName!;
                      Navigator.of(context)
                        ..pop()
                        ..pushReplacementNamed(Routes.kProfileDetailsView);
                    }
                  }
                });
            } else if (state is EditProfileDetailsFailState) {
              if(state.code == "01"){
                showAppDialog(
                  title: AppLocalizations.of(context).translate("username_already_exists"),
                  alertType: AlertType.WARNING,
                  message: AppLocalizations.of(context).translate("username_already_exists_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {},);
              }
              // else if(state.code == "02"){
              //   showAppDialog(
              //     title: AppLocalizations.of(context).translate("something_went_wrong"),
              //     alertType: AlertType.WARNING,
              //     message: state.message ?? AppLocalizations.of(context).translate("connection_could_not_be_made"),
              //     positiveButtonText: AppLocalizations.of(context).translate("ok"),
              //     onPositiveCallback: () {},);
              // }
              else {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
                Navigator.of(context)..pop;
              }
            } else if (state is GetHomeDetailsSuccessState) {}
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,0,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSizer.verticalSpacing(24.h),
                          Stack(children: [
                            AppConstants.profileData.profileImage != null
                                ? CircleAvatar(
                                    radius: 36.h,
                                    backgroundImage: MemoryImage(
                                        AppConstants.profileData.profileImage!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: const Color(0xFFCEE5D4),
                                    radius: 36.h,
                                    child: Text(
                                      (AppConstants.profileData.cName??
                                          AppConstants.profileData.fName??"").getNameInitial() ??
                                          "",
                                      style: size24weight400.copyWith(
                                      color: colors(context).greyColor200,fontSize: 40
                                    ),
                                    ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              top: 0,
                              child: InkWell(
                                child: PhosphorIcon(
                                  PhosphorIcons.cameraPlus(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).whiteColor,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.kViewProfilePicView,
                                    arguments: FullViewOfProfileArgs(
                                        image:
                                            AppConstants.profileData.profileImage,
                                        nickname:
                                            AppConstants.profileData.cName??
                                          AppConstants.profileData.fName??""),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 16).h,
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  children: [
                                    AppTextField(
                                      validator: (a) {
                                        if (_cName!.text.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .translate("mandatory_field_msg");
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: _focusNodeNickName,
                                      isInfoIconVisible: false,
                                      inputTextStyle: TextStyle(
                                        color: colors(context).blackColor,
                                        fontWeight: _focusNodeNickName.hasFocus
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                      inputType: TextInputType.text,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Z a-z ]")),
                                      ],
                                      hint: AppLocalizations.of(context)
                                          .translate("nickname"),
                                      title: AppLocalizations.of(context)
                                          .translate("nickname"),
                                      controller: _cName,
                                      onTextChanged: (value) {
                                        validateFields();
                                        isButtonEnabled = true;
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      validator: (a) {
                                        if (_uName!.text.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .translate("mandatory_field_msg");
                                        } else if (!_validateUsernamePolicy()) {
                                          return AppLocalizations.of(context).translate("enter_valid_username");
                                        }
                                        // else if (isUserEdit == true && _uName?.text == AppConstants.profileData.userName){
                                        //   return "Your entered Username is already taken. Try with a different userame.";
                                        // }
                                        else {
                                          return null;
                                        }
                                      },
                                      focusNode: _focusNodeUserName,
                                      isInfoIconVisible: false,
                                      infoIconText: userNameTooltip(),
                                      toolTipTitle: AppLocalizations.of(context)
                                          .translate("username_requirements"),
                                      hint: AppLocalizations.of(context)
                                          .translate("username"),
                                      controller: _uName,
                                      successfullyValidated:
                                          _validateUsernamePolicy(),
                                      inputTextStyle: TextStyle(
                                        color: colors(context).blackColor,
                                        fontWeight: _focusNodeUserName.hasFocus
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                      title: AppLocalizations.of(context)
                                          .translate("username"),
                                      onTextChanged: (value) {
                                        validateFields();
                                        isButtonEnabled = true;
                                        isUserEdit = true;
                                        _validateUsernamePolicy();
                                        setState(() {
                                          
                                        });
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      validator: (a) {
                                        if (_name!.text.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .translate("mandatory_field_msg");
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: _focusNodeFullName,
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("Full_Name"),
                                      inputTextStyle: TextStyle(
                                        color: colors(context).blackColor,
                                        fontWeight: _focusNodeFullName.hasFocus
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                      inputType: TextInputType.text,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Z a-z ]")),
                                      ],
                                      title: AppLocalizations.of(context)
                                          .translate("Full_Name"),
                                      controller: _name,
                                      onTextChanged: (value) {
                                        validateFields();
                                        isButtonEnabled = true;
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      isEnable: false,
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("NIC_number"),
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Z a-z]")),
                                      ],
                                      title: AppLocalizations.of(context)
                                          .translate("NIC_number"),
                                      controller: _nic,
                                      onTextChanged: (value) {
                                        validateFields();
                                        isButtonEnabled = true;
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      validator: (a) {
                                        if (_mobileNum!.text.isEmpty) {
                                          return AppLocalizations.of(context)
                                              .translate("mandatory_field_msg");
                                        } else if (_mobileNum!.text.length<9) {
                                          return AppLocalizations.of(context)
                                              .translate("enter_valid_mobile");
                                        }else {
                                          return null;
                                        }
                                      },
                                      focusNode: _focusNodeMobile,
                                      isEnable: true,
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("Mobile_Number"),
                                      inputTextStyle: TextStyle(
                                        color: colors(context).blackColor,
                                        fontWeight: _focusNodeMobile.hasFocus
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                      maxLength: 17,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      inputType: TextInputType.phone,
                                      title: AppLocalizations.of(context)
                                          .translate("Mobile_Number"),
                                      controller: _mobileNum,
                                      onTextChanged: (value) {
                                        validateFields();
                                        isButtonEnabled = true;
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      successfullyValidated: _emailValidate(),
                                      focusNode: _focusNodeEmail,
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("Email"),
                                      // inputTextStyle: TextStyle(
                                      //   color: _emailValidate()
                                      //       ? colors(context).blackColor
                                      //       : colors(context).negativeColor,
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      inputTextStyle: TextStyle(
                                        color: colors(context).blackColor,
                                        fontWeight: _focusNodeEmail.hasFocus
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                      validator: (value) {
                                        if (value != null) {
                                          if (value.length > 0) {
                                            if (appValidator
                                                .validateEmail(value)) {
                                              isEmailValidated = true;
                                            } else {
                                              isEmailValidated = false;
                                              return AppLocalizations.of(context).translate("enter_valid_email");
                                            }
                                          } else {
                                            isEmailValidated = false;
                                            return null;
                                          }
                                          // setState(() {});
                                        }
                                        return null;
                                      },
                                      onTextChanged: (value) {
                                        _emailValidate();
                                        validateFields();
                                        isButtonEnabled = true;
                                      },
                                      controller: _email,
                                      title: AppLocalizations.of(context)
                                          .translate("Email"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                          buttonText:
                          AppLocalizations.of(context).translate("save"),
                          buttonType: isButtonEnabled == true
                              ? ButtonType.PRIMARYENABLED
                              : ButtonType.PRIMARYDISABLED,
                          onTapButton: () {
                           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            if (_formKey.currentState?.validate() == false) {
                              return;
                            }
                            showAppDialog(
                              // onNegativeCallback: () {},

                                alertType: AlertType.USER2,
                                title: AppLocalizations.of(context)
                                    .translate("update_your_information_sec"),
                                message: AppLocalizations.of(context).translate(
                                    "update_your_information_sec_des"),
                                subDescription: formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??""),
                                subDescriptionColor:
                                colors(context).primaryColor,
                                positiveButtonText: AppLocalizations.of(context)
                                    .translate("done"),
                                onPositiveCallback: () {
                                  _bloc.add(
                                    UpdateProfileDetailsEvent(
                                      name: _name?.text ??
                                          AppConstants.profileData.name!,
                                      cName: _cName?.text ??AppConstants.profileData.cName??
                                          AppConstants.profileData.fName!,
                                      email: _email?.text ??
                                          AppConstants.profileData.email!,
                                      mobile: _mobileNum?.text ??
                                          AppConstants.profileData.mobileNo!,
                                      uName: _uName?.text.trim() ??
                                          AppConstants.profileData.userName!,
                                    ),
                                  );
                                });
                          }),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText:
                        AppLocalizations.of(context).translate("cancel"),
                        onTapButton: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      ),)
    );
  }

  List<String> userNameTooltip() {
    return [
      "${AppLocalizations.of(context).translate("at_least")} $minLengthCountInPP ${AppLocalizations.of(context).translate("characters")}.",
          "${AppLocalizations.of(context).translate("should_not_exceed")} $maxLengthCountInPP ${AppLocalizations.of(context).translate("characters")}",
          "${AppLocalizations.of(context).translate("at_least")} $lowercaseCountInPP ${AppLocalizations.of(context).translate("lowercase_letter")}",
          "${AppLocalizations.of(context).translate("at_least")} $upperCaseCountInPP ${AppLocalizations.of(context).translate("uppercase_letter")}",
          "${AppLocalizations.of(context).translate("should_not")} $repeatedCharCountInPP ${AppLocalizations.of(context).translate("repeated_characters")}",
          "${AppLocalizations.of(context).translate("at_least")} $numericValueCountInPP ${AppLocalizations.of(context).translate("numerical_characters")}",
          "${AppLocalizations.of(context).translate("at_least")} $specialCharCountInPP  ${AppLocalizations.of(context).translate("specials_character")}",
          "${AppLocalizations.of(context).translate("must_different_previous_username")}"
    ];
  }

  _userNamePolicy() {
    lowercaseCountInPP =
        localDataSource.getUserNamePolicy().minimumLowercaseChars!;
    numericValueCountInPP =
        localDataSource.getUserNamePolicy().minimumNumericalChars!;
    specialCharCountInPP =
        localDataSource.getUserNamePolicy().minimumSpecialChars!;
    upperCaseCountInPP =
        localDataSource.getUserNamePolicy().minimumUpperCaseChars!;
    repeatedCharCountInPP = localDataSource.getUserNamePolicy().repeatedChars!;
    minLengthCountInPP = localDataSource.getUserNamePolicy().minLength!;
    maxLengthCountInPP = localDataSource.getUserNamePolicy().maxLength!;
   
  }



    bool _validateUsernamePolicy() {
    final validateUsernameState =
        AppValidator.validateUsername(_uName!.text, AppConstants.userNamePolicy);
    if (validateUsernameState.validate == true) {
      return true;
    } else {
      return false;
    }
  }

  bool _mobileNumValidate() {
    if (_mobileNum?.text != null && (_mobileNum?.text.isNotEmpty ?? false)) {
      if (appValidator.validateMobileNmb(
          _mobileNum?.text[0] == "7" ? _mobileNum!.text : "0")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _emailValidate() {
    if (appValidator.validateEmail(_email!.text)) {
      return true;
    } else {
      return false;
    }
  }

  bool _savedDetails() {
    if (_cName == (AppConstants.profileData.cName ?? AppConstants.profileData.fName ??"")&&
        _uName == AppConstants.profileData.userName &&
        _name == AppConstants.profileData.name &&
        _mobileNum == AppConstants.profileData.mobileNo &&
        _email == AppConstants.profileData.email &&
        _nic == AppConstants.profileData.nic) {
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
