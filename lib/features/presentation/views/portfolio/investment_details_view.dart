import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/portfolio_card.dart';
import '../../../../../utils/app_extensions.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';

class InvestmentDetailsArgs {
  final String? depositAmount;
  final String? category;
  final String? accountNumber;
  final String? balance;
  final String? fdType;
  final String? interestrate;
  final String? tenure;

  final String? openingDate;
  final String? lastRenewaldate;
  final String? maturityDate;
  final String? currency;

  InvestmentDetailsArgs({
    this.depositAmount,
    this.category,
    this.accountNumber,
    this.balance,
    this.fdType,
    this.interestrate,
    this.tenure,
    this.openingDate,
    this.lastRenewaldate,
    this.maturityDate,
    this.currency,
  });
}

class PortfolioInvestmentDetailsView extends BaseView {
  final InvestmentDetailsArgs investmentDetailsArgs;

  PortfolioInvestmentDetailsView({required this.investmentDetailsArgs});

  @override
  _PortfolioInvestmentDetailsViewState createState() =>
      _PortfolioInvestmentDetailsViewState();
}

class _PortfolioInvestmentDetailsViewState
    extends BaseViewState<PortfolioInvestmentDetailsView> {
  var bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("investment_details")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h),
                child: Column(
                  children: [
                    // UBPortfolioContainerDefaultColored(
                    //   title: widget.investmentDetailsArgs.category!,
                    //   amount: widget.investmentDetailsArgs.depositAmount.toString().withThousandSeparator(),
                    //   subTitle: widget.investmentDetailsArgs.accountNumber!,
                    //   category: 'investments',
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).w,
                        child: PortfolioCard(
                          design: ManagePayDesign(
                              backgroundColor: colors(context).primaryColor200!,
                              fontColor: colors(context).blackColor!,
                              dividerColor: colors(context).primaryColor300!
                          ),
                          nickName: widget.investmentDetailsArgs.category?.trimLeft(),
                          accountNumber: widget.investmentDetailsArgs.accountNumber,
                          maturityDate: widget.investmentDetailsArgs.maturityDate.toString().isDate() == true
                              ? DateFormat('dd-MMM-yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                            widget.investmentDetailsArgs.maturityDate.toString(),
                          )) : widget.investmentDetailsArgs.maturityDate.toString(),
                          tenure: widget.investmentDetailsArgs.tenure,
                          availableBalance: widget.investmentDetailsArgs.balance.toString(),
                          currency: widget.investmentDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                          actualBalance: widget.investmentDetailsArgs.interestrate,
                          cardType: "Investments",
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w , right: 16.w),
                        child: Column(
                          children: [
                            FTSummeryDataComponent(
                              title: AppLocalizations.of(context).translate("opening_date"),
                              data: widget.investmentDetailsArgs.openingDate.toString().isDate()==true? DateFormat('dd-MMM-yyyy')
                                  .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                widget.investmentDetailsArgs.openingDate!,
                              )):widget.investmentDetailsArgs.openingDate.toString(),
                            ),
                            FTSummeryDataComponent(
                              title: AppLocalizations.of(context).translate("last_renewal_date"),
                              data: widget.investmentDetailsArgs.lastRenewaldate.toString().isDate()==true? DateFormat('dd-MMM-yyyy')
                                  .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                widget.investmentDetailsArgs.lastRenewaldate!,
                              )):widget.investmentDetailsArgs.lastRenewaldate.toString(),
                              isLastItem: true,
                            ),
                            // FTSummeryDataComponent(
                            //   title: "Maturity Date",
                            //   data: widget.investmentDetailsArgs.maturityDate.toString().isDate()? DateFormat('dd-MMM-yyyy')
                            //       .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                            //     widget.investmentDetailsArgs.maturityDate!,
                            //   )):widget.investmentDetailsArgs.maturityDate.toString(),
                            //   isLastItem: true,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // UBPortfolioDetails(
                    //   title: 'Interest Rate',
                    //   subTitle: "${widget.investmentDetailsArgs.interestrate!}%",
                    // ),
                    // UBPortfolioDetails(
                    //   title: 'Tenure',
                    //   subTitle: widget.investmentDetailsArgs.tenure!,
                    // ),
                    // UBPortfolioDetails(
                    //   title: 'Opening Date',
                    //   subTitle:widget.investmentDetailsArgs.openingDate.toString().isDate()==true? DateFormat('dd-MMM-yyyy')
                    //       .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                    //     widget.investmentDetailsArgs.openingDate!,
                    //   )):widget.investmentDetailsArgs.openingDate.toString(),
                    // ),
                    // UBPortfolioDetails(
                    //   title: 'Last Renewal Date',
                    //   subTitle:widget.investmentDetailsArgs.lastRenewaldate.toString().isDate()==true? DateFormat('dd-MMM-yyyy')
                    //       .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                    //     widget.investmentDetailsArgs.lastRenewaldate!,
                    //   )):widget.investmentDetailsArgs.lastRenewaldate.toString(),
                    // ),
                    // UBPortfolioDetails(
                    //   title: 'Maturity Date',
                    //   subTitle:widget.investmentDetailsArgs.maturityDate.toString().isDate()? DateFormat('dd-MMM-yyyy')
                    //       .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                    //     widget.investmentDetailsArgs.maturityDate!,
                    //   )):widget.investmentDetailsArgs.maturityDate.toString(),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
