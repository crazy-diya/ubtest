import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/fund_transfer_entity.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';

import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/scheduling_widget.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../../core/service/dependency_injection.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/model/bank_icons.dart';
import '../../../../../utils/navigation_routes.dart';


import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../fund_transfer/data/fund_transfer_args.dart';

class FundTransferSchedulingView extends BaseView {
  FundTransferSchedulingView({Key? key}) : super(key: key);

  @override
  _FundTransferSchedulingViewState createState() =>
      _FundTransferSchedulingViewState();
}

class _FundTransferSchedulingViewState
    extends BaseViewState<FundTransferSchedulingView> {
  var bloc = injection<FTViewSchedulingBloc>();
  final fundTransferEntity = FundTransferEntity();
  List<FundTransferEntity> ongoingList = [];
  List<FundTransferEntity> upcomingList = [];
  List<FundTransferEntity> completedList = [];
  List<FundTransferEntity> deletedList = [];

  List<bool> expansionStates = List.generate(
      100, (index) => false); // Initial expansion state for each item
  List<bool> expansionUpcomingStates = List.generate(
      100, (index) => false); // Initial expansion state for each item
  List<bool> expansionCompletedgStates = List.generate(
      100, (index) => false); // Initial expansion state for each item
  List<bool> expansionDeletedStates = List.generate(
      100, (index) => false); // Initial expansion state for each item

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
      // bloc.add(GetAccountInquiryEvent());
      bloc.add(
          GetAllScheduleFTEvent(messageType: "scheduleFtReq", txnType: "FT"));
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title:  AppLocalizations.of(context).translate("scheduled_fund_transfers")),
      body: BlocProvider<FTViewSchedulingBloc>(
        create: (_) => bloc,
        child: BlocListener<FTViewSchedulingBloc,
            BaseState<FTViewSchedulingState>>(
          listener: (_, state) {
            if (state is DeleteSchedulingFTSuccessState) {
              Navigator.pop(context, Routes.kFundTransferSchedulingView);
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("schedule_delete_des"), ToastStatus.SUCCESS);
            }
            if (state is DeleteSchedulingFTFailState) {
              ToastUtils.showCustomToast(
                  context, state.errorMessage ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
            if (state is GetAllScheduleFTSuccessState) {
              setState(() {
                ongoingList.clear();
                ongoingList.addAll(state.ongoingScheduleDetailsDtos!
                    .map((e) => FundTransferEntity(
                        payToacctnmbr: e.toAccountNo,
                        payToacctname: e.toAccountName,
                        startDate: e.startDate.toString(),
                        scheduleFrequency: e.frequency,
                        endDate: e.endDate.toString(),
                        amount: e.amount!,
                        transactionCategory: e.transCategory,
                        beneficiaryMobile: e.beneficiaryMobile,
                        beneficiaryEmail: e.beneficiaryEmail,
                        scheduleType: e.scheduleType,
                        payFromNum: e.fromAccountNo,
                        payFromName: e.fromAccountName,
                        scheduleId: e.scheduleId,
                        reference: e.reference,
                        tranType: e.tranType,
                        bankCode: int.parse(e.toBankCode ?? "0"),
                        icon: bankIcons.firstWhere((element) => element.bankCode == (e.toBankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                upcomingList.clear();
                upcomingList.addAll(state.upcomingScheduleDetailsDtos!
                    .map((e) => FundTransferEntity(
                        payToacctnmbr: e.toAccountNo,
                        payToacctname: e.toAccountName,
                        startDate: e.startDate.toString(),
                        scheduleFrequency: e.frequency,
                        endDate: e.endDate.toString(),
                        amount: e.amount!,
                        transactionCategory: e.transCategory,
                        beneficiaryMobile: e.beneficiaryMobile,
                        beneficiaryEmail: e.beneficiaryEmail,
                        scheduleType: e.scheduleType,
                        payFromNum: e.fromAccountNo,
                        payFromName: e.fromAccountName,
                        scheduleId: e.scheduleId,
                        reference: e.reference,
                    tranType: e.tranType,
                    bankCode: int.parse(e.toBankCode ?? "0"),
                    icon: bankIcons.firstWhere((element) => element.bankCode == (e.toBankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                completedList.clear();
                completedList.addAll(state.completedScheduleDetailsDtos!
                    .map((e) => FundTransferEntity(
                        payToacctnmbr: e.toAccountNo,
                        payToacctname: e.toAccountName,
                        startDate: e.startDate.toString(),
                        scheduleFrequency: e.frequency,
                        endDate: e.endDate.toString(),
                        amount: e.amount!,
                        transactionCategory: e.transCategory,
                        beneficiaryMobile: e.beneficiaryMobile,
                        beneficiaryEmail: e.beneficiaryEmail,
                        scheduleType: e.scheduleType,
                        payFromNum: e.fromAccountNo,
                        payFromName: e.fromAccountName,
                        scheduleId: e.scheduleId,
                        reference: e.reference,
                    tranType: e.tranType,
                    bankCode: int.parse(e.toBankCode ?? "0"),
                    icon: bankIcons.firstWhere((element) => element.bankCode == (e.toBankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
                        noOfTransfers: e.noOfTransfers.toString()))
                    .toList());
                deletedList.clear();
                deletedList.addAll(state.deletedScheduleDetailsDtos!
                    .map((e) => FundTransferEntity(
                        payToacctnmbr: e.toAccountNo,
                        payToacctname: e.toAccountName,
                        startDate: e.startDate.toString(),
                        scheduleFrequency: e.frequency,
                        endDate: e.endDate.toString(),
                        amount: e.amount!,
                        transactionCategory: e.transCategory,
                        beneficiaryMobile: e.beneficiaryMobile,
                        beneficiaryEmail: e.beneficiaryEmail,
                        scheduleType: e.scheduleType,
                        payFromNum: e.fromAccountNo,
                        payFromName: e.fromAccountName,
                        scheduleId: e.scheduleId,
                        reference: e.reference,
                    tranType: e.tranType,
                    bankCode: int.parse(e.toBankCode ?? "0"),
                    icon: bankIcons.firstWhere((element) => element.bankCode == (e.toBankCode ?? AppConstants.ubBankCode.toString()),orElse: () => BankIcon() ,).icon,
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
                        child: Row(
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
                              child:  ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                          itemCount: ongoingList.length,
                                          itemBuilder: (context, int index) {
                                            return Column(
                                              children: [
                                                SchedulingWidget(
                                                  initialName: ongoingList[index].payToacctname,
                                                  accountName: ongoingList[index].payToacctname,
                                                  accountNumber: ongoingList[index].payToacctnmbr ?? "",
                                                  amount: ongoingList[index].amount.toString().withThousandSeparator(),
                                                  icon: ongoingList[index].icon,
                                                  tranType: ongoingList[index].tranType,
                                                  onTap: (){
                                                    Navigator.pushNamed(context, Routes.kFTSchedulingSummary , arguments:
                                                    FundTransferArgs(FundTransferEntity(
                                                        payToacctname: ongoingList[index].payToacctname,
                                                        payToacctnmbr: ongoingList[index].payToacctnmbr,
                                                        scheduleType: ongoingList[index].scheduleType,
                                                        scheduleFrequency :ongoingList[index].scheduleFrequency,
                                                        transactionCategory :ongoingList[index].transactionCategory,
                                                        startDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(ongoingList[index].startDate!)),
                                                        endDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(ongoingList[index].endDate!)),
                                                        amount :ongoingList[index].amount,
                                                        beneficiaryEmail: ongoingList[index].beneficiaryEmail,
                                                        beneficiaryMobile: ongoingList[index].beneficiaryMobile,
                                                        payFromNum : ongoingList[index].payFromNum,
                                                        payFromName : ongoingList[index].payFromName,
                                                        scheduleId: ongoingList[index].scheduleId,
                                                        noOfTransfers: ongoingList[index].noOfTransfers,
                                                        reference : ongoingList[index].reference,
                                                      bankCode: ongoingList[index].bankCode,
                                                      tabID: current
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
                        :SizedBox.shrink()
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
                                color: colors(context).whiteColor,
                              ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                          physics: NeverScrollableScrollPhysics(),
                                              itemCount: upcomingList.length,
                                              itemBuilder: (context, int index) {
                                                return Column(
                                                  children: [
                                                    SchedulingWidget(
                                                      initialName: upcomingList[index].payToacctname,
                                                      accountName: upcomingList[index].payToacctname,
                                                      accountNumber: upcomingList[index].payToacctnmbr ?? "",
                                                      amount: upcomingList[index].amount.toString().withThousandSeparator(),
                                                      icon: upcomingList[index].icon,
                                                      tranType: upcomingList[index].tranType,
                                                      onTap: (){
                                                        Navigator.pushNamed(context, Routes.kFTSchedulingSummary , arguments:
                                                        FundTransferArgs(FundTransferEntity(
                                                            payToacctname: upcomingList[index].payToacctname,
                                                            payToacctnmbr: upcomingList[index].payToacctnmbr,
                                                            scheduleType: upcomingList[index].scheduleType,
                                                            scheduleFrequency :upcomingList[index].scheduleFrequency,
                                                            transactionCategory :upcomingList[index].transactionCategory,
                                                            startDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(upcomingList[index].startDate!)),
                                                            endDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(upcomingList[index].endDate!)),
                                                            amount :upcomingList[index].amount,
                                                            beneficiaryEmail: upcomingList[index].beneficiaryEmail,
                                                            beneficiaryMobile: upcomingList[index].beneficiaryMobile,
                                                            payFromNum : upcomingList[index].payFromNum,
                                                            payFromName : upcomingList[index].payFromName,
                                                            scheduleId: upcomingList[index].scheduleId,
                                                            noOfTransfers: upcomingList[index].noOfTransfers,
                                                            reference : upcomingList[index].reference,
                                                            bankCode: upcomingList[index].bankCode,
                                                            tabID: current
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
                                color: colors(context).whiteColor,
                              ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                                  itemCount: completedList.length,
                                                  itemBuilder:
                                                      (context, int index) {
                                                    return Column(
                                                      children: [
                                                        SchedulingWidget(
                                                          initialName: completedList[index].payToacctname,
                                                          accountName: completedList[index].payToacctname,
                                                          accountNumber: completedList[index].payToacctnmbr ?? "",
                                                          amount: completedList[index].amount.toString().withThousandSeparator(),
                                                          icon: completedList[index].icon,
                                                          tranType: completedList[index].tranType,
                                                          onTap: (){
                                                            Navigator.pushNamed(context, Routes.kFTSchedulingSummary , arguments:
                                                            FundTransferArgs(FundTransferEntity(
                                                                payToacctname: completedList[index].payToacctname,
                                                                payToacctnmbr: completedList[index].payToacctnmbr,
                                                                scheduleType: completedList[index].scheduleType,
                                                                scheduleFrequency :completedList[index].scheduleFrequency,
                                                                transactionCategory :completedList[index].transactionCategory,
                                                                startDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(completedList[index].startDate!)),
                                                                endDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(completedList[index].endDate!)),
                                                                amount :completedList[index].amount,
                                                                beneficiaryEmail: completedList[index].beneficiaryEmail,
                                                                beneficiaryMobile: completedList[index].beneficiaryMobile,
                                                                payFromNum : completedList[index].payFromNum,
                                                                payFromName : completedList[index].payFromName,
                                                                scheduleId: completedList[index].scheduleId,
                                                                noOfTransfers: completedList[index].noOfTransfers,
                                                                reference : completedList[index].reference,
                                                                bankCode: completedList[index].bankCode,
                                                                icon: completedList[index].icon,
                                                                tabID: current
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
                                                            color: colors(context).whiteColor,
                                                          ),
                                          child:ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                                  itemCount: deletedList.length,
                                                  itemBuilder:
                                                      (context, int index) {
                                                    return Column(
                                                      children: [
                                                        SchedulingWidget(
                                                          initialName:  deletedList[index].payToacctname,
                                                          accountName: deletedList[index].payToacctname,
                                                          accountNumber: deletedList[index].payToacctnmbr ?? "",
                                                          amount: deletedList[index].amount.toString().withThousandSeparator(),
                                                          icon: deletedList[index].icon,
                                                          tranType: deletedList[index].tranType,
                                                          onTap: (){
                                                            Navigator.pushNamed(context, Routes.kFTSchedulingSummary , arguments:
                                                            FundTransferArgs(FundTransferEntity(
                                                                payToacctname: deletedList[index].payToacctname,
                                                                payToacctnmbr: deletedList[index].payToacctnmbr,
                                                                scheduleType: deletedList[index].scheduleType,
                                                                scheduleFrequency :deletedList[index].scheduleFrequency,
                                                                transactionCategory :deletedList[index].transactionCategory,
                                                                startDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(deletedList[index].startDate!)),
                                                                endDate : DateFormat('d MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(deletedList[index].endDate!)),
                                                                amount :deletedList[index].amount,
                                                                beneficiaryEmail: deletedList[index].beneficiaryEmail,
                                                                beneficiaryMobile: deletedList[index].beneficiaryMobile,
                                                                payFromNum : deletedList[index].payFromNum,
                                                                payFromName : deletedList[index].payFromName,
                                                                scheduleId: deletedList[index].scheduleId,
                                                                noOfTransfers: deletedList[index].noOfTransfers,
                                                                reference : deletedList[index].reference,
                                                                bankCode: deletedList[index].bankCode,
                                                                tabID: current
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
                        :SizedBox.shrink(),
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
