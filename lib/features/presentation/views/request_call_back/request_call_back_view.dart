import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_state.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/data/request_call_back_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/models/responses/city_response.dart';
import '../../bloc/drop_down/drop_down_bloc.dart';
import '../../widgets/app_button.dart';

import '../../widgets/appbar.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';

class RequestCallBackView extends BaseView {
  final bool isHome;
  const RequestCallBackView({super.key, required this.isHome});

  @override
  _RequestCallBackViewState createState() => _RequestCallBackViewState();
}

class _RequestCallBackViewState extends BaseViewState<RequestCallBackView> {
  var bloc = injection<RequestCallBackBloc>();
  final _formKey = GlobalKey<FormState>();
  CommonDropDownResponse? callBackTime;
  CommonDropDownResponse? subject;
  String? commonDetails;
  CommonDropDownResponse? languages;
  bool _checkbox = false;

  bool isValuesSelected = false;

  List<CommonDropDownResponse> callBackTimeList = [];
  List<CommonDropDownResponse> subjectList = [];

  @override
  void initState() {
    bloc.add(RequestCallBackGetDefaultDataEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        if(isValuesSelected) {
          showAppDialog(
            title: AppLocalizations.of(context)
                .translate("cancel_the_confirmation"),
            message: AppLocalizations.of(context)
                .translate("cancel_the_confirmation_des"),
            alertType: AlertType.INFO,
            onPositiveCallback: () {
              Navigator.pushNamedAndRemoveUntil(context, Routes.kHomeBaseView, (route) => false);
            },
            positiveButtonText:
                AppLocalizations.of(context).translate("yes,_cancel"),
            negativeButtonText: AppLocalizations.of(context).translate("no"),
            onNegativeCallback: () {});
            
        }else{
            Navigator.of(context).pop();
        }
        return true;
      },
      child: Scaffold(
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("request_callbak"),
          goBackEnabled: true,
          onBackPressed: (){
          if(isValuesSelected) {
            showAppDialog(
            title: AppLocalizations.of(context)
                .translate("cancel_the_confirmation"),
            message: AppLocalizations.of(context)
                .translate("cancel_the_confirmation_des"),
            alertType: AlertType.INFO,
            onPositiveCallback: () {
              Navigator.pushNamedAndRemoveUntil(context, Routes.kHomeBaseView, (route) => false);
            },
            positiveButtonText:
                AppLocalizations.of(context).translate("yes,_cancel"),
            negativeButtonText: AppLocalizations.of(context).translate("no"),
            onNegativeCallback: () {});
          }else{
            Navigator.of(context).pop();
          }
          }
        ),
        body: BlocProvider<RequestCallBackBloc>(
         create: (_) => bloc,
          child: BlocListener<RequestCallBackBloc, BaseState<RequestCallBackState>>(
            bloc: bloc,
            listener: (context, state) {
              if(state is RequestCallBackGetDefaultDataSuccessState){
                if (state.requestCallBackGetDefaultDataResponse
                        ?.requestDetailDefaultDataTimeSlotResponseList !=
                    null) {
                  callBackTimeList = state
                      .requestCallBackGetDefaultDataResponse!
                      .requestDetailDefaultDataTimeSlotResponseList!
                      .map((e) => CommonDropDownResponse(
                          code: e.slotName,
                          description: e.slotName,
                          id: e.id,
                          key: e.slotCode))
                      .toList();
                }
                if (state.requestCallBackGetDefaultDataResponse
                        ?.requestDetailDefaultDataTimeSlotResponseList !=
                    null) {
                  subjectList = state.requestCallBackGetDefaultDataResponse!
                      .requestDetailDefaultDataSubjectResponses!
                      .map((e) => CommonDropDownResponse(
                          code: e.subjectName,
                          description: e.subjectName,
                          id: e.id,
                          key: e.subjectCode))
                      .toList();
                }

              }else if(state is RequestCallBackGetDefaultDataFailState){
                 ToastUtils.showCustomToast(
                        context, state.message??"", ToastStatus.FAIL);

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppDropDown(
                                validator: (value) {
                                  if (callBackTime?.description == null ||
                                      callBackTime?.description == "") {
                                    return AppLocalizations.of(context)
                                        .translate(
                                            "mandatory_field_msg_selection");
                                  } else {
                                    return null;
                                  }
                                },
                                isDisable: false,
                                labelText: AppLocalizations.of(context)
                                    .translate("call_back_time"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.kDropDownView,
                                      arguments: DropDownViewScreenArgs(
                                        itemList: callBackTimeList,
                                        isAnEvent: false,
                                        isSearchable: true,
                                        pageTitle:
                                            AppLocalizations.of(context)
                                                .translate("call_back_time"),
                                      )).then((value) {
                                    if (value != null &&
                                        value is CommonDropDownResponse) {
                                      setState(() {
                                        callBackTime = value;
                                        isValuesSelected =true;
                                      });
                                    }
                                  });
                                },
                                initialValue: callBackTime?.description,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              AppDropDown(
                                validator: (value) {
                                  if (subject?.description == null || subject?.description == "") {
                                    return AppLocalizations.of(context)
                                        .translate(
                                            "mandatory_field_msg_selection");
                                  } else {
                                    return null;
                                  }
                                },
                                isDisable: false,
                                labelText: AppLocalizations.of(context)
                                    .translate("subject_reason"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.kDropDownView,
                                      arguments: DropDownViewScreenArgs(
                                        itemList: subjectList,
                                        isAnEvent: false,
                                        isSearchable: true,
                                        pageTitle:
                                            AppLocalizations.of(context)
                                                .translate("subject_reason"),
                                      )).then((value) {
                                    if (value != null &&
                                        value is CommonDropDownResponse) {
                                      setState(() {
                                        subject = value;
                                        isValuesSelected =true;
                                      });
                                    }
                                  });
                                },
                                initialValue: subject?.description,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AppTextField(
                                maxLength: 30,
                                isInfoIconVisible: false,
                                inputType: TextInputType.text,
                                hint: AppLocalizations.of(context)
                                    .translate("comments_details"),
                                textCapitalization: TextCapitalization.none,
                                isLabel: true,
                                onTextChanged: (value) {
                                    commonDetails = value;
                                    isValuesSelected = true;
                                  
                                },
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              AppDropDown(
                                validator: (value) {
                                  if (languages?.description == null || languages?.description == "") {
                                    return AppLocalizations.of(context)
                                        .translate(
                                            "mandatory_field_msg_selection");
                                  } else {
                                    return null;
                                  }
                                },
                                isDisable: false,
                                labelText: AppLocalizations.of(context)
                                    .translate("language"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.kDropDownView,
                                      arguments: DropDownViewScreenArgs(
                                        isSearchable: true,
                                        pageTitle:
                                            AppLocalizations.of(context)
                                                .translate("language"),
                                        dropDownEvent:
                                            GetLanguageDropDownEvent(),
                                      )).then((value) {
                                    if (value != null &&
                                        value is CommonDropDownResponse) {
                                      setState(() {
                                        languages = value;
                                        isValuesSelected =true;
                                      });
                                    }
                                  });
                                },
                                initialValue: languages?.description,
                              ),
                            ]),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: Transform.scale(
                                scale: 1.1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 2.0,
                                    ),
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6)),
                                    value: _checkbox,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkbox = !_checkbox;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("req_call_back_des"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppButton(
                            buttonText: AppLocalizations.of(context)
                                .translate("next"),
                            onTapButton: () {
                              if (_formKey.currentState?.validate() ==
                                  false) {
                                return;
                              }
                              _checkbox == true
                                  ? Navigator.pushNamed(
                                      context, Routes.kReqCallBackSummaryView,
                                      arguments: ReqCallBackArgs(
                                          callBackTime: callBackTime,
                                          subject: subject,
                                          comments: commonDetails,
                                          isHome: widget.isHome,
                                          language: languages),
                              )
                                  : showAppDialog(
                                      title: AppLocalizations.of(context).translate("check_box_msg"),
                                      message: AppLocalizations.of(context).translate("check_box_msg"),
                                      alertType: AlertType.INFO,
                                      onPositiveCallback: () {},
                                      positiveButtonText:
                                          AppLocalizations.of(context)
                                              .translate("ok"),
                                    );
                            }),
                        AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonText: AppLocalizations.of(context)
                              .translate("cancel"),
                         
                          onTapButton: () {
                            showAppDialog(
                                title: AppLocalizations.of(context)
                                    .translate("cancel_the_confirmation"),
                                message: AppLocalizations.of(context)
                                    .translate("cancel_des_req_call_back"),
                                alertType: AlertType.INFO,
                                onPositiveCallback: () {
                                   Navigator.pushNamedAndRemoveUntil(context, Routes.kHomeBaseView, (route) => false);
                                },
                                positiveButtonText:
                                    AppLocalizations.of(context)
                                        .translate("yes,_cancel"),
                                negativeButtonText:
                                    AppLocalizations.of(context)
                                        .translate("no"),
                                onNegativeCallback: () {});
                          },
                        ),
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
