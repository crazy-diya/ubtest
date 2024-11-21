// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
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
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

class FTEnterPasswordView extends BaseView {
  final String title;
  FTEnterPasswordView({
    required this.title,
  });

  @override
  _FTEnterPasswordViewState createState() =>
      _FTEnterPasswordViewState();
}

class _FTEnterPasswordViewState
    extends BaseViewState<FTEnterPasswordView> {
  var bloc = injection<BiometricBloc>();
  bool _isInputValid = false;
  String? password;

  bool validateFields() {
    if(password == null|| password == ""){
      return false;
    }
    else{
      return true;
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar:  UBAppBar(
        title: widget.title,
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener(
          bloc: bloc,
          listener: (_, state) {
            if (state is PasswordValidationSuccessState) {
              Navigator.pop(context , true);
            } else if (state is PasswordValidationFailedState) {
              ToastUtils.showCustomToast(
                  context,
                  state.message??"",
                  ToastStatus.FAIL);
            }
          },
          child:  Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context).translate("please_enter_password_proceed")} ${widget.title.toLowerCase()}",
                           style:size16weight400.copyWith(color: colors(context).greyColor),
                              textAlign: TextAlign.justify,
                            ),
                            20.verticalSpace,
                        AppTextField(
                          isInfoIconVisible: false,
                          hint: AppLocalizations.of(context)
                              .translate("enter_password"),
                              title: AppLocalizations.of(context)
                                  .translate("password"),
                          obscureText: true,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(
                                "[A-Z a-z 0-9 ! @ % & # ^ * ( ) _ - + = < > ? / { } : ; . ,]")),
                          ],
                          onTextChanged: (value) {
                            password =value;
                            _isInputValid = validateFields();
                            setState(() { });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonType: _isInputValid
                          ? ButtonType.PRIMARYENABLED
                          : ButtonType.PRIMARYDISABLED,
                      buttonText:
                      AppLocalizations.of(context).translate("continue"),
                      onTapButton: () {
                        bloc.add(PasswordValidationEvent(password: password));
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonColor: Colors.transparent,
                      buttonType:ButtonType.OUTLINEENABLED,
                      buttonText:
                      AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                       Navigator.of(context).pop();
                      },
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
