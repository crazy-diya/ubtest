import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/ub_account_onboarding/ub_terms_and_conditions_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/input_formatters.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_event.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../otp/otp_view.dart';
import '../../login_view/login_view.dart';

class UbRegisterDetailsView extends BaseView {
  UbRegisterDetailsView({super.key});

  @override
  _UbRegisterDetailsViewState createState() => _UbRegisterDetailsViewState();
}

class _UbRegisterDetailsViewState extends BaseViewState<UbRegisterDetailsView> {
  final ContactInformationBloc _bloc = injection<ContactInformationBloc>();
  final localDataSource = injection<LocalDataSource>();
  TextEditingController identificationNumController = TextEditingController();
  String? accountNu, identificatioNum, nickName;
  String? selectedIdType = 'NIC';
  bool nicValidated = true;
  final _formkey = GlobalKey<FormState>();
  final AppValidator appValidator = AppValidator();

  final idFocusNode = FocusNode();





  bool validateFields() {
    if (accountNu == null || accountNu == "") {
      return false;
    } else if (nickName == null || nickName == "") {
      return false;
    } else if (nicValidated == false ||
        identificatioNum == null ||
        identificatioNum == "") {
      return false;
    } else {
      return true;
    }
  }

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("union_bank_account"),
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (_, state) {
            if (state is CdbAccountVerificationSuccessState) {
              if (state.code == "00") {
                Navigator.pushNamed(context, Routes.kUBAccountTnCView,
                        arguments: TermsArgs(
                            termsType: kTermType,
                            appBarTitle: 'terms_and_conditions'))
                    .then((value) {
                  if (value is bool && value) {
                    Navigator.pushNamed(
                      context,
                      Routes.kOtpView,
                      arguments: OTPViewArgs(
                        isSingleOTP: false,
                        otpResponseArgs: OtpResponseArgs(
                          isOtpSend: false,
                        ),
                        otpType: kOtpMessageTypeOnBoarding,
                        title: AppLocalizations.of(context)
                            .translate("mobile_number_and_email_verification"),
                        routeName: Routes.kUBSetupLoginDetailsView,
                        requestOTP: true,
                        appBarTitle: 'otp_verification',
                      ),
                    );
                  }
                });
              } else if (state.code == "01") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("already_uBgo_user"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[0],
                                style:size14weight400.copyWith(color: colors(context).greyColor)
                            ),
                            TextSpan(
                                text: "\n${extractTextWithinTags(input: splitAndJoinAtBrTags(state.message ?? ""))[1]}",
                                style:size14weight400.copyWith(color: colors(context).greyColor)
                            ),
                            TextSpan(
                                text: "\n${
                                    extractTextWithinTags(
                                        input: splitAndJoinAtBrTags(
                                            state.message ?? ""))[2]
                                }",
                                style:size14weight400.copyWith(color: colors(context).greyColor)
                            ),
                            TextSpan(
                                text: "\n\n${
                                    extractTextWithinTags(
                                        input: splitAndJoinAtBrTags(
                                            state.message ?? ""))[3]
                                }",
                                style:size14weight400.copyWith(color: colors(context).greyColor)
                            ),
                            TextSpan(
                                text: "\n${
                                    extractTextWithinTags(
                                        input: splitAndJoinAtBrTags(
                                            state.message ?? ""))[4]
                                } ",
                                style:size14weight400.copyWith(color: colors(context).greyColor)
                            ),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launchCaller(extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[5]);
                                  },
                                text: extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[5],
                                style:size14weight700.copyWith(color: colors(context).primaryColor)
                            ),
                          ])

                      )
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("login"),
                );
              }
              else if (state.code == "706") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title:AppLocalizations.of(context).translate("inactive_account"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[0]),
                            style:size14weight400.copyWith(color: colors(context).greyColor) 
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchCaller(splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1]));
                              },
                            text:" ${splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1])}" ,
                            style:size14weight700.copyWith(color: colors(context).primaryColor) 
                          ),
                        ])

                       )
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("try_another_account"),
                  onPositiveCallback: (){

                  },
                  bottomButtonText: AppLocalizations.of(context).translate("close"),
                );
              }
              else if (state.code == "707") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("not_allowed_account"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("not_allowed_account_msg_1"),
                      ),
                      1.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("continue_using_other_bank"),
                      ),
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("try_different_acct"),
                  negativeButtonText: AppLocalizations.of(context).translate("cancel"),
                );
              }
              else if (state.code == "711") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("invalid_account_type"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("invalid_account_type_des"),
                      ),
                      1.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("continue_using_other_bank"),
                      ),
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("use_my_ub_account"),
                  negativeButtonText: AppLocalizations.of(context).translate("continue_with_other_bank_acc"),
                );
              }
              else if (state.code == "510") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("customer_details_not_exist"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("already_ub_customer_des"),
                      ),
                      1.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("continue_using_other_bank"),
                      ),
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("use_my_ub_account"),
                  negativeButtonText: AppLocalizations.of(context).translate("continue_with_other_bank_acc"),
                );
              }
              else if (state.code == "500") {
                showAppDialog(
                  alertType: AlertType.FAIL,
                  title: AppLocalizations.of(context).translate("incorrect_details"),
                  message: state.message,
                  // dialogContentWidget: Column(
                  //   children: [
                  //     Text(
                  //       state.message ?? "",
                  //     ),
                  //     1.verticalSpace,
                  //   ],
                  // ),
                  onPositiveCallback: () {
                    setState(() {
                      accountNu = null;
                      identificatioNum = null;
                      nickName = null;
                      nickNameController.clear();
                      accountNumberController.clear();
                      identificationNumController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: "Retry",
                  // negativeButtonText: "Continue with Other Bank Account",
                );
              }
              else if (state.code == "501") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("account_not_allowed"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  bottomButtonText: AppLocalizations.of(context).translate("close"),
                  onBottomButtonCallback: (){

                  },
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("try_with_different_account"),
                );
              }
              else if(state.code == "826"){
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("account_not_allowed"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  bottomButtonText: AppLocalizations.of(context).translate("close"),
                  onBottomButtonCallback: (){

                  },
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("try_with_different_account"),
                );
              }
              else if (state.code == "825") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context).translate("incorrect_details"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  onPositiveCallback: () {
                    setState(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                );
              }
              else if (state.code == "827") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("incorrect_details"),
                  message: splitAndJoinAtBrTags(state.message ?? ""),
                  onPositiveCallback: () {

                  },
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                );
              }
              else if (state.code == "511") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("already_uBgo_user"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[0],
                            style:size14weight400.copyWith(color: colors(context).greyColor) 
                          ),
                          TextSpan(
                            text: "\n${extractTextWithinTags(input: splitAndJoinAtBrTags(state.message ?? ""))[1]}",
                            style:size14weight400.copyWith(color: colors(context).greyColor)
                          ),
                          TextSpan(
                            text: "\n${
                                  extractTextWithinTags(
                                      input: splitAndJoinAtBrTags(
                                          state.message ?? ""))[2]
                                }",
                            style:size14weight400.copyWith(color: colors(context).greyColor)
                          ),
                          TextSpan(
                            text: "\n\n${
                                  extractTextWithinTags(
                                      input: splitAndJoinAtBrTags(
                                          state.message ?? ""))[3]
                                }",
                            style:size14weight400.copyWith(color: colors(context).greyColor)
                          ),
                          TextSpan(
                            text: "\n${
                                  extractTextWithinTags(
                                      input: splitAndJoinAtBrTags(
                                          state.message ?? ""))[4]
                                } ",
                            style:size14weight400.copyWith(color: colors(context).greyColor)
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchCaller(extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[5]);
                              },
                            text: extractTextWithinTags(input:  splitAndJoinAtBrTags(state.message ?? ""))[5],
                            style:size14weight700.copyWith(color: colors(context).primaryColor) 
                          ),
                        ])

                       )
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("login"),
                );
              }
              else {
                showAppDialog(
                  alertType: AlertType.FAIL,
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        state.message ?? "",
                      ),
                      1.verticalSpace,
                    ],
                  ),
                  onPositiveCallback: () {
                    setState(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                );
              }
            }
            if (state is CdbAccountVerificationFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h+ AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.ubOnboardingRegistration,
                                width: 200.w,
                              ),
                            ),
                            28.verticalSpace,
                            Text(
                              AppLocalizations.of(context)
                                  .translate("Please_below_details"),
                              style: size16weight400.copyWith(color: colors(context).greyColor) ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppLocalizations.of(context).translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              controller: accountNumberController,
                              isInfoIconVisible: false,
                              maxLength: 16,
                              inputType: TextInputType.number,
                              hint: AppLocalizations.of(context)
                                  .translate("enter_account_no"),
                              title: AppLocalizations.of(context)
                                  .translate("Account_Number"),
                              textCapitalization: TextCapitalization.none,
                              isLabel: false,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onTextChanged: (value) {
                                setState(() {
                                  accountNu = value;
                                });
                              },
                            ),
                            24.verticalSpace,
                            AppTextField(
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppLocalizations.of(context).translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              controller: nickNameController,
                              isInfoIconVisible: false,
                              inputType: TextInputType.text,
                              maxLength: 20,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z]")),
                              ],
                              hint: AppLocalizations.of(context)
                                  .translate("enter_nick_name"),
                              textCapitalization: TextCapitalization.none,
                              isLabel: false,
                              title: AppLocalizations.of(context)
                                  .translate("Nick_Name"),
                              onTextChanged: (value) {
                                setState(() {
                                  nickName = value;
                                });
                              },
                            ),
                            24.verticalSpace,
                            CustomRadioButtonGroup(
                              options: [
                                RadioButtonModel(
                                    label: AppLocalizations.of(context)
                                        .translate("NIC"),
                                    value: 'NIC'),
                                RadioButtonModel(
                                    label: AppLocalizations.of(context)
                                        .translate("Passport"),
                                    value: 'PP'),
                              ],
                              value: selectedIdType,
                              onChanged: (value) {
                                setState(() {
                                  selectedIdType = value!;
                                  identificationNumController.text = "";
                                  if (value == 'PP') {
                                    nicValidated = true;
                                  }
                                });
                                  idFocusNode.requestFocus();
                              },
                              title: AppLocalizations.of(context)
                                  .translate("identification_type"),
                            ),
                            selectedIdType == 'NIC'
                                ? Column(
                                    children: [
                                      24.verticalSpace,
                                      AppTextField(
                                        focusNode: idFocusNode,
                                        validator: (value) {
                                          if (identificationNumController.text == null || identificationNumController.text == "") {
                                            return AppLocalizations.of(context).translate("nic_required");
                                          } else {
                                            if (!appValidator
                                                .advancedNicValidation(identificationNumController.text)) {
                                              return AppLocalizations.of(context).translate("nic_required_des_1");
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        controller: identificationNumController,
                                        inputFormatter: [SriLankanNICFormatter()],
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_nic"),
                                        title: AppLocalizations.of(context)
                                            .translate("NIC_number"),
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        isLabel: false,
                                        onTextChanged: (value) {
                                          identificatioNum = value;
                                          if (appValidator
                                              .advancedNicValidation(value)) {
                                            nicValidated = true;
                                          } else {
                                            nicValidated = false;
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      24.verticalSpace,
                                      AppTextField(
                                        focusNode: idFocusNode,
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return AppLocalizations.of(context).translate("mandatory_field_msg");
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: identificationNumController,
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_passport_number"),
                                        title: AppLocalizations.of(context)
                                            .translate("passport_number"),
                                        textCapitalization:
                                            TextCapitalization.none,
                                        isLabel: false,
                                        onTextChanged: (value) {
                                          identificatioNum = value;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                          buttonType: ButtonType.PRIMARYENABLED,
                          buttonText: AppLocalizations.of(context)
                              .translate("continue"),
                          onTapButton: () {
                            if (_formkey.currentState?.validate() == false) {
                              return;
                            }
                            _bloc.add(
                              ValidateUBAccountEvent(
                                accountNumber: accountNu,
                                obType: ObType.CAO.name,
                                // referralCode: '',
                                nickName: nickName,
                                identificationType: selectedIdType,
                                identificationNo: identificatioNum,
                              ),
                              //ValidateAccountEvent(accountNumber: accNumber)
                            );
                          }),
                      // AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _launchCaller(String number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
