
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../widgets/text_fields/app_login_text_field.dart';

class LoginCard extends StatefulWidget {
  final Function(String) onPasswordChange;
  final Function(String) onUserNameChange;
  final Function() onForgotPassword;
  final Function() onLoginButtonTap;
  final Function() onBiometricTap;
  // final Function() onFaceIDTap;
  final LoginMethods loginMethod;
  final bool firstTimeLogin;
  final String username;
  final  TextEditingController passwordTextEditingController;
  const LoginCard({super.key, 
    required this.onPasswordChange,
    required this.onUserNameChange,
    required this.loginMethod,
    required this.firstTimeLogin,
    required this.username,
    required this.onForgotPassword,
    required this.onLoginButtonTap,
    required this.onBiometricTap,
    required this.passwordTextEditingController
    // required this.onFaceIDTap,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB( 20.w,widget.firstTimeLogin? 303.h: (widget.loginMethod == LoginMethods.NONE &&
                !widget.firstTimeLogin) ? 323.h:297.h,20.w,
                widget.firstTimeLogin?22.h: 
                (widget.loginMethod == LoginMethods.NONE &&
                !widget.firstTimeLogin) ? 42.h:16.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors(context).whiteColor,
          borderRadius:  BorderRadius.circular(8).r,
        ),
        padding: EdgeInsets.fromLTRB(20.w,36.h,20.w,((widget.loginMethod == LoginMethods.FINGERPRINT)||(widget.loginMethod == LoginMethods.FACEID) &&
                !widget.firstTimeLogin) ? 28.h:36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
             Text(
              AppLocalizations.of(context).translate("welcome"),
              style: size24weight700WithoutHeight.copyWith(color: colors(context).primaryColor),
                         ),
            20.verticalSpace,
                AppLoginTextField(
                    title: AppLocalizations.of(context).translate("username"),
                    hint:
                        AppLocalizations.of(context).translate("enter_username"),
                    onTextChanged: widget.onUserNameChange,
                    isEnable:  widget.firstTimeLogin ? true : false,
                    controller:widget.firstTimeLogin ? null : TextEditingController(text:widget.username),
                  )
            ,
            24.verticalSpace,
            AppLoginTextField(
              title: AppLocalizations.of(context).translate("password"),
              hint: AppLocalizations.of(context).translate("enter_password"),
              obscureText: true,
              controller:widget.passwordTextEditingController,
              onTextChanged: widget.onPasswordChange,
            ),
            12.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onForgotPassword,
                child: Text(
                  AppLocalizations.of(context).translate("forgot_password"),
                  style: size14weight700.copyWith(color: colors(context).primaryColor),
                ),
              ),
            ),
            16.verticalSpace,
          AppButton(buttonText: AppLocalizations.of(context).translate("login"), onTapButton: widget.onLoginButtonTap,),
           widget.firstTimeLogin
              ? 
              Center(
                child: Column(
                    children: [
                       16.verticalSpace,
                       Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate(
                                    "dont_have_an_account"),
                            style:size16weight400.copyWith(color: colors(context)
                                    .greyColor) 
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await Navigator.pushNamed(
                                    context,
                                    Routes
                                        .kRegistrationMethodView);
                              },
                            text: AppLocalizations.of(context)
                                .translate("sign_up_now"),
                            style: size16weight700.copyWith(color: colors(context).primaryColor) 
                          ),
                        ])

                       ),
                    ],
                  ),
              )
              : const SizedBox.shrink(),
           if ((widget.loginMethod == LoginMethods.FINGERPRINT)||(widget.loginMethod == LoginMethods.FACEID) &&
                !widget.firstTimeLogin)
              Column(
                children: [
                   16.verticalSpace,
                  InkWell(
                    onTap: widget.onBiometricTap,
                    child: Center(
                      child: SvgPicture.asset(
                       widget.loginMethod == LoginMethods.FINGERPRINT? AppAssets.fingerprint: AppAssets.faceId,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
