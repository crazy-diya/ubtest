import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/requests/set_security_questions_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/drop_down/drop_down_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../utils/enums.dart';

class AddSecurityQuestionView extends BaseView {

  const AddSecurityQuestionView({
    super.key,
  });

  @override
  _AddSecurityQuestionViewState createState() =>
      _AddSecurityQuestionViewState();
}

class _AddSecurityQuestionViewState
    extends BaseViewState<AddSecurityQuestionView> {
  final _secBloc = injection<SecurityQuestionsBloc>();
  final localDataSource = injection<LocalDataSource>();
  String? selectedTitle1;
  String? selectedTitle2;

  String? secQues1Answer;
  String? secQuestion2Answer;

  String? secQues1;
  String? secQues1Temp;
  String? secQues2;
  String? secQues2Temp;
  final _formkey = GlobalKey<FormState>();
  CommonDropDownResponse? firstSelectedQuestion;
  CommonDropDownResponse? firstSelectedQuestionTemp;
  CommonDropDownResponse? secondSelectedQuestion;
  CommonDropDownResponse? secondSelectedQuestionTemp;
  List<CommonDropDownResponse> allDropDownData = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    _secBloc.add(GetSecurityQuestionSECDropDownEvent());
    super.initState();
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title:
            AppLocalizations.of(context).translate("setup_security_questions"),
      ),
      body: BlocProvider<SecurityQuestionsBloc>(
        create: (_) => _secBloc,
        child: BlocListener<SecurityQuestionsBloc,
            BaseState<SecurityQuestionsState>>(
          listener: (_, state) {
            if (state is SetSecurityQuestionsSuccessState) {
                showAppDialog(
                   title: AppLocalizations.of(context).translate("you_are_all_set"),
                   message: AppLocalizations.of(context).translate("migarate_sec_q_success"),
                   positiveButtonText: AppLocalizations.of(context).translate("login"),
                  onPositiveCallback: () {
                    localDataSource.clearAccessToken();
                      localDataSource.clearEpicUserId();
                      localDataSource.clearRefreshToken();
                      localDataSource.clearMigratedFlag();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                );
            }
            if (state is SetSecurityQuestionsFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }

            if(state is SecurityQuestionsDropDownDataLoadedState){
              allDropDownData = state.data;
                  setState(() { });

            }

            if(state is SecurityQuestionsDropDownDataFailedState){
               Navigator.of(context).pop();
                  ToastUtils.showCustomToast(
                      context, state.message ?? "", ToastStatus.FAIL);

            }
          },
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                AppAssets.fogotPasswordRecovery,
                                width: 200.w,
                              ),
                            ),
                            28.verticalSpace,
                            Text(
                                AppLocalizations.of(context).translate("In_an_event"),
                                style: size16weight400.copyWith(color: colors(context).greyColor)),
                            24.verticalSpace,
                            AppDropDown(
                              key: Key( "secQues1"),
                              onTap: () async {
                                final result = await showModalBottomSheet<
                                        bool>(
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    useSafeArea: true,
                                    context: context,
                                    barrierColor: colors(context).blackColor?.withOpacity(.85),
                                    backgroundColor: Colors.transparent,
                                    builder: (
                                      context,
                                    ) =>
                                        StatefulBuilder(builder:
                                            (context, changeState) {
                                          return BottomSheetBuilder(
                                            title: AppLocalizations.of(
                                                    context)
                                                .translate(
                                                    'select_security_question'),
                                            buttons: [
                                              Expanded(
                                                child: AppButton(
                                                    buttonType: ButtonType
                                                        .PRIMARYENABLED,
                                                    buttonText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "continue"),
                                                    onTapButton: () {
                                                      secQues1 = secQues1Temp;
                                                      firstSelectedQuestion =  firstSelectedQuestionTemp;
                                                      if (secQues1 ==
                                                          secQues2) {
                                                        ToastUtils.showCustomToast(
                                                            context,
                                                            AppLocalizations.of(context).translate("please_select_different_question"),
                                                            ToastStatus
                                                                .FAIL);
                                                        setState(() {
                                                          firstSelectedQuestion =
                                                              null;
                                                          secQues1Answer =
                                                              "";
                                                          secQues1 = "";
                                                        });
                                                      }
                                                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                      Navigator.of(
                                                              context)
                                                          .pop(true);
                                                      changeState(() {});
                                                      setState(() {});
                                                    }),
                                              ),
                                            ],
                                            children: [
                                              ListView.builder(
                                                itemCount:
                                                    allDropDownData
                                                        .length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      secQues1Temp =  allDropDownData[index].description;
                                                      firstSelectedQuestionTemp = allDropDownData[index];
                                                      changeState(
                                                          () {});
                                                          setState(() {});
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                           padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24.h,0,24.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Text(
                                                                  allDropDownData[index].description ??
                                                                      "",
                                                                  style:
                                                                      size16weight700.copyWith(
                                                                    color:
                                                                        colors(context).blackColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 8).w,
                                                                child: UBRadio<
                                                                    dynamic>(
                                                                  value: allDropDownData[index].description,
                                                                  groupValue:
                                                                      secQues1Temp,
                                                                  onChanged:
                                                                      (dynamic
                                                                          value) {
                                                                    secQues1Temp =value;
                                                                    firstSelectedQuestionTemp =  allDropDownData[index];
                                                                    changeState(
                                                                    () {});
                                                                    setState(() {});
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                       if(allDropDownData.length-1 != index)  Divider(
                                                        thickness: 1,height: 0,color: colors(context).greyColor100,
                                                      )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        }));
                                // if (result == null) {
                                  setState(() {});
                                // }
                              },
                              labelText: AppLocalizations.of(context)
                                  .translate(
                                      "Select_Security_Question_1"),
                              label: AppLocalizations.of(context)
                                  .translate("Security_Question_1"),
                              initialValue: secQues1,
                            ),
                            20.verticalSpace,
                            AppTextField(
                              validator: (value) {
                                if (secQues1Answer == null || secQues1Answer == '') {
                                  return AppLocalizations.of(context).translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              isInfoIconVisible: false,
                              onTextChanged: (value) {
                                log(value);
                                secQues1Answer = value;
                                // setState(() {});
                              },
                              hint: AppLocalizations.of(context)
                                  .translate("Answer"),
                              textCapitalization:
                                  TextCapitalization.words,
                                  initialValue: secQues1Answer,
                            ),
                            20.verticalSpace,
                            AppDropDown(
                              
                              onTap: () async {
                                final result = await showModalBottomSheet<
                                        bool>(
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    useSafeArea: true,
                                    context: context,
                                    barrierColor: colors(context).blackColor?.withOpacity(.85),
                                    backgroundColor: Colors.transparent,
                                    builder: (
                                      context,
                                    ) =>
                                        StatefulBuilder(builder:
                                            (context, changeState) {
                                          return BottomSheetBuilder(
                                            title: AppLocalizations.of(
                                                    context)
                                                .translate(
                                                    'select_security_question'),
                                            buttons: [
                                              Expanded(
                                                child: AppButton(
                                                    buttonType: ButtonType
                                                        .PRIMARYENABLED,
                                                    buttonText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "continue"),
                                                    onTapButton: () {
                                                      secQues2 = secQues2Temp;
                                                      secondSelectedQuestion = secondSelectedQuestionTemp;
                                                      if (secQues1 == secQues2) {
                                                        ToastUtils.showCustomToast(
                                                            context,
                                                            AppLocalizations.of(context).translate("please_select_different_question"),
                                                            ToastStatus
                                                                .FAIL);
                                                        setState(() {
                                                          secondSelectedQuestion =
                                                              null;
                                                          secQuestion2Answer =
                                                              "";
                                                          secQues2 = "";
                                                        });
                                                      }
                                                     WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                      Navigator.of(context) .pop(true);
                                                      changeState(() {});
                                                      setState(() {});
                                                    }),
                                              ),
                                            ],
                                            children: [
                                              ListView.builder(
                                                itemCount:
                                                    allDropDownData
                                                        .length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      secQues2Temp = allDropDownData[index].description;
                                                      secondSelectedQuestionTemp = allDropDownData[index];
                                                      changeState( () {});
                                                    setState(() {});                                                        },
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                         padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24.h,0,24.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Text(
                                                                  allDropDownData[index].description ??
                                                                      "",
                                                                  style:
                                                                      size16weight700.copyWith(
                                                                    color:
                                                                        colors(context).blackColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 8).w,
                                                                child: UBRadio<
                                                                    dynamic>(
                                                                  value: allDropDownData[index].description ??  "",
                                                                  groupValue:  secQues2Temp,
                                                                  onChanged:
                                                                      (value) {
                                                                    secQues2Temp = value;
                                                                    secondSelectedQuestionTemp =  allDropDownData[index];
                                                                    changeState(() {});
                                                                    setState(() {});
                                                                      },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                       if(allDropDownData.length-1 != index)  Divider(
                                                      thickness: 1,height: 0,color: colors(context).greyColor100,
                                                    )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        }));
                                // if (result == null) {
                                  setState(() {});
                                // }
                              },
                              labelText: AppLocalizations.of(context)
                                  .translate(
                                      "Select_Security_Question_2"),
                              label: AppLocalizations.of(context)
                                  .translate("Security_Question_2"),
                              key: Key("secQues2"),
                              initialValue: secQues2,
                            ),
                            20.verticalSpace,
                            AppTextField(
                              validator: (value) {
                                if (secQuestion2Answer == null || secQuestion2Answer == '') {
                                  return AppLocalizations.of(context).translate("mandatory_field_msg");
                                } else {
                                  return null;
                                }
                              },
                              isInfoIconVisible: false,
                              key: Key('${secQuestion2Answer}_4' ??
                                  "secQuestion2Answer"),
                              onTextChanged: (value) {
                                secQuestion2Answer = value;
                                // setState(() {});
                              },
                              initialValue: secQuestion2Answer,
                              hint: AppLocalizations.of(context)
                                  .translate("Answer"),
                              textCapitalization:
                                  TextCapitalization.words,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                          buttonText:AppLocalizations.of(context)
                                  .translate("confirm"),
                          onTapButton: () {
                            if (_formkey.currentState?.validate() ==
                                false) {
                              return;}
                               WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            
                              _validateQuestions();
                           
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   void _validateQuestions() {
    if (secQues1 == "secQues1" || secQues2 == "secQues2") {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_choose_question"), ToastStatus.FAIL);
    } else if (secQues1Answer == null ||
        secQues1Answer == "" ||
        firstSelectedQuestion == null) {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_respond_first_question"), ToastStatus.FAIL);
    } else if (secQuestion2Answer == null ||
        secQuestion2Answer == "" ||
        secondSelectedQuestion == null) {
      ToastUtils.showCustomToast(
          context, AppLocalizations.of(context).translate("please_respond_second_question"), ToastStatus.FAIL);
    } else {
     _secBloc.add(SetSecurityQuestionsEvent([
              AnswerList(
                  answer: secQues1Answer, id: firstSelectedQuestion!.id),
              AnswerList(
                  answer: secQuestion2Answer, id: secondSelectedQuestion!.id),
            ],"migrated"));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _secBloc;
  }
}
