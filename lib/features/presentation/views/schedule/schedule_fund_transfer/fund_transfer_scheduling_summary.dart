import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/fund_transfer_data_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../utils/enums.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../fund_transfer/data/fund_transfer_args.dart';

class FTSchedulingSummary extends BaseView {
  final FundTransferArgs? fundTransferArgs;

  FTSchedulingSummary({this.fundTransferArgs});

  @override
  _OwnAcctNowPaymentFailViewState createState() => _OwnAcctNowPaymentFailViewState();
}

class _OwnAcctNowPaymentFailViewState extends BaseViewState<FTSchedulingSummary> {
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
          if (widget.fundTransferArgs!.fundTransferEntity.tabID != 1)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.kFundTransferHistoryView,
                    arguments: FundTransferArgs(
                        widget.fundTransferArgs!.fundTransferEntity));
              },
              icon: PhosphorIcon(
                PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.bold),
                color: colors(context).whiteColor,
              ),
            )
        ],
        title: AppLocalizations.of(context).translate("schedule_summary"),
      ),
      body: BlocProvider<FTViewSchedulingBloc>(
        create: (_) => bloc,
        child: BlocListener<FTViewSchedulingBloc, BaseState<FTViewSchedulingState>>(
          listener: (_, state) {
            if (state is DeleteSchedulingFTSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.kFundTransferSchedulingView,
                (Route<dynamic> route) => route.settings.name == Routes.kScheduleCategoryListView,
              );
              ToastUtils.showCustomToast(context, AppLocalizations.of(context).translate("schedule_delete_des"), ToastStatus.SUCCESS);
            }
            if (state is DeleteSchedulingFTFailState) {
              ToastUtils.showCustomToast(context, state.errorMessage ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
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
                                padding: const EdgeInsets.only(left: 16.0, right: 16).w,
                                child: Column(
                                  children: [
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("Pay_From"),
                                      data: widget.fundTransferArgs?.fundTransferEntity.payFromName ?? "-",
                                      subData:
                                          widget.fundTransferArgs?.fundTransferEntity.payFromNum ?? "-",
                                    ),
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("pay_to"),
                                      data: widget.fundTransferArgs?.fundTransferEntity.payToacctname ?? "-",
                                      subData:
                                          widget.fundTransferArgs?.fundTransferEntity.payToacctnmbr ?? "-",
                                    ),
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("amount"),
                                      isCurrency: true,
                                      amount: widget.fundTransferArgs?.fundTransferEntity.amount,
                                    ),
                                    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 0)
                                      FTSummeryDataComponent(
                                        title: getDateType(),
                                        data: DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy')
                                                .parse(widget.fundTransferArgs!.fundTransferEntity.startDate!)) ??
                                            "-",
                                        isLastItem:
                                            widget.fundTransferArgs?.fundTransferEntity.scheduleType?.toUpperCase() ==
                                                    "REPEAT"
                                                ? false
                                                : true,
                                        // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                      ),
                                    if (widget.fundTransferArgs?.fundTransferEntity.tabID != 0)
                                      FTSummeryDataComponent(
                                        title: getDateType(),
                                        data: DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy')
                                                .parse(widget.fundTransferArgs!.fundTransferEntity.startDate!)) ??
                                            "-",
                                        isLastItem: true,
                                        // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                      ),
                                    if (widget.fundTransferArgs?.fundTransferEntity.scheduleType?.toUpperCase() ==
                                            "REPEAT" &&
                                        widget.fundTransferArgs?.fundTransferEntity.tabID == 0)
                                      Column(
                                        children: [
                                          FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("frequency"),
                                              data: widget.fundTransferArgs?.fundTransferEntity.scheduleFrequency ??
                                                  "-"
                                              // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                              ),
                                          FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("end_date"),
                                              data: DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy')
                                                      .parse(widget.fundTransferArgs!.fundTransferEntity.endDate!)) ??
                                                  "-"
                                              // "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(dateTime)}",
                                              ),
                                          FTSummeryDataComponent(
                                            title: AppLocalizations.of(context).translate("no_of_transfers"),
                                            data: widget.fundTransferArgs?.fundTransferEntity.noOfTransfers ?? "-",
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
              if (widget.fundTransferArgs?.fundTransferEntity.tabID == 0 ||
                  widget.fundTransferArgs?.fundTransferEntity.tabID == 1)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0.w,16.h,16.w,16.h + AppSizer.getHomeIndicatorStatus(context)),
                  child: Column(
                    children: [
                      AppButton(
                          buttonText: AppLocalizations.of(context).translate("edit"),
                          onTapButton: () {
                            Navigator.pushNamed(context, Routes.kEditScheduleView,
                                arguments: widget.fundTransferArgs);
                          }),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText: AppLocalizations.of(context).translate("delete"),
                        onTapButton: () {
                          showAppDialog(
                            title: AppLocalizations.of(context).translate("delete_schedule"),
                            dialogContentWidget: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppLocalizations.of(context).translate("delete_schedule_do_u_want"),
                                      style: size14weight400.copyWith(color: colors(context).greyColor)),
                                  const TextSpan(
                                    text: "\n\n",
                                  ),
                                  TextSpan(
                                      text: "${AppLocalizations.of(context).translate("note")}: ",
                                      style: size14weight400.copyWith(color: colors(context).greyColor)),
                                  TextSpan(
                                      text: AppLocalizations.of(context).translate("delete_schedule_des"),
                                      style: size14weight400.copyWith(color: colors(context).greyColor)),
                                ],
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            alertType: AlertType.WARNING,
                            onPositiveCallback: () {
                              bloc.add(DeleteFTScheduleEvent(
                                  messageType: "scheduleFtReq",
                                  scheduleId: widget.fundTransferArgs?.fundTransferEntity.scheduleId,
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

  getDateType() {
    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 0 &&
        widget.fundTransferArgs?.fundTransferEntity.scheduleType?.toUpperCase() == "REPEAT") {
      return AppLocalizations.of(context).translate("start_date");
    }
    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 0 &&
        widget.fundTransferArgs?.fundTransferEntity.scheduleType?.toUpperCase() != "REPEAT") {
      return AppLocalizations.of(context).translate("transaction_date");
    }
    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 1) {
      return AppLocalizations.of(context).translate("start_date");
    }
    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 2) {
      return AppLocalizations.of(context).translate("completed_date");
    }
    if (widget.fundTransferArgs?.fundTransferEntity.tabID == 3) {
      return AppLocalizations.of(context).translate("deleted_date");
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
