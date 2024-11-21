import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/biller_entity.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import 'package:union_bank_mobile/features/presentation/views/schedule/schedule_bill_payment/widgets/bill_payment_schedule_args.dart';


import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../fund_transfer/widgets/scheduling_widget.dart';

class ScheduleBillPaymentView extends BaseView {
  ScheduleBillPaymentView({Key? key}) : super(key: key);

  @override
  _ScheduleBillPaymentViewState createState() =>
      _ScheduleBillPaymentViewState();
}

class _ScheduleBillPaymentViewState
    extends BaseViewState<ScheduleBillPaymentView> {
  var bloc = injection<FTViewSchedulingBloc>();
  //final billPaymentEntity = BillerEntity();
  BillerEntity billPaymentEntity = BillerEntity();
  List<BillerEntity> ongoingList = [];
  List<BillerEntity> upcomingList = [];
  List<BillerEntity> completedList = [];
  List<BillerEntity> deletedList = [];

  List<bool> expansionStates = List.generate(100, (index) => false);
  List<bool> expansionUpcomingStates = List.generate(
      100, (index) => false); // Initial expansion state for each item
  List<bool> expansionCompletedgStates = List.generate(
      100, (index) => false); // Initial expansion state for each item
  List<bool> expansionDeletedStates = List.generate(100, (index) => false);

  void _toggleExpansionState(int index) {
    setState(() {
      expansionStates[index] = !expansionStates[index];
    });
  }

  void _toggleExpansionUpcomingState(int index) {
    setState(() {
      expansionUpcomingStates[index] = !expansionUpcomingStates[index];
    });
  }

  void _toggleExpansionCompletedState(int index) {
    setState(() {
      expansionCompletedgStates[index] = !expansionCompletedgStates[index];
    });
  }

  void _toggleExpansionDeletedState(int index) {
    setState(() {
      expansionDeletedStates[index] = !expansionDeletedStates[index];
    });
  }

  //var bloc = injection<SplashBloc>();
  bool _isOngoingAvaolable = true;
  bool _isUpcomingAvaolable = true;
  bool _isCompletedAvaolable = true;
  bool _isdeletedAvaolable = true;

  List<String> tabs = [
    "ongoing",
    "upcoming",
    "completed",
    "deleted",
  ];
  int current = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      bloc.add(
          GetAllScheduleFTEvent(messageType: "scheduleFtReq", txnType: "BP"));
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("schedule_bill_payment")),
      body: BlocProvider<FTViewSchedulingBloc>(
        create: (_) => bloc,
        child: BlocListener<FTViewSchedulingBloc,
            BaseState<FTViewSchedulingState>>(
          listener: (_, state) {
            if (state is DeleteSchedulingFTSuccessState) {
              Navigator.pop(context, Routes.kScheduleBillPaymentView);
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("schedule_delete_des"), ToastStatus.SUCCESS);
            }
            if (state is GetAllScheduleFTSuccessState) {
              setState(() {
                ongoingList.clear();
                ongoingList.addAll(state.ongoingScheduleDetailsDtos!
                    .map((e) => BillerEntity(
                        collectionAccount: e.toAccountNo,
                        billerName: e.toAccountName,
                        startDate: e.startDate.toString(),
                        endDate: e.endDate.toString(),
                        frequency: e.frequency,
                        payFromName: e.fromAccountName,
                        payFromNum: e.fromAccountNo,
                        scheduleType: e.scheduleType,
                        scheduleID: e.scheduleId,
                        amount: e.amount != null ? e.amount : 0,
                        reference: e.reference,
                    tranType: e.tranType,
                        billerImage: e.billerLogoImage,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                upcomingList.clear();
                upcomingList.addAll(state.upcomingScheduleDetailsDtos!
                    .map((e) => BillerEntity(
                        collectionAccount: e.toAccountNo,
                        billerName: e.toAccountName,
                        startDate: e.startDate.toString(),
                        endDate: e.endDate.toString(),
                        frequency: e.frequency,
                        payFromName: e.fromAccountName,
                        payFromNum: e.fromAccountNo,
                    scheduleType: e.scheduleType,
                    scheduleID: e.scheduleId,
                        amount: e.amount != null ? e.amount : 0,
                    reference: e.reference,
                    tranType: e.tranType,
                    billerImage: e.billerLogoImage,
                    noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                completedList.clear();
                completedList.addAll(state.completedScheduleDetailsDtos!
                    .map((e) => BillerEntity(
                        collectionAccount: e.toAccountNo,
                        billerName: e.toAccountName,
                        startDate: e.startDate.toString(),
                        endDate: e.endDate.toString(),
                        frequency: e.frequency,
                        payFromName: e.fromAccountName,
                        payFromNum: e.fromAccountNo,
                    scheduleType: e.scheduleType,
                    reference: e.reference,
                    scheduleID: e.scheduleId,
                        amount: e.amount != null ? e.amount : 0,
                    billerImage: e.billerLogoImage,
                    tranType: e.tranType,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                deletedList.clear();
                deletedList.addAll(state.deletedScheduleDetailsDtos!
                    .map((e) => BillerEntity(
                        collectionAccount: e.toAccountNo,
                        billerName: e.toAccountName,
                        startDate: e.startDate.toString(),
                        endDate: e.endDate.toString(),
                        frequency: e.frequency,
                        payFromName: e.fromAccountName,
                    scheduleType: e.scheduleType,
                    reference: e.reference,
                    payFromNum: e.fromAccountNo,
                    billerImage: e.billerLogoImage,
                    tranType: e.tranType,
                        scheduleID: e.scheduleId,
                        amount: e.amount != null ? e.amount : 0,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                if (ongoingList.length >= 1) {
                  setState(() {
                    _isOngoingAvaolable = true;
                  });
                } else {
                  setState(() {
                    _isOngoingAvaolable = false;
                  });
                }
                if (upcomingList.length >= 1) {
                  setState(() {
                    _isUpcomingAvaolable = true;
                  });
                } else {
                  setState(() {
                    _isUpcomingAvaolable = false;
                  });
                }
                if (completedList.length >= 1) {
                  setState(() {
                    _isCompletedAvaolable = true;
                  });
                } else {
                  setState(() {
                    _isCompletedAvaolable = false;
                  });
                }
                if (deletedList.length >= 1) {
                  setState(() {
                    _isdeletedAvaolable = true;
                  });
                } else {
                  setState(() {
                    _isdeletedAvaolable = false;
                  });
                }
              });
            }
            if (state is GetAllScheduleFTFailedState) {
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
            }
          },
          child: Stack(
            children: [
              if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("ongoing") && _isOngoingAvaolable == false)
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).secondaryColor300,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: PhosphorIcon(
                            PhosphorIcons.calendar(PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppLocalizations.of(context)
                            .translate("no_ongoing_schedules"),
                        style: size18weight700.copyWith(
                            color: colors(context).blackColor),
                            textAlign: TextAlign.center,
                      ),
                      4.verticalSpace,
                      Text(
                        AppLocalizations.of(context)
                            .translate("no_ongoing_schedules_des"),
                        textAlign: TextAlign.center,
                        style: size14weight400.copyWith(
                            color: colors(context).greyColor300),
                            
                      ),
                    ],
                  ),
              ), 
              if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("upcoming") && _isUpcomingAvaolable == false)
                Center(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).secondaryColor300,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: PhosphorIcon(
                            PhosphorIcons.calendar(PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("no_upcoming_schedules"),
                         textAlign: TextAlign.center,
                        style: size18weight700.copyWith(color: colors(context).blackColor),),
                      4.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("no_upcoming_schedules_des"),
                        textAlign: TextAlign.center,
                        style: size14weight400.copyWith(color: colors(context).greyColor300),),
                    ],
                  ),
                ),
              if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("completed") && _isCompletedAvaolable == false)
              Center(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors(context).secondaryColor300,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: PhosphorIcon(
                          PhosphorIcons.calendar(PhosphorIconsStyle.bold),
                          color: colors(context).whiteColor,
                          size: 28,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      AppLocalizations.of(context).translate("no_complete_schedules"),
                      textAlign: TextAlign.center,
                      style: size18weight700.copyWith(color: colors(context).blackColor),),
                    4.verticalSpace,
                    Text(
                      AppLocalizations.of(context).translate("no_complete_schedules_des"),
                      textAlign: TextAlign.center,
                      style: size14weight400.copyWith(color: colors(context).greyColor300),),
                  ],
                ),
              ),
              if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("deleted") && _isdeletedAvaolable == false)
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 142.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).secondaryColor300,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: PhosphorIcon(
                            PhosphorIcons.calendar(PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("no_delete_schedules"),
                        textAlign: TextAlign.center,
                        style: size18weight700.copyWith(color: colors(context).blackColor),),
                      4.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate("no_delete_schedules_des"),
                        textAlign: TextAlign.center,
                        style: size14weight400.copyWith(color: colors(context).greyColor300),),
                    ],
                   ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child:Row(
                          children: [
                            for (int index = 0; index < tabs.length; index++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                child: Container(
                                  padding:  EdgeInsets.symmetric(
                                     horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: index == current
                                        ? colors(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                      tabs[index],
                                      style: index == current ?
                                      size14weight700.copyWith(color: colors(context).whiteColor) :
                                      size14weight700.copyWith(color: colors(context).blackColor)
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if((AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("ongoing") && _isOngoingAvaolable == true) ||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("upcoming") && _isUpcomingAvaolable == true) ||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("completed") && _isCompletedAvaolable == true) ||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("deleted") && _isdeletedAvaolable == true)
                    )
                      24.verticalSpace,
                    AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("ongoing")
                        ?
                    _isOngoingAvaolable == true
                        ?
                    Expanded(
                      child: SingleChildScrollView(
                        key: Key("o"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,
                              ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                     padding: EdgeInsets.zero,
                                          itemCount: ongoingList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, int index) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SchedulingWidget(
                                                  initialName: ongoingList[index].billerName,
                                                  accountName: ongoingList[index].billerName,
                                                  accountNumber: ongoingList[index].collectionAccount,
                                                  amount: ongoingList[index].amount.toString().withThousandSeparator(),
                                                  icon: ongoingList[index].billerImage,
                                                  tranType: ongoingList[index].tranType,
                                                  onTap: (){
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes.kBPSchedulingSummary,
                                                        arguments: ScheduleBillPaymentArgs(BillerEntity(
                                                            billerName: ongoingList[index].billerName,
                                                            collectionAccount: ongoingList[index].collectionAccount,
                                                            startDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(ongoingList[index].startDate!)),
                                                            endDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(ongoingList[index].endDate!)),
                                                            frequency: ongoingList[index].frequency,
                                                            payFromName: ongoingList[index].payFromName,
                                                            payFromNum: ongoingList[index].payFromNum,
                                                            scheduleID: ongoingList[index].scheduleID,
                                                            amount: ongoingList[index].amount,
                                                            noOfTransfers: ongoingList[index].noOfTransfers,
                                                            reference: ongoingList[index].reference,
                                                            scheduleType: ongoingList[index].scheduleType,
                                                          tabID: current,
                                                            billerImage: ongoingList[index].billerImage
                                                        )));
                                                  },
                                                ),
                                                if(ongoingList.length-1 != index)
                                                  Padding(
                                                        padding: const EdgeInsets.only(left: 16 , right: 16),
                                                        child: Divider(
                                                          height: 0,
                                                          thickness: 1,
                                                          color: colors(context).greyColor100,
                                                        ),
                                                      )
                                              ],
                                            );
                                      
                                          })
                                ),
                        ),
                      ),
                    )
                        : SizedBox.shrink()
                        :
                    AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("upcoming")
                        ?
                    _isUpcomingAvaolable == true
                        ?
                    Expanded(
                      child: SingleChildScrollView(
                        key: Key("p"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics: NeverScrollableScrollPhysics(),
                                              itemCount: upcomingList.length,
                                              itemBuilder: (context, int index) {
                                                return Column(
                                                  children: [
                                                    SchedulingWidget(
                                                      initialName: upcomingList[index].billerName,
                                                      accountName: upcomingList[index].billerName,
                                                      accountNumber: upcomingList[index].collectionAccount,
                                                      amount: upcomingList[index].amount.toString().withThousandSeparator(),
                                                      icon: upcomingList[index].billerImage,
                                                      tranType: upcomingList[index].tranType,
                                                      onTap: (){
                                                        Navigator.pushNamed(
                                                            context,
                                                            Routes.kBPSchedulingSummary,
                                                            arguments: ScheduleBillPaymentArgs(BillerEntity(
                                                                billerName: upcomingList[index].billerName,
                                                                collectionAccount: upcomingList[index].collectionAccount,
                                                                startDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(upcomingList[index].startDate!)),
                                                                endDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(upcomingList[index].endDate!)),
                                                                frequency: upcomingList[index].frequency,
                                                                payFromName: upcomingList[index].payFromName,
                                                                payFromNum: upcomingList[index].payFromNum,
                                                                scheduleID: upcomingList[index].scheduleID,
                                                                amount: upcomingList[index].amount,
                                                                noOfTransfers: upcomingList[index].noOfTransfers,
                                                                reference: upcomingList[index].reference,
                                                                scheduleType: upcomingList[index].scheduleType,
                                                                tabID: current,
                                                                billerImage: upcomingList[index].billerImage
                                                            )));
                                                      },
                                                    ),
                                                    if(upcomingList.length-1 != index)
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 16 , right: 16),
                                                        child: Divider(
                                                          height: 0,
                                                          thickness: 1,
                                                          color: colors(context).greyColor100,
                                                        ),
                                                      )
                                                  ],
                                                );
                                                
                                              })
                                    ),
                        ),
                      ),
                    )
                        :SizedBox.shrink()
                        :
                    AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("completed")
                        ?
                    _isCompletedAvaolable == true
                        ?
                    Expanded(
                      child: SingleChildScrollView(
                        key: Key("q"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,),
                                          child:  ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                                  itemCount: completedList.length,
                                                  itemBuilder:
                                                      (context, int index) {
                                                    return Column(
                                                      children: [
                                                        SchedulingWidget(
                                                          initialName:  completedList[index].billerName,
                                                          accountName: completedList[index].billerName,
                                                          accountNumber: completedList[index].collectionAccount,
                                                          amount: completedList[index].amount.toString().withThousandSeparator(),
                                                          icon: completedList[index].billerImage,
                                                          tranType: completedList[index].tranType ?? "",
                                                          onTap: (){
                                                            Navigator.pushNamed(
                                                                context,
                                                                Routes.kBPSchedulingSummary,
                                                                arguments: ScheduleBillPaymentArgs(BillerEntity(
                                                                    billerName: completedList[index].billerName,
                                                                    collectionAccount: completedList[index].collectionAccount,
                                                                    startDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(completedList[index].startDate!)),
                                                                    endDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(completedList[index].endDate!)),
                                                                    frequency: completedList[index].frequency,
                                                                    payFromName: completedList[index].payFromName,
                                                                    payFromNum: completedList[index].payFromNum,
                                                                    scheduleID: completedList[index].scheduleID,
                                                                    amount: completedList[index].amount,
                                                                    noOfTransfers: completedList[index].noOfTransfers,
                                                                    reference: completedList[index].reference,
                                                                    scheduleType: completedList[index].scheduleType,
                                                                    tabID: current,
                                                                  billerImage: completedList[index].billerImage
                                                                )));
                                                          },
                                                        ),
                                                        if(completedList.length-1 != index)
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 16 , right: 16),
                                                            child: Divider(
                                                              height: 0,
                                                              thickness: 1,
                                                              color: colors(context).greyColor100,
                                                            ),
                                                          )
                                                      ],
                                                    );
                                                    
                                                  })
                                        ),
                        ),
                      ),
                    )
                        :SizedBox.shrink()
                        :
                    _isdeletedAvaolable == true
                        ?
                    Expanded(
                      child: SingleChildScrollView(
                        key: Key("r"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor,),
                              child:  ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                      itemCount: deletedList.length,
                                      itemBuilder:
                                          (context, int index) {
                                        return Column(
                                          children: [
                                            SchedulingWidget(
                                              initialName: deletedList[index].billerName,
                                              accountName: deletedList[index].billerName,
                                              accountNumber: deletedList[index].collectionAccount,
                                              amount: deletedList[index].amount.toString().withThousandSeparator(),
                                              icon: deletedList[index].billerImage,
                                              tranType: deletedList[index].tranType ?? "",
                                              onTap: (){
                                                Navigator.pushNamed(
                                                    context,
                                                    Routes.kBPSchedulingSummary,
                                                    arguments: ScheduleBillPaymentArgs(BillerEntity(
                                                        billerName: deletedList[index].billerName,
                                                        collectionAccount: deletedList[index].collectionAccount,
                                                        startDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(deletedList[index].startDate!)),
                                                        endDate: DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(deletedList[index].endDate!)),
                                                        frequency: deletedList[index].frequency,
                                                        payFromName: deletedList[index].payFromName,
                                                        payFromNum: deletedList[index].payFromNum,
                                                        scheduleID: deletedList[index].scheduleID,
                                                        amount: deletedList[index].amount,
                                                        noOfTransfers: deletedList[index].noOfTransfers,
                                                        reference: deletedList[index].reference,
                                                        scheduleType: deletedList[index].scheduleType,
                                                        tabID: current,
                                                        billerImage: deletedList[index].billerImage
                                                    )));
                                              },
                                            ),
                                            if(deletedList.length-1 != index)
                                              Padding(
                                                        padding: const EdgeInsets.only(left: 16 , right: 16),
                                                        child: Divider(
                                                          height: 0,
                                                          thickness: 1,
                                                          color: colors(context).greyColor100,
                                                        ),
                                                      )
                                          ],
                                        );
                                      })
                            ),
                        ),
                      ),
                    )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
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
