import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';

import '../../../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_assets.dart';
import '../../../../../../../utils/navigation_routes.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../utils/app_sizer.dart';

class BiometricsViewArgs {
  final String appBarTitle;
  final String fromRoutesName;

  BiometricsViewArgs({
    required this.appBarTitle,
    required this.fromRoutesName,
  });
}

class AddBiometricsView extends BaseView {
  final BiometricsViewArgs biometricsFaceIdViewArgs;

  AddBiometricsView({super.key, required this.biometricsFaceIdViewArgs});

  @override
  BiometricsFaceIdViewState createState() => BiometricsFaceIdViewState();
}

class BiometricsFaceIdViewState extends BaseViewState<AddBiometricsView> {
  var bloc = injection<BiometricBloc>();
  final biometricHelper = injection<BiometricHelper>();
  bool _isBiometricAvailable = false;
  int tapCount = 0;
  LoginMethods _loginMethod = LoginMethods.NONE;

  void initialBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      if (_isBiometricAvailable) {
        _loginMethod = await biometricHelper.getBiometricType();
      } else {
        _loginMethod = LoginMethods.NONE;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => initialBiometric());
  }

  void checkAttempts() {
    showAppDialog(
      alertType:_loginMethod == LoginMethods.FINGERPRINT? AlertType.FINGERPRINT:AlertType.FACEID,
      title: _loginMethod == LoginMethods.FINGERPRINT
          ? AppLocalizations.of(context).translate("fingerprint_not_recognized")
          : AppLocalizations.of(context).translate("faceid_not_recognized"),
      message: AppLocalizations.of(context).translate("enable_biometric_after_login"),
      positiveButtonText: AppLocalizations.of(context).translate("close"),
      onPositiveCallback: () {
        biometricHelper.cancelAuthentication();
        showAppDialog(
          title: AppLocalizations.of(context).translate("you_are_all_set"),
          message: AppLocalizations.of(context).translate("you_are_all_set_des"),
          positiveButtonText: AppLocalizations.of(context).translate("login"),
          onPositiveCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.kLoginView, (route) => false);
          },
        );
      },
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (tapCount == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(AppLocalizations.of(context).translate("tap_back_to_leave")),
            ),
          );
          tapCount++;
        } else {
          showAppDialog(
            title: AppLocalizations.of(context).translate("Exit"),
            alertType: AlertType.WARNING,
            message: AppLocalizations.of(context).translate("exit_app_message"),
            positiveButtonText:
                AppLocalizations.of(context).translate("Yes_Leave"),
            negativeButtonText: AppLocalizations.of(context).translate("no"),
            onPositiveCallback: () {
              exit(0);
            },
          );
        }
      },
      child: Scaffold(
        appBar: UBAppBar(
          title: AppLocalizations.of(context)
              .translate(widget.biometricsFaceIdViewArgs.appBarTitle),
          goBackEnabled: false,
        ),
        body: DoubleBackToCloseApp(
          snackBar:  SnackBar(
            content: Text(AppLocalizations.of(context).translate("tap_back_to_leave")),
          ),
          child: BlocProvider(
            create: (context) => bloc,
            child: BlocListener(
              bloc: bloc,
              listener: (_, state) async {
                if (state is BiometricPromptSuccessState) {
                  bloc.add(EnableBiometricEvent(shouldEnableBiometric: true));
                }
                else if (state is EnableBiometricSuccessState) {
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("you_are_all_set"),
                    message: AppLocalizations.of(context).translate("you_are_all_set_des"),
                    positiveButtonText: AppLocalizations.of(context).translate("login"),
                    onPositiveCallback: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.kLoginView, (route) => false);
                    },
                  );
                }
              },
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20.w, 40.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
                child: Column(
                  children: [
                    // 2.verticalSpace,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.addBiometrics,
                                width: 200.w,
                              ),
                            ),
                           58.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50).w,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(context)
                                      .translate('biometrics_text'),
                                  style: size16weight400.copyWith(
                                      color: colors(context).greyColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        AppButton(
                            buttonText: AppLocalizations.of(context)
                                .translate('turn_on_biometrics'),
                            onTapButton: () async {
                              if (_isBiometricAvailable) {
                                await biometricHelper
                                    .authenticateWithBiometrics(context)
                                    .then((success) {
                                  if (success == true) {
                                    bloc.add(RequestBiometricPromptEvent());
                                  } else if (success == null) {
                                    checkAttempts();
                                  }
                                });
                              }
                            }),
                        16.verticalSpace,
                        AppButton(
                            buttonType: ButtonType.OUTLINEENABLED,
                            buttonText:
                                AppLocalizations.of(context).translate("Skip"),
                            onTapButton: () {
                              showAppDialog(
                                title: AppLocalizations.of(context).translate("you_are_all_set"),
                                message: AppLocalizations.of(context).translate("you_are_all_set_des"),
                                positiveButtonText: AppLocalizations.of(context).translate("login"),
                                onPositiveCallback: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.kLoginView, (route) => false);
                                },
                              );
                            }),
                      ],
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
