import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/fund_transfer_data_component_2.dart';
import 'package:union_bank_mobile/features/presentation/views/schedule/schedule_bill_payment/widgets/bill_payment_schedule_args.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/model/bank_icons.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../base_view.dart';
import '../../fund_transfer/widgets/scheduling_widget.dart';


class BillPaymentHistoryView extends BaseView {
  final ScheduleBillPaymentArgs scheduleBillPaymentArgs;


  BillPaymentHistoryView({required this.scheduleBillPaymentArgs});

  @override
  _BillPaymentHistoryViewState createState() =>
      _BillPaymentHistoryViewState();
}

class _BillPaymentHistoryViewState
    extends BaseViewState<BillPaymentHistoryView> {
  var bloc = injection<FTViewSchedulingBloc>();
  BillerEntity billPaymentEntity = BillerEntity();
  List<BillerEntity> billHistoryList = [];

  int? size;

  int pageNumberTran = 0;

  late final _scrollControllerTran = ScrollController();

  int currentPage = 1;
  int itemsPerPage = 2;


  @override
  void initState() {
    super.initState();
    _scrollControllerTran.addListener(_onScrollTran);
    _loadInitialData();
  }

  void _loadInitialData() {
    bloc.add(ScheduleFTHistoryEvent(size: 20, page: pageNumberTran,
      scheduleId: widget.scheduleBillPaymentArgs.billerEntity.scheduleID,
      messageType: "scheduleFtReq",
      txnType: "BP" ,
    ));
  }
  void _onScrollTran() {
    if(size != billHistoryList.length){
      final maxScroll = _scrollControllerTran.position.maxScrollExtent;
      final currentScroll = _scrollControllerTran.position.pixels;
      if (maxScroll - currentScroll == 0) {
        pageNumberTran++;
        bloc.add(ScheduleFTHistoryEvent(size: 20, page: pageNumberTran,
          scheduleId: widget.scheduleBillPaymentArgs.billerEntity.scheduleID,
          messageType: "scheduleFtReq",
          txnType: "BP" ,
        ));
      }
    }
  }

  @override
  void dispose() {
    _scrollControllerTran.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        goBackEnabled: true,
        title: AppLocalizations.of(context).translate("transaction_history"),
      ),
      body: BlocProvider(
        create: (_) => bloc,
        child: BlocListener<FTViewSchedulingBloc, BaseState<FTViewSchedulingState>>(
          bloc: bloc,
          listener: (_, state) {
            if (state is SchedulingFTHistorySuccessState){
              size = state.scheduleFtHistoryResponse!.count;
              billPaymentEntity.payFromName = state.scheduleFtHistoryResponse!.paidFromName;
              billPaymentEntity.payFromNum = state.scheduleFtHistoryResponse!.paidFrom;
              billPaymentEntity.billerName = state.scheduleFtHistoryResponse!.paidToName;
              billPaymentEntity.collectionAccount = state.scheduleFtHistoryResponse!.paidTo;
              billPaymentEntity.title = state.scheduleFtHistoryResponse!.scheduleTitle;
              billPaymentEntity.amount = state.scheduleFtHistoryResponse!.amount?.toDouble();
              billPaymentEntity.fromBankCode = state.scheduleFtHistoryResponse?.fromBankCode;
              billHistoryList.addAll(state.schFundTransferHistoryResponseTempDtoList!
                  .map((e) => BillerEntity(
                  startDate: e.date.toString(),
                  statusDes: e.status,
                  scheduleAmount: e.scheduleAmount
              )).toList());
              setState(() {});
            }
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h , 20.w , 0.h),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16,16,0,0).w,
                                  child: Text(
                                      AppLocalizations.of(context).translate("Pay_From"),
                                      style: size14weight700.copyWith(color: colors(context).blackColor)
                                  ),
                                ),
                                SchedulingWidget(
                                  width: 64,
                                  height: 64,
                                  tranType: "FT",
                                  icon: bankIcons.firstWhere((element) => element.bankCode == billPaymentEntity.fromBankCode,orElse: () => BankIcon() ,).icon,
                                  accountName: billPaymentEntity.payFromName,
                                  initialName: billPaymentEntity.payFromName,
                                  accountNumber: billPaymentEntity.payFromNum,
                                  amount: billPaymentEntity.amount.toString(),
                                  isAmountAvailable: false,
                                  onTap: (){},
                                ),
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16,16,0,0).w,
                                  child: Text(
                                      AppLocalizations.of(context).translate("Pay_To"),
                                      style: size14weight700.copyWith(color: colors(context).blackColor)
                                  ),
                                ),
                                SchedulingWidget(
                                  width: 64,
                                  height: 64,
                                  initialName: billPaymentEntity.billerName,
                                  icon: widget.scheduleBillPaymentArgs.billerEntity.billerImage,
                                  accountName: billPaymentEntity.billerName,
                                  accountNumber: billPaymentEntity.collectionAccount,
                                  amount: billPaymentEntity.amount.toString(),
                                  isAmountAvailable: false,
                                  onTap: (){},
                                ),
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _scrollControllerTran,
                              physics: const ClampingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor,
                                  ),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       padding: EdgeInsets.zero,
                                      itemCount: billHistoryList.length,
                                      itemBuilder: (context, int index){
                                        if (index == billHistoryList.length) {
                                          fetchMoreData(); // Fetch more data when reaching end
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        return FTSummeryDataComponent2(
                                          isLastItem: (billHistoryList.length - 1) == index,
                                          title : billHistoryList[index].statusDes ?? "-",
                                          subTitle: billPaymentEntity.reference ?? "-",
                                          data: billHistoryList[index].scheduleAmount.toString().withThousandSeparator(),
                                          subData: DateFormat('dd-MMMM-yyyy HH:mm').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(billHistoryList[index].startDate!)),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> fetchMoreData() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Fetch data and update the billHistoryList
    for (int i = 0; i < itemsPerPage; i++) {
      billHistoryList.add(BillerEntity(
          statusDes: 'Item ${billHistoryList.length}',
          startDate: 'Item ${billHistoryList.length}'
      ));
    }

    setState(() {
      currentPage++;
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
