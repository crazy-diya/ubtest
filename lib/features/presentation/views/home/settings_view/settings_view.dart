import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/widgets/language_component.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/widgets/settings_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/rounded_avatar.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../data/datasources/local_data_source.dart';

class SettingsUbView extends BaseView {
  SettingsUbView({super.key});

  @override
  _SettingsUbViewState createState() => _SettingsUbViewState();
}

class _SettingsUbViewState extends BaseViewState<SettingsUbView> {
  final _bloc = injection<SettingsBloc>();
  String? userName;
  String? imageKey;
  final localDataSource = injection<LocalDataSource>();

  //String? imageKey;

  @override
  void initState() {
    // _bloc.add(GetHomeDetailsEvent(timeStamp: DateTime.now().millisecond));
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("settings"),
          goBackEnabled: false,
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 24.0.h, bottom: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kProfileDetailsView)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16).w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RoundedAvatarView(
                                backgroundColor:
                                    colors(context).primaryColor50!,
                                forgroundColor: colors(context).primaryColor50!,
                                isOnline: false,
                                image: AppConstants.profileData.profileImage,
                                name: AppConstants.profileData.cName??AppConstants.profileData.fName,
                                size: 28.w,
                                onPressed: () {
                                  Navigator.pushNamed(
                                          context, Routes.kProfileDetailsView)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                              8.horizontalSpace,
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      //AppConstants.imageData.callingName ?? "",
                                      AppConstants.profileData.name ??"" ,
                                      style: size16weight700.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate("last_login"),
                                      style: size12weight400.copyWith(
                                          color: colors(context).blackColor),
                                    ),
                                    Text(
                                      AppConstants.lastLoggingTime ?? "",
                                      style: size12weight400.copyWith(
                                        color: colors(context).greyColor,
                                      ),
                                    ),
                                  ])),
                              PhosphorIcon(
                                PhosphorIcons.caretRight(
                                    PhosphorIconsStyle.bold),
                                color: colors(context).greyColor300,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16).w,
                            child: Text(
                              AppLocalizations.of(context).translate("account"),
                              style: size18weight700.copyWith(
                                color: colors(context).primaryColor,
                              ),
                            ),
                          ),
                          SettingsComponent(
                            title: AppLocalizations.of(context)
                                .translate("notifications"),
                            icon: PhosphorIcon(
                              PhosphorIcons.bell(PhosphorIconsStyle.bold),
                              color: colors(context).blackColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kNotificationSettingsView);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16).w,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: colors(context).greyColor100,
                            ),
                          ),
                          SettingsComponent(
                            title: AppLocalizations.of(context)
                                .translate("security"),
                            icon: PhosphorIcon(
                              PhosphorIcons.shieldCheckered(
                                  PhosphorIconsStyle.bold),
                              color: colors(context).blackColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kSecuritySettingsView);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16).w,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: colors(context).greyColor100,
                            ),
                          ),
                          SettingsComponent(
                              title: AppLocalizations.of(context)
                                  .translate("transaction_limits"),
                              icon: PhosphorIcon(
                                PhosphorIcons.coins(PhosphorIconsStyle.bold),
                                color: colors(context).blackColor,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.kTransactionListView);
                              }),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: SettingsLanguageComponent(
                          title: AppLocalizations.of(context)
                              .translate("language"),
                          icon: PhosphorIcon(
                            PhosphorIcons.globe(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,
                          )),
                    ),
                    16.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: SettingsComponent(
                          title: AppLocalizations.of(context)
                              .translate("personalization"),
                          icon: PhosphorIcon(
                            PhosphorIcons.palette(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.kPersonalizationSettingsView);
                          }),
                    ),
                    16.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: SettingsComponent(
                          title:
                              AppLocalizations.of(context).translate("log_out"),
                          icon: PhosphorIcon(
                            PhosphorIcons.signIn(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,
                          ),
                          onTap: () {
                            showAppDialog(
                              alertType: AlertType.WARNING,
                              title: AppLocalizations.of(context)
                                  .translate("log_out"),
                              message: AppLocalizations.of(context)
                                  .translate("are_you_want_leave"),
                              positiveButtonText: AppLocalizations.of(context)
                                  .translate("log_out"),
                              negativeButtonText: AppLocalizations.of(context)
                                  .translate("cancel"),
                              onPositiveCallback: () {
                                logout();
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
