import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/widgets/settings_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

class PersonalizationSettingsView extends BaseView {
  PersonalizationSettingsView({super.key});

  @override
  _PersonalizationSettingsViewState createState() =>
      _PersonalizationSettingsViewState();
}

class _PersonalizationSettingsViewState
    extends BaseViewState<PersonalizationSettingsView> {
  var bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("personalization"),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: SettingsComponent(
                        title: AppLocalizations.of(context)
                            .translate("manage_quick_access_menu"),
                        icon: PhosphorIcon(
                          PhosphorIcons.circlesThreePlus(
                              PhosphorIconsStyle.bold),
                          color: colors(context).blackColor,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.kManageQuickAccessMenuView);
                        }),
                  ),
                ],
              ))),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
