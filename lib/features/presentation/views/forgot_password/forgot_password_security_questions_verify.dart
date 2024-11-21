import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/drop_down/drop_down_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/data/forgot_password_security_questions_verify_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_validator.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/input_formatters.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';

class ForgotPasswordSecurityQuestionsVerifyView extends BaseView {
  const ForgotPasswordSecurityQuestionsVerifyView({
    super.key,
  });

  @override
  _ForgotPasswordSecurityQuestionsVerifyViewState createState() =>
      _ForgotPasswordSecurityQuestionsVerifyViewState();
}

class _ForgotPasswordSecurityQuestionsVerifyViewState
    extends BaseViewState<ForgotPasswordSecurityQuestionsVerifyView> {
  var bloc = injection<DropDownBloc>();
  var localDataSource = injection<LocalDataSource>();
  String? selectedIdType = 'NIC';
  final _formKey = GlobalKey<FormState>();
  String? identificatioNum;
  bool nicValidated = false;
  final TextEditingController _controllerNIC = TextEditingController();
  final AppValidator appValidator = AppValidator();
  List<CommonDropDownResponse> allDropDownData = [];

  @override
  Widget buildView(BuildContext context) {
    return BlocProvider(
        create: (_) => bloc,
        child: BlocListener<DropDownBloc, BaseState<DropDownState>>(
          listener: (context, state) async {
            if (state is DropDownDataLoadedState) {
              Navigator.pushNamed(
                  context, Routes.kForgotPasswordSecurityQuestionsView,
                  arguments: ForgotPasswordSecurityQuestionsVerifyData(
                      allDropDownData: state.data,
                      identificatioNum: identificatioNum,
                      selectedIdType: selectedIdType));
            }
            if (state is DropDownFailedState) {
               await localDataSource.clearEpicUserIdForDeepLink();
               showAppDialog(
                 alertType: AlertType.WARNING,
                 title: AppLocalizations.of(context).translate("invalid_NIC_number"),
                 message: state.message ?? "",
                 positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                 onPositiveCallback: () {},
               );
            }
          },
          child: Scaffold(
            appBar: UBAppBar(
              title: AppLocalizations.of(context)
                  .translate("recover_using_security_questions_title"),
            ),
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w,0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  AppAssets.fogotPasswordRecovery,
                                ),
                              ),
                              28.verticalSpace,
                              Text(
                                AppLocalizations.of(context).translate(
                                    "identification_num_continue_reset_process"),
                                style: size16weight400.copyWith(
                                    color: colors(context).greyColor),
                              ),
                              24.verticalSpace,
                              AppTextField(
                                validator: (a){
                                 if (!nicValidate()){
                                    return AppLocalizations.of(context).translate("invalid_NIC_number");
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                inputFormatter: [SriLankanNICFormatter()],
                                isInfoIconVisible: false,
                                controller: _controllerNIC,
                                title: AppLocalizations.of(context)
                                    .translate("NIC_number"),
                                hint: AppLocalizations.of(context)
                                    .translate("enter_nic"),
                                textCapitalization: TextCapitalization.characters,
                                onTextChanged: (value) {
                                  identificatioNum = value;
                                  if (appValidator.advancedNicValidation(value)) {
                                    nicValidated = true;
                                  } else {
                                    nicValidated = false;
                                  }
                                  setState(() {});
                                },
                              ),
                              24.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    AppButton(
                      // buttonType: nicValidated == true &&
                      //         (identificatioNum != null && identificatioNum != "")
                      //     ? ButtonType.PRIMARYENABLED
                      //     : ButtonType.PRIMARYDISABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("submit"),
                      onTapButton: () {
                        if(_formKey.currentState?.validate() == false){
                          return;
                        }
                        localDataSource.setEpicUserIdForDeepLink('');
                        bloc.add(GetSecurityQuestionDropDownEvent(
                            nic: identificatioNum));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  bool nicValidate() {
    final validatePasswordState = appValidator.advancedNicValidation(_controllerNIC.text);
    if (validatePasswordState == true) {
      return true;
    } else {
      return false;
    }
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
