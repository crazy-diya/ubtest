import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/fund_transfer_data_component_2.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/scheduling_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/model/bank_icons.dart';
import '../../../../domain/entities/response/fund_transfer_entity.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../base_view.dart';
import '../../fund_transfer/data/fund_transfer_args.dart';

class FundTransferHistoryView extends BaseView {
  final FundTransferArgs fundTransferArgs;

  FundTransferHistoryView({required this.fundTransferArgs});

  @override
  _FundTransferHistoryViewState createState() =>
      _FundTransferHistoryViewState();
}

class _FundTransferHistoryViewState
    extends BaseViewState<FundTransferHistoryView> {
  var bloc = injection<FTViewSchedulingBloc>();
  final fundTransferEntity = FundTransferEntity();

  int? size;

  int pageNumberTran = 0;

  late final _scrollControllerTran = ScrollController();

  List<FundTransferEntity> tranHistoryList = [];

  @override
  void initState() {
    super.initState();
    _scrollControllerTran.addListener(_onScrollTran);
    _loadInitialData();
  }

  void _loadInitialData() {
    bloc.add(ScheduleFTHistoryEvent(
      size: 20,
      page: pageNumberTran,
      scheduleId: widget.fundTransferArgs.fundTransferEntity.scheduleId,
      messageType: "scheduleFtReq",
      txnType: "FT",
    ));
  }

  void _onScrollTran() {
    if(size != tranHistoryList.length){
      final maxScroll = _scrollControllerTran.position.maxScrollExtent;
      final currentScroll = _scrollControllerTran.position.pixels;
      if (maxScroll - currentScroll == 0) {
        pageNumberTran++;
        bloc.add(ScheduleFTHistoryEvent(
          size: 20,
          page: pageNumberTran,
          scheduleId: widget.fundTransferArgs.fundTransferEntity.scheduleId,
          messageType: "scheduleFtReq",
          txnType: "FT",
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
        child: BlocListener<FTViewSchedulingBloc,
            BaseState<FTViewSchedulingState>>(
          bloc: bloc,
          listener: (_, state) {
            if (state is SchedulingFTHistorySuccessState) {
              size = state.scheduleFtHistoryResponse!.count;
              // print(state.schFundTransferHistoryResponseTempDtoList?.length);
              // print(size);
              // print("@@@@@@@@@@@@@###########");
              // print("@@@@@@@@@@@@@###########");
              // print("@@@@@@@@@@@@@###########");
              // print("@@@@@@@@@@@@@###########");
              // print("@@@@@@@@@@@@@###########");
              fundTransferEntity.payFromName =
                  state.scheduleFtHistoryResponse!.paidFromName;
              fundTransferEntity.payFromNum =
                  state.scheduleFtHistoryResponse!.paidFrom;
              fundTransferEntity.payToacctname =
                  state.scheduleFtHistoryResponse!.paidToName;
              fundTransferEntity.payToacctnmbr =
                  state.scheduleFtHistoryResponse!.paidTo;
              fundTransferEntity.transactionCategory =
                  state.scheduleFtHistoryResponse!.scheduleTitle;
              fundTransferEntity.amount =
                  state.scheduleFtHistoryResponse!.amount;
              fundTransferEntity.bankCodePayFrom = int.parse(
                  state.scheduleFtHistoryResponse!.fromBankCode ?? "0");
              fundTransferEntity.bankCode =
                  int.parse(state.scheduleFtHistoryResponse!.toBankCode ?? "0");
              fundTransferEntity.icon = bankIcons
                  .firstWhere(
                    (element) =>
                        element.bankCode ==
                        (state.scheduleFtHistoryResponse!.toBankCode ??
                            AppConstants.ubBankCode),
                    orElse: () => BankIcon(),
                  )
                  .icon;
              fundTransferEntity.iconPayFrom = bankIcons
                  .firstWhere(
                    (element) =>
                        element.bankCode ==
                        (state.scheduleFtHistoryResponse!.fromBankCode ??
                            AppConstants.ubBankCode),
                    orElse: () => BankIcon(),
                  )
                  .icon;
              tranHistoryList.addAll(state
                  .schFundTransferHistoryResponseTempDtoList!
                  .map((e) =>
                  FundTransferEntity(
                      startDate: e.date.toString(),
                  remark: e.status ,
                  scheduleAmount: e.scheduleAmount)).toList());
              setState(() {});
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              24.h,
              20.w,
              0.h ,
            ),
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
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 20.h, 0, 0),
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Pay_From"),
                                    style: size14weight700.copyWith(
                                        color: colors(context).blackColor)),
                              ),
                              SchedulingWidget(
                                initialName: fundTransferEntity.payFromName,
                                width: 64,
                                height: 64,
                                tranType: "FT",
                                accountName: fundTransferEntity.payFromName,
                                accountNumber:
                                    fundTransferEntity.payFromNum,
                                amount:
                                    fundTransferEntity.amount.toString(),
                                icon: fundTransferEntity.iconPayFrom,
                                isAmountAvailable: false,
                                onTap: () {},
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
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 16.h, 0, 0),
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Pay_To"),
                                    style: size14weight700.copyWith(
                                        color: colors(context).blackColor)),
                              ),
                              SchedulingWidget(
                                width: 64,
                                height: 64,
                                tranType: "FT",
                                initialName: fundTransferEntity.payToacctname,
                                accountName:
                                    fundTransferEntity.payToacctname,
                                accountNumber:
                                    fundTransferEntity.payToacctnmbr,
                                amount:
                                    fundTransferEntity.amount.toString(),
                                icon: fundTransferEntity.icon,
                                isAmountAvailable: false,
                                onTap: () {},
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
                              padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context) ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: tranHistoryList.length,
                                    itemBuilder: (context, int index) {
                                      return FTSummeryDataComponent2(
                                        title: tranHistoryList[index].remark ??
                                            "-",
                                        subTitle: widget.fundTransferArgs
                                                .fundTransferEntity.reference ??
                                            "-",
                                        data: tranHistoryList[index].scheduleAmount.toString().withThousandSeparator(),
                                            // fundTransferEntity.amount.toString(),
                                        subData: DateFormat('dd-MMMM-yyyy HH:mm')
                                            .format(DateFormat(
                                                    'yyyy-MM-dd HH:mm:ss.SSSZ')
                                                .parse(tranHistoryList[index]
                                                    .startDate!)),
                                        isLastItem:
                                            (tranHistoryList.length - 1) == index,
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
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
