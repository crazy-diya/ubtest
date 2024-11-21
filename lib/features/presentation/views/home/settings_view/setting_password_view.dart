import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/biometric/biometric_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/settings_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../utils/app_sizer.dart';
import 'profile_settings/profile_details_view.dart';

class SettingPasswordView extends BaseView {
  final bool isFromHome;

  SettingPasswordView({
    super.key,
    required this.isFromHome,
  });

  @override
  _SettingPasswordViewState createState() => _SettingPasswordViewState();
}

class _SettingPasswordViewState extends BaseViewState<SettingPasswordView> {
  var bloc = injection<BiometricBloc>();
  bool _isInputValid = false;
  String? password;
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  final biometricHelper = injection<BiometricHelper>();
  final localDataSource = injection<LocalDataSource>();
  final TextEditingController _controller1 = TextEditingController();
  bool isAuth = false;
  LoginMethods _loginMethod = LoginMethods.NONE;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => initialBiometric());
    _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    super.initState();
  }

  bool validateFields() {
    if (password == null || password == "") {
      return false;
    } else {
      return true;
    }
  }

  void checkAttempts() {
    showAppDialog(
      alertType: _loginMethod == LoginMethods.FINGERPRINT
          ? AlertType.FINGERPRINT
          : AlertType.FACEID,
      title: _loginMethod == LoginMethods.FINGERPRINT
          ? AppLocalizations.of(context).translate("fingerprint_not_recognized")
          : AppLocalizations.of(context).translate("faceid_not_recognized"),
      message: AppLocalizations.of(context).translate("re_enable_biometric"),
      positiveButtonText: AppLocalizations.of(context).translate("close"),
      onPositiveCallback: () {
        biometricHelper.cancelAuthentication();
        localDataSource.clearBiometric();
        AppConstants.BIOMETRIC_CODE = null;
        setState(() {});
      },
    );
  }

  void initialBiometric() async {
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
    checkBiometric();
    setState(() {});
  }

  checkBiometric() {
    if (_isAppBiometricAvailable && _isBiometricAvailable) {
      biometricHelper.authenticateWithBiometrics(context).then((value) {
        if (value == true) {
          isAuth = true;
          setState(() {});
        } else if (value == null) {
          checkAttempts();
        }
      });
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Builder(builder: (context) {
      if (isAuth) {
        if (widget.isFromHome) {
          return const ProfileDetailsView();
        } else {
          return SettingsUbView();
        }
      } else {
        return Scaffold(
          appBar: UBAppBar(
            title: AppLocalizations.of(context).translate("settings"),
            goBackEnabled:widget.isFromHome,
          ),
          body: BlocProvider(
            create: (context) => bloc,
            child: BlocListener(
              bloc: bloc,
              listener: (_, state) {
                if (state is PasswordValidationSuccessState) {
                  isAuth = true;
                  setState(() {});
                } else if (state is PasswordValidationFailedState) {
                  ToastUtils.showCustomToast(
                      context, state.message ?? "", ToastStatus.FAIL);
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context),),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate("to_access_settings"),
                              style: size16weight400.copyWith(
                                  color: colors(context).greyColor),
                              textAlign: TextAlign.justify,
                            ),
                            20.verticalSpace,
                            AppTextField(
                              isInfoIconVisible: false,
                              controller: _controller1,
                              hint: AppLocalizations.of(context)
                                  .translate("enter_password"),
                              isLabel: false,
                              title: AppLocalizations.of(context)
                                  .translate("password"),
                              obscureText: true,
                              // inputFormatter: [
                              //   FilteringTextInputFormatter.allow(RegExp(
                              //       "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                              // ],
                              onTextChanged: (value) {
                                password = value.trim();
                                _isInputValid = validateFields();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    AppButton(
                      buttonType: _isInputValid
                          ? ButtonType.PRIMARYENABLED
                          : ButtonType.PRIMARYDISABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("continue"),
                      onTapButton: () {
                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        bloc.add(PasswordValidationEvent(password: password));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
