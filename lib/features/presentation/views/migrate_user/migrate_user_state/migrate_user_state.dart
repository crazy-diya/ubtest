import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/migrate_user/terms_and_condition/migrate_user_terms_and_conditions_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';

class MigrateUserState extends BaseView {
  final MigrateUser migrateUser;

  const MigrateUserState( {
    required this.migrateUser,
    super.key,
  });

  @override
  _MigrateUserStateState createState() =>
      _MigrateUserStateState();
}

class _MigrateUserStateState
    extends BaseViewState<MigrateUserState> {
  final bloc = injection<SplashBloc>();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title:
            AppLocalizations.of(context).translate("setup_security_questions"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
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
                          AppAssets.fogotPasswordRecovery,
                          width: 200.w,
                        ),
                      ),
                      28.verticalSpace,
                      Text(
                          AppLocalizations.of(context).translate(
                              widget.migrateUser == MigrateUser.TNC
                                  ? "migrate_tandc_desc"
                                  : "migrate_sec_q_desc"),
                          style: size16weight400.copyWith(
                              color: colors(context).greyColor)),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                20.verticalSpace,
                AppButton(
                    buttonText: AppLocalizations.of(context).translate("continue"),
                    onTapButton: () {
                       WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      if(widget.migrateUser == MigrateUser.TNC){
                         Navigator.pushNamed(context, Routes.kMigrateUserTC,
                          arguments: MigrateUserTCTermsArgs(
                              termsType: kTermType,
                              appBarTitle: 'terms_and_conditions'));

                      }else if(widget.migrateUser == MigrateUser.SECQUE){
                         Navigator.pushNamed(context, Routes.kAddSecurityQuestionView);
                      }   
                     
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
