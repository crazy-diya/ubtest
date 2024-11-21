import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/otp/otp_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/utils/api_msg_types.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../base_view.dart';

class ResetPasswordTemporyView extends BaseView {
  final String username;
  ResetPasswordTemporyView( {super.key,required this.username,});

  @override
  _ResetPasswordTemporyViewState createState() =>
      _ResetPasswordTemporyViewState();
}

class _ResetPasswordTemporyViewState extends BaseViewState<ResetPasswordTemporyView> {
  var bloc = injection<ResetPasswordBloc>();
  var localDataSource = injection<LocalDataSource>();
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    
    super.initState();
  }
  Future<void> clearDeepLink() async {
     await localDataSource.clearEpicUserIdForDeepLink();
    Navigator.of(context).pop();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        await clearDeepLink();
        return false;
      },
      child: Scaffold(
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("reset_password"),
          goBackEnabled: true,
          onBackPressed: () async {
            await clearDeepLink();
          },
        ),
        body: BlocProvider<ResetPasswordBloc>(
          create: (context) => bloc,
          child: BlocListener<ResetPasswordBloc, BaseState<ResetPasswordState>>(
            listener: (context, state) async {
              if (state is TemporaryResetFailedState) {
                    showAppDialog(
                      alertType: AlertType.FAIL,
                      title: AppLocalizations.of(context)
                          .translate("invalid_credentials"),
                    );
              } else if (state is TemporaryResetAPIFailedState) {
                  showAppDialog(
                    alertType: AlertType.PASSWORD,
                    title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                    message: splitAndJoinAtBrTags(state.message ?? ''),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {},
                  );
              
              }
              if (state is TemporaryResetSuccessState) {
                      log("*********SMS OTP == ${state.temporaryLoginResponse!.otpResponseDto!.smsOtp}*****");
                      log("*********EMAIL OTP == ${state.temporaryLoginResponse!.otpResponseDto!.emailOtp}*****");
                      localDataSource.setEpicUserIdForDeepLink(state.temporaryLoginResponse!.epicUserId!);
                      final otpResult = await Navigator.pushNamed(context, Routes.kOtpView,
                              arguments: OTPViewArgs(
                                  appBarTitle: "otp_verification",
                                  isSingleOTP: false,
                                  otpType: kOtpMessageAdminPasswordReset,
                                  otpResponseArgs: OtpResponseArgs(
                                    isOtpSend: true,
                                    otpType: state.temporaryLoginResponse!
                                        .otpResponseDto!.otpType,
                                    otpTranId: state.temporaryLoginResponse!
                                        .otpResponseDto!.otpTranId,
                                    email: state
                                        .temporaryLoginResponse!.otpResponseDto!.email,
                                    mobile: state.temporaryLoginResponse!
                                        .otpResponseDto!.mobile,
                                    countdownTime: state.temporaryLoginResponse!
                                        .otpResponseDto!.countdownTime,
                                    otpLength: state.temporaryLoginResponse!
                                        .otpResponseDto!.otpLength,
                                    resendAttempt: state.temporaryLoginResponse!
                                        .otpResponseDto!.resendAttempt,
                                  ),
                                  requestOTP: false));
      
                      if (otpResult != null) {
                        if ((otpResult as bool)==true && mounted) {
                          await Navigator.pushNamed(context, Routes.kResetPasswordCreateNewPasswordView,arguments: controller.text.trim());
                        } 
                      }
                  
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            40.verticalSpace,
                            SvgPicture.asset(
                              AppAssets.newPassword,
                               width: 200.w,
                              height: 200.w,
                            ),
                            20.verticalSpace,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("temporary_password_des"),
                                style: size16weight400.copyWith(
                                    color: colors(context).greyColor),
                              ),
                            ),
                            20.verticalSpace,
                            AppTextField(
                              validator: (a) {
                                if (controller.text.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              focusNode: _focusNode,
                              controller: controller,
                              hint: AppLocalizations.of(context).translate("enter_temporary_password"),
                              title: AppLocalizations.of(context).translate("temporary_password"),
                              obscureText: true,
                              onTextChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    AppButton(
                      buttonText: AppLocalizations.of(context).translate("submit"),
                      onTapButton: () async{
                        if (_formKey.currentState?.validate() == false) {
                          return;
                        }
                        
                        localDataSource.setEpicUserIdForDeepLink('');
                        bloc.add(TemporaryResetEvent(
                            username: widget.username,
                            password: controller.text.trim(),));
                      },
                    ),
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
    return bloc;
  }
}
