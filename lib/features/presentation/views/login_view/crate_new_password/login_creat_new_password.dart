import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';

import '../../../bloc/splash/splash_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_text_field.dart';

class CreateNewPasswordView extends BaseView {

  @override
  _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends BaseViewState<CreateNewPasswordView> {
  var bloc = injection<SplashBloc>();
  bool firstTimeLogin = true;
  String username = '';
  String newPW = '';
  String confirmPW = '';


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("login"),
        goBackEnabled: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        AppAssets.createNewPasswordView,
                        scale: 3,
                        width: 65.w,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate("create_new_password"),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: colors(context).blackColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate("create_new_pw_description"),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: colors(context).blackColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: AppLocalizations.of(context).translate("user_name"),
                      isLabel: true,
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: AppLocalizations.of(context)
                          .translate("new_password"),
                      isLabel: true,
                      obscureText: true,
                      letterSpacing: 10.0,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(
                            "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                      ],
                      textCapitalization: TextCapitalization.none,
                      onTextChanged: (value) {
                        setState(() {
                          newPW = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(isInfoIconVisible: false,
                      hint: AppLocalizations.of(context)
                          .translate("confirm_new_password"),
                      isLabel: true,
                      letterSpacing: 10.0,
                      obscureText: true,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(
                            "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                      ],
                      textCapitalization: TextCapitalization.none,
                      inputTextStyle:
                      (confirmPW.length >= 3 && newPW != confirmPW)
                          ? TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10.0,
                        color: colors(context).negativeColor,
                      )
                          : null,
                      onTextChanged: (value) {
                        setState(() {
                          confirmPW = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    if (confirmPW.length >= 3 && newPW != confirmPW)
                      Text(
                        AppLocalizations.of(context)
                            .translate("password_does_not_match"),
                        style: TextStyle(
                          color: colors(context).negativeColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AppButton(
              buttonText: AppLocalizations.of(context).translate("next"),
              onTapButton: () {
                _validatePasswords();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _validatePasswords() {
    if (newPW == confirmPW) {
      setState(() {
        //Navigator.pushNamed(context, Routes.kSecurityQuestionsView);
      });
    } else {}
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }

}
