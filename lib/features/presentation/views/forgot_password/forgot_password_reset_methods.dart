import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../base_view.dart';

class ForgotPasswordResetMethodView extends BaseView {
  ForgotPasswordResetMethodView({super.key});

  @override
  _ForgotPasswordResetMethodViewState createState() => _ForgotPasswordResetMethodViewState();
}

class _ForgotPasswordResetMethodViewState
    extends BaseViewState<ForgotPasswordResetMethodView> {
  var bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        goBackEnabled: true,
        title: AppLocalizations.of(context)
            .translate("Forgot_Password"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w,31.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
          child: Column(
            children: [
              Center(
                child: SvgPicture.asset(
                  AppAssets.passwordResetMethods,
                ),
              ),
              28.verticalSpace,
              Center(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("Please_select"),
                      textAlign: TextAlign.center,
                  style: size16weight400.copyWith(color: colors(context).greyColor),
                ),
              ),
              28.verticalSpace,
              AppButton(
                onTapButton: () {
                  Navigator.pushNamed(
                      context, Routes.kForgotPasswordResetUsingAccountView);
                },
                buttonText: AppLocalizations.of(context)
                    .translate("recover_using_accounts"),
              ),
              16.verticalSpace,
              AppButton(
                onTapButton: () {
                  Navigator.pushNamed(
                      context, Routes.kForgotPasswordSecurityQuestionsViewVerify
                  );
                },
                buttonText: AppLocalizations.of(context)
                    .translate("recover_using_security_questions"),
              ),
              16.verticalSpace,
              AppButton(
                onTapButton: () {
                  Navigator.pushNamed(
                      context, Routes.kForgotPasswordResetUsingUserNameView);
                },
                buttonText:  AppLocalizations.of(context)
                    .translate("recover_using_username"),
              )
            ],
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
