import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/fund_transfer_data_component.dart';
import 'package:union_bank_mobile/features/presentation/views/schedule/schedule_bill_payment/widgets/bill_payment_schedule_args.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../../core/service/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';


class BPSchedulingSummary extends BaseView {
  final ScheduleBillPaymentArgs scheduleBillPaymentArgs;


  BPSchedulingSummary({required this.scheduleBillPaymentArgs});

  @override
  _BPSchedulingSummaryState createState() =>
      _BPSchedulingSummaryState();
}

class _BPSchedulingSummaryState
    extends BaseViewState<BPSchedulingSummary> {
  var bloc = injection<FTViewSchedulingBloc>();
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
          IconButton(
          onPressed: (){
              Navigator.pushNamed(context,
                  Routes.kBillPaymentHistoryView,
                  arguments: ScheduleBillPaymentArgs(
                      widget.scheduleBillPaymentArgs.billerEntity
                  ));
            },
            icon: PhosphorIcon(PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.bold),
              color: colors(context).whiteColor,
            ),
          )
        ],
        title: AppLocalizations.of(context).translate("schedule_summery"),
      ),
      body: BlocProvider<FTViewSchedulingBloc>(
        create: (_) => bloc,
        child: BlocListener<FTViewSchedulingBloc,
            BaseState<FTViewSchedulingState>>(
          listener: (_, state) {
            if (state is DeleteSchedulingFTSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,Routes.kFundTransferSchedulingView,
                    (Route<dynamic> route) => route.settings.name == Routes.kScheduleCategoryListView,
              );
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("schedule_delete_des"), ToastStatus.SUCCESS);
            }
            if (state is DeleteSchedulingFTFailState) {
              ToastUtils.showCustomToast(
                  context, state.errorMessage ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0 , right: 16).w,
                                child: Column(
                                  children: [
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("Pay_From"),
                                      data: widget.scheduleBillPaymentArgs.billerEntity.payFromName ?? "-",
                                      subData: widget.scheduleBillPaymentArgs.billerEntity.payFromNum ?? "-",
                                    ),
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("pay_to"),
                                      data: widget.scheduleBillPaymentArgs.billerEntity.billerName ?? "-",
                                      subData: widget.scheduleBillPaymentArgs.billerEntity.collectionAccount ?? "-",
                                    ),
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("amount"),
                                      isCurrency: true,
                                      amount: widget.scheduleBillPaymentArgs.billerEntity.amount,
                                    ),
                                    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 0)
                                      FTSummeryDataComponent(
                                      title: getDateType(),
                                      data:DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!))   ?? "-",
                                      isLastItem: widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT" ? false : true,
                                      // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                    ),
                                    if(widget.scheduleBillPaymentArgs.billerEntity.tabID != 0)
                                      FTSummeryDataComponent(
                                      title: getDateType(),
                                      data:DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!))   ?? "-",
                                      isLastItem: true,
                                      // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                    ),
                                    if(widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT" && widget.scheduleBillPaymentArgs.billerEntity.tabID == 0)
                                      Column(
                                        children: [
                                          FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("frequency"),
                                              data:widget.scheduleBillPaymentArgs.billerEntity.frequency ?? "-"
                                            // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                          ),
                                          FTSummeryDataComponent(
                                              title: AppLocalizations.of(context)
                                                  .translate("end_date"),
                                              data:DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.endDate!)) ?? "-"
                                            // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                          ),
                                          FTSummeryDataComponent(
                                            title: AppLocalizations.of(context)
                                                .translate("no_of_transfers"),
                                            data: widget.scheduleBillPaymentArgs.billerEntity.noOfTransfers ?? "-",
                                            isLastItem: true,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            )
    
                          ],
                        ),
                      ))),
              if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 0 || widget.scheduleBillPaymentArgs.billerEntity.tabID == 1)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0.w,16.h,16.w,16.h + AppSizer.getHomeIndicatorStatus(context)),
                  child: Column(
                    children: [
                      AppButton(
                          buttonText: AppLocalizations.of(context).translate("edit"),
                          onTapButton: () {
                            Navigator.pushNamed(
                                context,
                                Routes.kEditScheduleBillPaymentView,
                                arguments: widget.scheduleBillPaymentArgs
                            );
                          }),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText: AppLocalizations.of(context).translate("delete"),
                        onTapButton: () {
                          showAppDialog(
                            title: AppLocalizations.of(context).translate("delete_schedule"),
                            dialogContentWidget:
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppLocalizations.of(context).translate("delete_schedule_do_u_want"),
                                      style: size14weight400.copyWith(color: colors(context).greyColor)
                                  ),
                                  const TextSpan(
                                    text: "\n\n",
                                  ),
                                  TextSpan(
                                      text: "${AppLocalizations.of(context).translate("note")}: ",
                                      style:size14weight400.copyWith(color: colors(context).greyColor)
                                  ),
                                  TextSpan(
                                      text: AppLocalizations.of(context).translate("delete_schedule_des"),
                                      style: size14weight400.copyWith(color: colors(context).greyColor)
                                  ),
                                ],
                              ), textScaler: TextScaler.linear(1),
                            ),
                            alertType:
                            AlertType.WARNING,
                            onPositiveCallback:
                                () {
                                  bloc.add(DeleteFTScheduleEvent(
                                      messageType: "scheduleFtReq",
                                      scheduleId: widget.scheduleBillPaymentArgs.billerEntity.scheduleID,
                                      remarks: "testing schedule cancel"));
                            },
                            positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
                            negativeButtonText: AppLocalizations.of(context).translate("no"),
                            onNegativeCallback: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  getDateType(){
    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 0 && widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT"){
      return AppLocalizations.of(context).translate("start_date");
    }
    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 0 && widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() != "REPEAT"){
      return AppLocalizations.of(context).translate("transaction_date");
    }
    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 1){
      return AppLocalizations.of(context).translate("start_date");
    }
    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 2){
      return AppLocalizations.of(context).translate("completed_date");
    }
    if(widget.scheduleBillPaymentArgs.billerEntity.tabID == 3){
      return AppLocalizations.of(context).translate("deleted_date");
    }
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
