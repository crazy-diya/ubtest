import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_state.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/data/forgot_password_security_questions_verify_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_validator.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../../data/models/responses/city_response.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class ForgotPasswordSecurityQuestionsView extends BaseView {
  final ForgotPasswordSecurityQuestionsVerifyData?
      forgotPasswordSecurityQuestionsVerifyData;

  const ForgotPasswordSecurityQuestionsView({
    super.key,
    this.forgotPasswordSecurityQuestionsVerifyData,
  });

  @override
  _ForgotPasswordSecurityQuestionsViewState createState() =>
      _ForgotPasswordSecurityQuestionsViewState();
}

class _ForgotPasswordSecurityQuestionsViewState
    extends BaseViewState<ForgotPasswordSecurityQuestionsView> {
  var bloc = injection<ForgetPasswordBloc>();
  var localDataSource = injection<LocalDataSource>();
  CommonDropDownResponse? selectedTitle1;
  CommonDropDownResponse? selectedTitle2;
  String? selectedIdType = 'NIC';
  String? identificatioNum, securityQuestion1Answer, securityQuestion2Answer;
  bool nicValidated = true;
  String? secQues1;
  String? secQues2;

  @override
  void initState() {
    super.initState();
    secQues1 = widget.forgotPasswordSecurityQuestionsVerifyData?.allDropDownData
        ?.first.description;
    secQues2 = widget.forgotPasswordSecurityQuestionsVerifyData?.allDropDownData
        ?.last.description;
    selectedTitle1 = widget
        .forgotPasswordSecurityQuestionsVerifyData?.allDropDownData?.first;
    selectedTitle2 =
        widget.forgotPasswordSecurityQuestionsVerifyData?.allDropDownData?.last;
    identificatioNum =
        widget.forgotPasswordSecurityQuestionsVerifyData?.identificatioNum;
    selectedIdType =
        widget.forgotPasswordSecurityQuestionsVerifyData?.selectedIdType;
  }

  final AppValidator appValidator = AppValidator();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context)
            .translate("recover_using_security_questions_title"),
      ),
      body: BlocProvider<ForgetPasswordBloc>(
        create: (context) => bloc,
        child: BlocListener<ForgetPasswordBloc, BaseState<ForgetPasswordState>>(
          listener: (context, state) async {
            if (state is CheckSQAnswerReqSuccessState) {
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
            if (state is CheckSQAnswerReqFailedState) {
               await localDataSource.clearEpicUserIdForDeepLink();
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
            }
          },
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
                            AppLocalizations.of(context).translate(
                                "recover_using_security_questions_desc"),
                            style: size16weight400.copyWith(
                                color: colors(context).greyColor),
                          ),
                          24.verticalSpace,
                          AppDropDown(
                            key: Key('${secQues1}_1'),
                            isDisable: true,
                            isFirstItem: true,
                            label: AppLocalizations.of(context)
                                .translate("Security_Question_1"),
                            initialValue: secQues1,
                          ),
                          20.verticalSpace,
                          AppTextField(
                            key: Key('${securityQuestion1Answer}_2'),
                            initialValue: securityQuestion1Answer,
                            isInfoIconVisible: false,
                            hint:
                                AppLocalizations.of(context).translate("Answer"),
                            isLabel: true,
                            textCapitalization: TextCapitalization.words,
                            onTextChanged: (value) {
                              securityQuestion1Answer = value;
                            },
                          ),
                          32.verticalSpace,
                          AppDropDown(
                            key: Key('${secQues2}_3'),
                            label: AppLocalizations.of(context)
                                .translate("Security_Question_2"),
                            initialValue: secQues2,
                            isDisable: true,
                          ),
                          20.verticalSpace,
                          AppTextField(
                            key: Key('${securityQuestion2Answer}_4'),
                            initialValue: securityQuestion2Answer,
                            isInfoIconVisible: false,
                            hint:
                                AppLocalizations.of(context).translate("Answer"),
                            isLabel: true,
                            textCapitalization: TextCapitalization.words,
                            onTextChanged: (value) {
                              securityQuestion2Answer = value;
                            },
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
                      buttonType: nicValidated == true &&
                              (identificatioNum != null &&
                                  identificatioNum != "")
                          ? ButtonType.PRIMARYENABLED
                          : ButtonType.PRIMARYDISABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("submit"),
                      onTapButton: () {
                        _validateQuestions();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateQuestions() async {
    if (secQues1 == "secQues1" || secQues2 == "secQues2") {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_choose_question"), ToastStatus.FAIL);
    } else if (securityQuestion1Answer == null ||
        securityQuestion1Answer == "" ||
        selectedTitle1 == null) {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_respond_first_question"), ToastStatus.FAIL);
    } else if (securityQuestion2Answer == null ||
        securityQuestion2Answer == "" ||
        selectedTitle2 == null) {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_respond_second_question"), ToastStatus.FAIL);
    } else {
      if (await localDataSource.hasUsername() == false) {
        await localDataSource.clearEpicUserId();
      }
      localDataSource.setEpicUserIdForDeepLink('');
      bloc.add(CheckSQAnswerReqEvent(
          identificationType: selectedIdType,
          identificationNo: identificatioNum,
          answers: [
            Answer(
                question: selectedTitle1?.id, answer: securityQuestion1Answer),
            Answer(
                question: selectedTitle2?.id, answer: securityQuestion2Answer)
          ]));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
