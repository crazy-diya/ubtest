
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/service/analytics_service/analytics_services.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/secure_storage.dart';
import '../../bloc/language/language_bloc.dart';
import '../../bloc/language/language_event.dart';
import '../../bloc/language/language_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class LanguageView extends BaseView {
  final bool isInitialNavigate;
  LanguageView({super.key, required this.isInitialNavigate});

  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends BaseViewState<LanguageView> {
  final bloc = injection<LanguageBloc>();
  final appSharedData = injection<LocalDataSource>();
  String? selectedLanguage;
  bool isBannersAvailable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t)=>clearDeepLink());
    if (widget.isInitialNavigate)
    secureStorage.setData(INITIAL_LAUNCH_FLAG, INITIAL_LAUNCH_FLAG);
    isBannersAvailable =
        appSharedData.getMarketingBanners()?.isNotEmpty ?? false;
    
  }

  clearDeepLink() async {
    await appSharedData.clearEpicUserIdForDeepLink();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: UBAppBar(
        goBackEnabled: !widget.isInitialNavigate ? true : false,
        isTransparent: true,
      ),
      body: BlocProvider<LanguageBloc>(
        create: (_) => bloc,
        child: BlocListener<LanguageBloc, BaseState<LanguageState>>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is SetPreferredLanguageSuccessState) {
              secureStorage.setData(SELECTED_LANGUAGE, selectedLanguage!);
              
             if (selectedLanguage == "si") {
                LocaleNotifier.changeLocale(Locale(AppConstants.localeSI,"LK"));
              } else if (selectedLanguage == "ta") {
                LocaleNotifier.changeLocale(Locale(AppConstants.localeTA, "TA"));
              } else {
                LocaleNotifier.changeLocale(Locale(AppConstants.localeEN, "US"));
              }
              if (widget.isInitialNavigate) {
                if (isBannersAvailable) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.kIntroView,
                    (route) => false,
                  );
                } else {
                  appSharedData.setInitialLaunch();
                  Navigator.pushReplacementNamed(context, Routes.kLoginView);
                }
              } else {
                Future.delayed(const Duration(milliseconds: 300), () {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context).translate("language_updated_successfully"),
                    ToastStatus.SUCCESS);});
              }

               /* ------------------------------------ . ----------------------------------- */

                 await AnalyticsServices.instance?.analyticsUserLanguage(language: selectedLanguage ??"en"); 

              /* ------------------------------------ . ----------------------------------- */

            } else if (state is SetPreferredLanguageFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 227.h,
                  width: double.infinity,
                  color: colors(context).primaryColor,
                  child: Column(
                    children: [
                       105.verticalSpace,
                      SvgPicture.asset(
                        AppAssets.ubGoLogo,width: 142.35.w,
                      ),
                    ],
                  ),
                ),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: colors(context).secondaryColor,
                  ),
                63.verticalSpace,
                Center(
                    child: Text(
                  AppLocalizations.of(context).translate("language"),
                  style: size24weight700.copyWith(color: colors(context).primaryColor)
                )),
                8.verticalSpace,
                Center(
                  child: Text(
                    AppLocalizations.of(context).translate("select_language"),
                    textAlign: TextAlign.center,
                    style: size16weight400.copyWith(
                      color: colors(context).greyColor,
                    ),
                  ),
                ),
                28.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.5).w,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppButton(
                          buttonText: "English",
                          onTapButton: () {
                            bloc.add(SetPreferredLanguageEvent(
                              language: kLocaleEN,
                              selectedDate: DateFormat("yyyy-mm-dd HH:mm:ss")
                                  .format(DateTime.now()),
                            ));
                             setState(() {
                              selectedLanguage = AppConstants.localeEN;
                            });
                          },
                        ),
                         16.verticalSpace,
                         AppButton(
                          buttonText: "සිංහල",
                          onTapButton: () {
                            bloc.add(SetPreferredLanguageEvent(
                              language: kLocaleSI,
                              selectedDate: DateFormat("yyyy-mm-dd HH:mm:ss")
                                  .format(DateTime.now()),
                            ));
                            setState(() {
                              selectedLanguage = AppConstants.localeSI;
                            });
                          },
                        ),
                        16.verticalSpace,
                        AppButton(
                          buttonText:"தமிழ்",
                          onTapButton: () {
                            bloc.add(SetPreferredLanguageEvent(
                              language: kLocaleTA,
                              selectedDate: DateFormat("yyyy-mm-dd HH:mm:ss")
                                  .format(DateTime.now()),
                            ));
                             setState(() {
                              selectedLanguage = AppConstants.localeTA;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
