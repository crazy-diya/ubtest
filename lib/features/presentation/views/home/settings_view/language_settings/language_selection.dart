import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../../data/datasources/secure_storage.dart';
import '../../../../bloc/language/language_bloc.dart';
import '../../../../bloc/language/language_event.dart';
import '../../../../bloc/language/language_state.dart';
import '../../../../widgets/app_radio_button.dart';
import '../../../../widgets/toast_widget/toast_widget.dart';
import '../../../base_view.dart';

class LanguageSelectionView extends BaseView {
  final bool isInitialNavigate;

  LanguageSelectionView({super.key, required this.isInitialNavigate});

  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends BaseViewState<LanguageSelectionView> {
  final bloc = injection<LanguageBloc>();
  final _secureStorage = injection<SecureStorage>();
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getLang());
  }

  void getLang() async {
    selectedLanguage = await _secureStorage.getData(SELECTED_LANGUAGE);
    setState(() {});
  }

  List<RadioButtonModel> radioButtonModel = [
    RadioButtonModel(label: "English", value: 'en'),
    RadioButtonModel(label: 'සිංහල', value: 'si'),
    RadioButtonModel(label: 'தமிழ்', value: 'ta'),
  ];

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      extendBodyBehindAppBar: false,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("language"),
        goBackEnabled: true,
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
              Future.delayed(const Duration(milliseconds: 300), () {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("language_updated_successfully"),
                    ToastStatus.SUCCESS);
              });
            } else if (state is SetPreferredLanguageFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16,vertical: 16).w,
                            child: Column(
                              children: [
                                CustomRadioButtonGroup(
                                  haveMorePadding: true,
                                  isDivider: true,
                                  options: radioButtonModel,
                                  value: selectedLanguage,
                                  onChanged: (value) {
                                    if (value == 'en') {
                                      setState(() {
                                        selectedLanguage = value;
                                      });
                                      bloc.add(SetPreferredLanguageEvent(
                                        language: kLocaleEN,
                                        selectedDate:
                                            DateFormat("yyyy-mm-dd HH:mm:ss")
                                                .format(DateTime.now()),
                                      ));
                                      return;
                                    }
                                    if (value == 'si') {
                                      setState(() {
                                        selectedLanguage = value;
                                      });
                                      bloc.add(SetPreferredLanguageEvent(
                                        language: kLocaleSI,
                                        selectedDate:
                                            DateFormat("yyyy-mm-dd HH:mm:ss")
                                                .format(DateTime.now()),
                                      ));
                                      return;
                                    }
                                    if (value == 'ta') {
                                      setState(() {
                                        selectedLanguage = value;
                                      });
                                      bloc.add(SetPreferredLanguageEvent(
                                        language: kLocaleTA,
                                        selectedDate:
                                            DateFormat("yyyy-mm-dd HH:mm:ss")
                                                .format(DateTime.now()),
                                      ));
                                      return;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
