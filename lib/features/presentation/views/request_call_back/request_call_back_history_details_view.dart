import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/data/request_call_back_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/enums.dart';

import '../../bloc/request_callback/request_callback_bloc.dart';
import '../../bloc/request_callback/request_callback_event.dart';
import '../../bloc/request_callback/request_callback_state.dart';

import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';
import 'data/request_status.dart';


class ReqCallBackHistoryDetailsView extends BaseView {
  final ReqCallBackArgs reqCallBackArgs;


  ReqCallBackHistoryDetailsView({required this.reqCallBackArgs});

  @override
  _ReqCallBackHistoryDetailsViewState createState() => _ReqCallBackHistoryDetailsViewState();
}

class _ReqCallBackHistoryDetailsViewState extends BaseViewState<ReqCallBackHistoryDetailsView> {
  var bloc = injection<RequestCallBackBloc>();
  final _formKey = GlobalKey<FormState>();
  late DateTime date;
  @override
  void initState() {
    date = DateTime.now();
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
            if(state is RequestCallBackCancelSuccessState){
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.SUCCESS);
              if(widget.reqCallBackArgs.isHome == true){
                Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
              }else{
                Navigator.pushNamedAndRemoveUntil(
                  context,Routes.kRequestCallBackHistoryView,arguments: widget.reqCallBackArgs.isHome,
                      (Route<dynamic> route) => route.settings.name == Routes.kQuickAccessCarousel,
                );
              }
            }
            if(state is RequestCallBackCancelFailState){
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
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
                                  title: AppLocalizations.of(context).translate("additional_comments"),
                                  data: (widget.reqCallBackArgs.comments == "" ||
                                      widget.reqCallBackArgs.comments == null)
                                      ? "-" : widget.reqCallBackArgs.comments!,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("language"),
                                  data: language(),
                                ),
                                //   (widget.reqCallBackArgs.language?.description == "" ||
                                //       widget.reqCallBackArgs.language?.description == null)
                                //       ? "-" : widget.reqCallBackArgs.language!.description!,
                                // ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context).translate("request_date"),
                                  data: "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(date)}",
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context).translate("status") ,
                                      style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: colors(context).greyColor300,
                                    ),),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                              color: colors(context).greyColor200!),
                                          color: getStatus(widget.reqCallBackArgs.status??"",context).color!),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 7.0, right: 7, top: 4, bottom: 4),
                                        child: Text(
                                          getStatus(widget.reqCallBackArgs.status??"",context).status!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: colors(context).whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]
                          ),
                        )),
                    if(widget.reqCallBackArgs.status == "NOTSTARTED")
                      AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                        buttonText: AppLocalizations.of(context).translate("cancel_request"),
                        onTapButton: () {
                          showAppDialog(
                              title: AppLocalizations.of(context).translate("cancel_the_confirmation"),
                              message: AppLocalizations.of(context).translate("cancel_des_req_call_back"),
                              alertType: AlertType.WARNING,
                              onPositiveCallback: () {
                                bloc.add(
                                    RequestCallBackCancelEvent(
                                        requestCallBackId: widget.reqCallBackArgs.id
                                    ));
                              },
                              positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                              negativeButtonText: AppLocalizations.of(context).translate("no"),
                              onNegativeCallback: (){}
                          );
                        },
                      ),

                  ],
                ),
              )),
        ),
      ),
    );
  }

  language(){
    if(widget.reqCallBackArgs.language?.description == "si" || widget.reqCallBackArgs.language?.description == "සිංහල"){
      return  "සිංහල";
        // AppConstants.kLanguageList2.where((e) => e.description == "si").first.description;
    }
    if(widget.reqCallBackArgs.language?.description == "eng" || widget.reqCallBackArgs.language?.description == "English"){
      return "English";
    }
    if(widget.reqCallBackArgs.language?.description == "ta" || widget.reqCallBackArgs.language?.description == "தமிழ்"){
      return "தமிழ்";
    }

  }




  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }

}