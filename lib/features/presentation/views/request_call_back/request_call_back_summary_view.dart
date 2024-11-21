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
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/enums.dart';

import '../../widgets/app_button.dart';

import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';





class ReqCallBackSummaryView extends BaseView {
  final ReqCallBackArgs reqCallBackArgs;


  ReqCallBackSummaryView({required this.reqCallBackArgs});

  @override
  _ReqCallBackSummaryViewState createState() => _ReqCallBackSummaryViewState();
}

class _ReqCallBackSummaryViewState extends BaseViewState<ReqCallBackSummaryView> {
  var bloc = injection<RequestCallBackBloc>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        goBackEnabled: true,
        title: AppLocalizations.of(context).translate("request_callbak") ,
      ),
       body: BlocProvider<RequestCallBackBloc>(
         create: (_) => bloc,
          child: BlocListener<RequestCallBackBloc, BaseState<RequestCallBackState>>(
          listener: (_, state) {
            if(state is RequestCallBackSaveSuccessState){
              showAppDialog(
                title:
                    AppLocalizations.of(context).translate("request_success"),
                message: AppLocalizations.of(context)
                    .translate("req_call_back_succes_des"),
                alertType: AlertType.SUCCESS,
                onPositiveCallback: () {
                  if(widget.reqCallBackArgs.isHome == true){
                    Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                  }else{
                    Navigator.pushNamedAndRemoveUntil(
                      context,Routes.kRequestCallBackHistoryView,arguments: widget.reqCallBackArgs.isHome,
                          (Route<dynamic> route) => route.settings.name == Routes.kQuickAccessCarousel,
                    );
                  }
                },
                positiveButtonText: AppLocalizations.of(context).translate("ok"),
              );

              }else if(state is RequestCallBackSaveFailState){
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
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("prefer_time_slot"),
                                  data: (widget.reqCallBackArgs.callBackTime?.description == "" ||
                                      widget.reqCallBackArgs.callBackTime?.description == null)
                                      ? "-" : widget.reqCallBackArgs.callBackTime!.description!,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("subject_reason"),
                                  data: (widget.reqCallBackArgs.subject?.description == "" ||
                                      widget.reqCallBackArgs.subject?.description == null)
                                      ? "-" : widget.reqCallBackArgs.subject!.description!,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("comments_details_"),
                                  data: (widget.reqCallBackArgs.comments == "" ||
                                      widget.reqCallBackArgs.comments == null)
                                      ? "-" : widget.reqCallBackArgs.comments!,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("language"),
                                  data: (widget.reqCallBackArgs.language?.description == "" ||
                                      widget.reqCallBackArgs.language?.description == null)
                                      ? "-" : widget.reqCallBackArgs.language!.description!,
                                ),
                              ]
                          ),
                        )),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(8),
                              border: Border.all(color: colors(context).secondaryColor ?? colors(context).whiteColor!),
                              color: colors(context).secondaryColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 15.0 , left: 5),
                                //   child: Image.asset(AppAssets.icSheduleInfo , scale: 3,),
                                // ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0 , bottom: 15 , right: 15 , left: 10),
                                    child:
                                    Text(
                                      AppLocalizations.of(context).translate("req_call_back_summary_des"),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),),
                        SizedBox(height: 3.h,),
                        AppButton(
                            buttonText:
                            AppLocalizations.of(context).translate("confirm"),
                            onTapButton: () {
                              bloc.add(RequestCallBackSaveEvent(
                                  callBackTime: widget.reqCallBackArgs.callBackTime?.id.toString(),
                                  subject: widget.reqCallBackArgs.subject?.id.toString(),
                                  language: widget.reqCallBackArgs.language?.code.toString(),
                                  comment: widget.reqCallBackArgs.comments));
                            }),
                        AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonText: AppLocalizations.of(context).translate("cancel"),
                         
                          onTapButton: () {
                            showAppDialog(
                                title: AppLocalizations.of(context).translate("cancel_the_confirmation"),
                                message: AppLocalizations.of(context).translate("cancel_des_req_call_back"),
                                alertType: AlertType.INFO,
                                onPositiveCallback: () {
                                   Navigator.pushNamedAndRemoveUntil(context, Routes.kHomeBaseView, (route) => false);
                                },
                                positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                                negativeButtonText: AppLocalizations.of(context).translate("no"),
                                onNegativeCallback: (){}
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}