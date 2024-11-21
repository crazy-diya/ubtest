import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/widgets/settings_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../../core/theme/theme_data.dart';
import '../../../../../../utils/app_sizer.dart';

class SecuritySettingsView extends BaseView {
  SecuritySettingsView({super.key});

  @override
  _SecuritySettingsViewState createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends BaseViewState<SecuritySettingsView> {
  var bloc = injection<BiometricBloc>();
  final biometricHelper = injection<BiometricHelper>();
  bool _isBiometricAvailable = false;
  bool toggleValueBiometric = false;

  final localDataSource = injection<LocalDataSource>();
  bool _isAppBiometricAvailable = false;
  LoginMethods _loginMethod = LoginMethods.NONE;
  bool isDisable = false;

  @override
  void initState() {
    super.initState();

    toggleValueBiometric = AppConstants.BIOMETRIC_CODE != null ? true : false;
    _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => checkBiometric());
  }

  void checkBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      if (_isBiometricAvailable) {
        if (_isAppBiometricAvailable && _isBiometricAvailable) {
          _loginMethod = await biometricHelper.getBiometricType();
        } else {
          _loginMethod = LoginMethods.NONE;
        }
      }
    }
    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("security"),
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<BiometricBloc, BaseState<BiometricState>>(
            bloc: bloc,
            listener: (context, state) {
              if (state is BiometricPromptSuccessState) {
                if (toggleValueBiometric == true) {
                  bloc.add(EnableBiometricEvent(shouldEnableBiometric: true));
                } else {
                  bloc.add(EnableBiometricEvent(shouldEnableBiometric: false));
                }
              } else if (state is EnableBiometricSuccessState) {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("biometric_enable_success"),
                    ToastStatus.SUCCESS);
              } else if (state is EnableBiometricFailedState) {
                toggleValueBiometric = false;
                setState(() {});
                ToastUtils.showCustomToast(
                    context, state.error ?? "", ToastStatus.FAIL);
              } else if (state is DisableBiometricSuccessState) {
                ToastUtils.showCustomToast(
                    context,
                    AppLocalizations.of(context)
                        .translate("biometric_disable_success"),
                    ToastStatus.SUCCESS);
              }
            },
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context),),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsComponent(
                                title: AppLocalizations.of(context)
                                    .translate("change_password"),
                                icon: PhosphorIcon(
                                  PhosphorIcons.password(PhosphorIconsStyle.bold),
                                  // size: 24,
                                  color: colors(context).blackColor,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.kChangePasswordView);
                                },
                              ),
                              if (_isBiometricAvailable)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16).w,
                                  child: Divider(
                                    height: 0,
                                    thickness: 1,
                                    color: colors(context).greyColor100,
                                  ),
                                ),
                              if (_isBiometricAvailable)
                                Padding(
                                  padding: const EdgeInsets.all(
                                    16,
                                  ).w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIcons.userFocus(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).blackColor,
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("biometric_settings"),
                                        style: size16weight700.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                      Spacer(),
                                      CupertinoSwitch(
                                        value: toggleValueBiometric,
                                        trackColor: colors(context)
                                            .greyColor
                                            ?.withOpacity(.65),
                                        activeColor: colors(context).primaryColor,
                                        onChanged: (value) async {
                                          if (_isBiometricAvailable) {
                                            await biometricHelper
                                                .authenticateWithBiometrics(context)
                                                .then((success) {
                                              if (success == true) {
                                                bloc.add(
                                                    RequestBiometricPromptEvent());
                                                toggleValueBiometric = value;
                                                localDataSource
                                                    .clearBiometricAttemts();
                                                setState(() {});
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // 16.verticalSpace,
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8).r,
                        //     color: colors(context).whiteColor,
                        //   ),
                        //   child:SettingsComponent(
                        //     isDisable: isDisable,
                        //       title: AppLocalizations.of(context)
                        //           .translate("update_security_question"),
                        //       icon: PhosphorIcon(
                        //         PhosphorIcons.shieldCheckered(PhosphorIconsStyle.bold),
                        //         color:  isDisable?colors(context).blackColor?.withOpacity(.5): colors(context).blackColor,
                        //       ),
                        //       onTap: isDisable?(){}: () {
                        //         showAppDialog(
                        //           title: AppLocalizations.of(context).translate("update_security_question"),
                        //           alertType: AlertType.SECURITY,
                        //           message: AppLocalizations.of(context).translate("are_you_sure_security_questions"),
                        //           positiveButtonText: AppLocalizations.of(context).translate("yes_confirm"),
                        //           negativeButtonText: AppLocalizations.of(context).translate("cancel"),
                        //           onNegativeCallback: () {
                        //             showAppDialog(
                        //               title: AppLocalizations.of(context).translate("cancel_the_process"),
                        //               alertType: AlertType.INFO,
                        //               message: AppLocalizations.of(context).translate("exit_des"),
                        //               positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                        //               negativeButtonText: AppLocalizations.of(context).translate("no"),
                        //               onNegativeCallback: () {
                        //               },
                        //               onPositiveCallback: () {
                        //               });
                        //           },
                        //           onPositiveCallback: () {
                        //              Navigator.pushNamed(context, Routes.kOtpView,
                        //                 arguments: OTPViewArgs(
                        //                   appBarTitle: 'otp_verification',
                        //                   requestOTP: true,
                        //                 )).then((value) {
                        //               final result = value as bool;
                        //               if (result == true) {
                                       
                        //               }
                        //             });
                        //           });
                               
                        //       },
                        //     ),
                        // ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
