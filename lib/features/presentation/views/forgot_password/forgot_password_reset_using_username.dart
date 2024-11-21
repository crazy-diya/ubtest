import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_validator.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/input_formatters.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../widgets/app_radio_button.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class ForgotPasswordResetUsingUserNameView extends BaseView {
  ForgotPasswordResetUsingUserNameView({super.key});

  @override
  _ForgotPasswordResetUsingUserNameViewState createState() =>
      _ForgotPasswordResetUsingUserNameViewState();
}

class _ForgotPasswordResetUsingUserNameViewState
    extends BaseViewState<ForgotPasswordResetUsingUserNameView> {
  var bloc = injection<ForgetPasswordBloc>();
  var localDataSource = injection<LocalDataSource>();

  final TextEditingController _controllerNIC = TextEditingController();
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPsport = TextEditingController();
  String? selectedIdType = 'NIC';
  final _formKey = GlobalKey<FormState>();
  String? identificatioNum, userName;
  bool nicValidated = true;
  bool _isInputValid = false;
  final idFocusNode = FocusNode();
  

  final AppValidator appValidator = AppValidator();

  bool validateFields() {
    if (userName == null || userName == "") {
      return false;
    } else if (nicValidated == false ||
        identificatioNum == null ||
        identificatioNum == "") {
      return false;
    } else {
      return true;
    }
  }

  bool validateNIC() {
    if (nicValidated == false ||
        identificatioNum == null ||
        identificatioNum == "") {
      return false;
    } else {
      return true;
    }
  }
  bool validateUserName() {
    if (userName == null || userName == '') {
      return false;
    }  else {
      return true;
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context)
            .translate("recover_using_username_title"),
      ),
      body: BlocProvider<ForgetPasswordBloc>(
        create: (context) => bloc,
        child: BlocListener<ForgetPasswordBloc, BaseState<ForgetPasswordState>>(
          listener: (context, state) async {
            if (state is CheckUsernameIdentityReqSuccessState) {
              if(state.code == "847"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context).translate("invalid_NIC_number"),
                  message: state.message ?? "",
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {},
                );
              }
              else if(state.code == "846"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context).translate("invalid_username"),
                  message: state.message ?? "",
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {},
                );
              } else {
                localDataSource.setEpicUserIdForDeepLink(state.forgetPasswordResponse!.epicUserId!);
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      isSingleOTP: false,
                      otpType: kforgotPasswordOtp,
                      routeName: Routes.kForgotPasswordCreateNewPasswordView,
                      appBarTitle: "otp_verification",
                      title: AppLocalizations.of(context)
                          .translate("mobile_number_and_email_verification"),
                      otpResponseArgs: OtpResponseArgs(
                        isOtpSend: true,
                        otpType: kforgotPasswordOtp,
                        otpTranId: state.forgetPasswordResponse?.otpTranId,
                        email: state.forgetPasswordResponse?.email,
                        mobile: state.forgetPasswordResponse?.mobile,
                        countdownTime:
                        state.forgetPasswordResponse?.countdownTime,
                        otpLength: state.forgetPasswordResponse?.otpLength,
                        resendAttempt:
                        state.forgetPasswordResponse?.resendAttempt,
                      ),
                      requestOTP: false,
                    ));
              }
            }
            if (state is CheckUsernameIdentityReqFailedState) {
               await localDataSource.clearEpicUserIdForDeepLink();
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);

                  // showAppDialog(
                  //     title: AppLocalizations.of(context).translate("invalid_NIC_number"),
                  //     alertType: AlertType.WARNING,
                  //     message: state.message,
                  //     positiveButtonText:
                  //         AppLocalizations.of(context).translate("try_Again"),
                  //     onPositiveCallback: () {
                  //     });

                  //     showAppDialog(
                  //     title: AppLocalizations.of(context).translate("invalid_account_number"),
                  //     alertType: AlertType.WARNING,
                  //     message: state.message,
                  //     positiveButtonText:
                  //         AppLocalizations.of(context).translate("try_Again"),
                  //     onPositiveCallback: () {
                  //     });
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
                                AppAssets.fogotPasswordRecovery,
                              ),
                            ),
                            28.verticalSpace,
                            Text(
                              AppLocalizations.of(context)
                                  .translate("Please_enter_the_below"),
                              style: size16weight400.copyWith(
                                  color: colors(context).greyColor),
                            ),
                            2.9.verticalSpace,
                            AppTextField(
                              validator: (a){
                                if(_controllerUserName.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              controller: _controllerUserName,
                              isInfoIconVisible: false,
                              title: AppLocalizations.of(context)
                                  .translate("username"),
                              hint: AppLocalizations.of(context)
                                  .translate("enter_username"),
                              textCapitalization: TextCapitalization.words,
                              onTextChanged: (value) {
                                userName = value.trim();
                                _isInputValid = validateFields();
                                setState(() {});
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
                                  identificatioNum = null;
                                  _controllerNIC.clear();
                                  _controllerPsport.clear();
                                  nicValidated = true;
                                  selectedIdType = value!;
                                });
                                idFocusNode.requestFocus();
                              },
                              title: AppLocalizations.of(context)
                                  .translate("identification_type"),
                            ),
                            24.verticalSpace,
                            selectedIdType == 'NIC'
                                ? Column(
                                    children: [
                                      AppTextField(
                                        focusNode: idFocusNode,
                                        validator: (a){
                                          if(!validateNIC()){
                                            return AppLocalizations.of(context).translate("invalid_NIC_number");
                                          }else{
                                            return null;
                                          }
                                        },
                                        inputFormatter: [SriLankanNICFormatter()],
                                        isInfoIconVisible: false,
                                        title: AppLocalizations.of(context)
                                            .translate("NIC_number"),
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_nic"),
                                        controller: _controllerNIC,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        onTextChanged: (value) {
                                          identificatioNum = value;
                                          if (appValidator
                                              .advancedNicValidation(value)) {
                                            nicValidated = true;
                                          } else {
                                            nicValidated = false;
                                          }

                                          _isInputValid = validateFields();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      AppTextField(
                                        focusNode: idFocusNode,
                                        validator: (a){
                                          if(!validateUserName()){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        isInfoIconVisible: false,
                                        title: AppLocalizations.of(context)
                                            .translate("passport_number"),
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_passport_number"),
                                        controller: _controllerPsport,
                                        textCapitalization: TextCapitalization.none,
                                        onTextChanged: (value) {
                                          identificatioNum = value;
                                          _isInputValid = validateFields();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                            // 0.9.verticalSpace,
                            // Text(AppLocalizations.of(context).translate("nic_validation_des"),
                            //   style: size12weight400.copyWith(color: colors(context).greyColor),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      24.verticalSpace,
                      AppButton(
                        // buttonType: _isInputValid
                        //     ? ButtonType.PRIMARYENABLED
                        //     : ButtonType.PRIMARYDISABLED,
                        buttonText:
                            AppLocalizations.of(context).translate("submit"),
                        onTapButton: () async {
                          if(_formKey.currentState?.validate() == false){
                            return;
                          }
                          if (await localDataSource.hasUsername() == false) {
                            await localDataSource.clearEpicUserId();
                          }
                          localDataSource.setEpicUserIdForDeepLink('');
                          bloc.add(CheckUsernameIdentityReqEvent(
                              username: userName,
                              identificationType: selectedIdType,
                              identificationNo: identificatioNum));
                        },
                      ),
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
