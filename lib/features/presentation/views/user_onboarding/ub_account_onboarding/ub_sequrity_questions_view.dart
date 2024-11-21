import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/core/service/analytics_service/analytics_services.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/drop_down/drop_down_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/create_user/create_user_state.dart';
import 'package:union_bank_mobile/features/presentation/views/add_biometrics_view/add_biometrics_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/user_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/biometric_helper.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/models/requests/set_security_questions_request.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/on_boarding/security_questions/security_questions_bloc.dart';
import '../../../bloc/on_boarding/security_questions/security_questions_event.dart';
import '../../../bloc/on_boarding/security_questions/security_questions_state.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';

class UBSecurityQuestionsView extends BaseView {
  final UserData userData;

  const UBSecurityQuestionsView({
    super.key,
    required this.userData,
  });

  @override
  _UBSecurityQuestionsViewState createState() =>
      _UBSecurityQuestionsViewState();
}

class _UBSecurityQuestionsViewState
    extends BaseViewState<UBSecurityQuestionsView> {
  final _secBloc = injection<SecurityQuestionsBloc>();
  final _userBloc = injection<CreateUserBloc>();
  final biometricHelper = injection<BiometricHelper>();
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

  bool _isBiometricAvailable = false;

  @override
  void initState() {
    _scrollController.addListener(_onScrollDraft);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => initialBiometric(),
    );
   _secBloc.add(GetSecurityQuestionSECDropDownEvent());
    super.initState();
  }

  _onScrollDraft() {
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }

  void initialBiometric() async {
    bool isDeviceSupport = await biometricHelper.isDeviceSupport();
    if (isDeviceSupport) {
      _isBiometricAvailable = await biometricHelper.checkBiometrics();
      if (_isBiometricAvailable) {}
      setState(() {});
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title:
            AppLocalizations.of(context).translate("setup_security_questions"),
      ),
      body: BlocProvider<CreateUserBloc>(
        create: (context) => _userBloc,
        child: BlocListener<CreateUserBloc, BaseState<CreateUserState>>(
          listener: (context, state) async {
            if (state is CreateUserSuccessState) {
              _userBloc.add(SaveUserEvent());

              /* ------------------------------------ . ----------------------------------- */

              await AnalyticsServices.instance?.analyticsSignup(userType: "UNIONBANK"); 

              /* ------------------------------------ . ----------------------------------- */
            }
            else if (state is CreateUserFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            }
            else if (state is SaveUserSuccessState) {
              showProgressBar();
              _secBloc.add(SetSecurityQuestionsEvent([
                AnswerList(
                    answer: secQues1Answer, id: firstSelectedQuestion!.id),
                AnswerList(
                    answer: secQuestion2Answer, id: secondSelectedQuestion!.id),
              ],""));
            }
            else if (state is SaveUserFailedState) {
              hideProgressBar();
              ToastUtils.showCustomToast(
                  context, state.message??AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
          },
          child: BlocProvider<SecurityQuestionsBloc>(
            create: (_) => _secBloc,
            child: BlocListener<SecurityQuestionsBloc,
                BaseState<SecurityQuestionsState>>(
              listener: (_, state) {
                if (state is SetSecurityQuestionsSuccessState) {
                  if (_isBiometricAvailable) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kAddBiometricsView, (route) => false,
                        arguments: BiometricsViewArgs(
                            appBarTitle: "add_your_biometrics",
                            fromRoutesName: Routes.kSecurityQuestionsView));
                  } else {
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
                }
                if (state is SetSecurityQuestionsFailedState) {
                  hideProgressBar();
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
                                  key: Key('${secQues1}_1' ?? "secQues1"),
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
                                                          secQues1 =
                                                              secQues1Temp;
                                                          firstSelectedQuestion =
                                                              firstSelectedQuestionTemp;
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
                                                          secQues1Temp =
                                                              allDropDownData[
                                                                      index]
                                                                  .description;
                                                          firstSelectedQuestionTemp =
                                                              allDropDownData[
                                                                  index];
                                                          changeState(
                                                              () {});
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
                                                                      value: allDropDownData[index].description ??
                                                                          "",
                                                                      groupValue:
                                                                          secQues1Temp,
                                                                      onChanged:
                                                                          (dynamic
                                                                              value) {
                                                                        secQues1Temp =
                                                                            value;
                                                                        secQues1Temp =
                                                                            allDropDownData[index].description;
                                                                        firstSelectedQuestionTemp =
                                                                            allDropDownData[index];
                                                                             changeState(
                                                          () {});
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
                                                        // DropDownListItem(
                                                        //   title: allDropDownData[index].description ?? "-",
                                                        //   onTap: () {
                                                        //     secQues1 = allDropDownData[index].description;
                                                        //     if(allDropDownData[index].description == secQues2){
                                                        //       ToastUtils.showCustomToast(context,
                                                        //           'Please select a different question', ToastStatus.FAIL);
                                                        //             setState(() {
                                                        //               firstSelectedQuestion = null;
                                                        //                secQues1Answer = "";
                                                        //               secQues1 = "";});
                                                        //     }
                                                        //     Navigator.pop(context);
                                                        //   },
                                                        // ),
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
                                  //     () async {
                                  //   final result = await Navigator.pushNamed(
                                  //     context,
                                  //     Routes.kDropDownView,
                                  //     arguments: DropDownViewScreenArgs(
                                  //       pageTitle: "Select Security Question",
                                  //       isSearchable: false,
                                  //       dropDownEvent:
                                  //           GetSecurityQuestionDropDownEvent(),
                                  //     ),
                                  //   ) as CommonDropDownResponse;
                                  //   if (result.description == secQues2) {
                                  //     ToastUtils.showCustomToast(
                                  //         context,
                                  //         'Please select a different question',
                                  //         ToastStatus.FAIL);
                                  //     setState(() {
                                  //       firstSelectedQuestion = null;
                                  //        secQues1Answer = "";
                                  //       secQues1 = AppLocalizations.of(context)
                                  //   .translate("Security_Question_1");
                                  //
                                  //     });
                                  //   } else {
                                  //     setState(() {
                                  //       firstSelectedQuestion = result;
                                  //       secQues1 = result.description;
                                  //       secQues1Answer = "";
                                  //     });
                                  //   }
                                  // },
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
                                  // key: Key('${secQues1Answer}_2' ?? "secQues1Answer"),
                                  onTextChanged: (value) {
                                    secQues1Answer = value;
                                    // setState(() {});
                                  },
                                  // initialValue: secQues1Answer,
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
                                                          secQues2 =
                                                              secQues2Temp;
                                                          secondSelectedQuestion =
                                                              secondSelectedQuestionTemp;
                                                          if (secQues1 ==
                                                              secQues2) {
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
                                                          secQues2Temp =
                                                              allDropDownData[
                                                                      index]
                                                                  .description;
                                                          secondSelectedQuestionTemp =
                                                              allDropDownData[
                                                                  index];
                                                          changeState(
                                                              () {});
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
                                                                      value: allDropDownData[index].description ??
                                                                          "",
                                                                      groupValue:
                                                                          secQues2Temp,
                                                                      onChanged:
                                                                          (value) {
                                                                        secQues2Temp =
                                                                            value;
                                                                        secQues2Temp =
                                                                            allDropDownData[index].description;
                                                                        secondSelectedQuestionTemp =
                                                                            allDropDownData[index];
                                                                             changeState(
                                                          () {});
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
                                                        // DropDownListItem(
                                                        //   title: allDropDownData[index].description ?? "-",
                                                        //   onTap: () {
                                                        //     secQues1 = allDropDownData[index].description;
                                                        //     if(allDropDownData[index].description == secQues2){
                                                        //       ToastUtils.showCustomToast(context,
                                                        //           'Please select a different question', ToastStatus.FAIL);
                                                        //             setState(() {
                                                        //               firstSelectedQuestion = null;
                                                        //                secQues1Answer = "";
                                                        //               secQues1 = "";});
                                                        //     }
                                                        //     Navigator.pop(context);
                                                        //   },
                                                        // ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                              //   BottomSheetBuilder(
                                              //   title: AppLocalizations.of(context).translate('select_security_question'),
                                              //   children: [
                                              //     2.4.verticalSpace,
                                              //     SingleChildScrollView(
                                              //       physics: BouncingScrollPhysics(),
                                              //       child: Expanded(
                                              //         child: ListView.builder(
                                              //           itemCount: allDropDownData.length,
                                              //           physics: const BouncingScrollPhysics(),
                                              //           shrinkWrap: true,
                                              //           itemBuilder: (context, index) {
                                              //             return DropDownListItem(
                                              //               title: allDropDownData[index].description ?? "-",
                                              //               onTap: () {
                                              //                 secQues2 = allDropDownData[index].description;
                                              //                 if(allDropDownData[index].description == secQues1){
                                              //                   ToastUtils.showCustomToast(context,
                                              //                       'Please select a different question', ToastStatus.FAIL);
                                              //                   setState(() {
                                              //                     secondSelectedQuestion = null;
                                              //                     secQuestion2Answer = "";
                                              //                     secQues2 = "";});
                                              //                 }
                                              //                 Navigator.pop(context);
                                              //               },
                                              //             );
                                              //           },
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // );
                                            }));
                                    // if (result == null) {
                                      setState(() {});
                                    // }
                                  },
                                  //     () async {
                                  //   final result = await Navigator.pushNamed(
                                  //     context,
                                  //     Routes.kDropDownView,
                                  //     arguments: DropDownViewScreenArgs(
                                  //       pageTitle: "Select Security Question",
                                  //       isSearchable: false,
                                  //       dropDownEvent:
                                  //           GetSecurityQuestionDropDownEvent(),
                                  //     ),
                                  //   ) as CommonDropDownResponse;
                                  //   if (result.description == secQues1) {
                                  //     ToastUtils.showCustomToast(
                                  //         context,
                                  //         'Please select a different question',
                                  //         ToastStatus.FAIL);
                                  //     setState(() {
                                  //       secondSelectedQuestion = null;
                                  //       secQuestion2Answer ="";
                                  //       secQues2 = AppLocalizations.of(context)
                                  //   .translate("Security_Question_2");
                                  //
                                  //     });
                                  //   } else {
                                  //     setState(() {
                                  //       secondSelectedQuestion = result;
                                  //       secQues2 = result.description;
                                  //       secQuestion2Answer ="";
                                  //     });
                                  //   }
                                  // },
                                  labelText: AppLocalizations.of(context)
                                      .translate(
                                          "Select_Security_Question_2"),
                                  label: AppLocalizations.of(context)
                                      .translate("Security_Question_2"),
                                  key: Key('${secQues2}_3' ?? "secQues2"),
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
                                    // setState(() {
                                      
                                    // });
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
                              buttonText: _isBiometricAvailable
                                  ? AppLocalizations.of(context)
                                      .translate("Next")
                                  : AppLocalizations.of(context)
                                      .translate("done"),
                              onTapButton: () {
                                if (_formkey.currentState?.validate() ==
                                    false) {
                                  return;
                                } else {
                                  _validateQuestions();
                                }
                              }),
                          // AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context))
                        ],
                      ),
                    ],
                  ),
                ),
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
      _userBloc.add(CreateUserEvent(
          confirmPassword: widget.userData.confirmPass,
          password: widget.userData.currentPass,
          username: widget.userData.username));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _userBloc;
  }
}
