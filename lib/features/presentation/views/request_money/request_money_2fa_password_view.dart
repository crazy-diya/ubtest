import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../utils/enums.dart';

import '../../widgets/app_button.dart';

import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';

class RequestMoney2faPasswordView extends BaseView {
  RequestMoney2faPasswordView({super.key});

  @override
  _RequestMoney2faPasswordViewState createState() =>
      _RequestMoney2faPasswordViewState();
}

class _RequestMoney2faPasswordViewState
    extends BaseViewState<RequestMoney2faPasswordView> {
  var bloc = injection<SplashBloc>();
  bool toggleValue = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("2FA_limit"),
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
                    Text(AppLocalizations.of(context).translate("2FA_des"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colors(context).greyColor200,
                        )),
                    AppTextField(isInfoIconVisible: false,
                      hint: AppLocalizations.of(context)
                          .translate("password"),
                      isLabel: true,
                      obscureText: true,
                      letterSpacing: 10.0,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(
                            "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                      ],
                      textCapitalization: TextCapitalization.characters,
                      onTextChanged: (value) {
                        setState(() {;
                        });
                      },
                    ),
                  ],
                ),
              )),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("proceed"),
                      onTapButton: () {
                        // Navigator.pushNamed(context, Routes.kOtpView,
                        //     arguments: RequestMoneyOTPArgs(
                        //       phoneNumber: '773874652',
                        //       appBarTitle: 'fund_transfer',
                        //     )).then((value) {
                        //   if (value is bool && value) {
                        //     Navigator.pushNamed(context, Routes.kRequestMoneyStatusView);
                        //   }
                        // });
                      }),
                  AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                    buttonText:
                        AppLocalizations.of(context).translate("cancel"),
                   
                    onTapButton: () {
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
