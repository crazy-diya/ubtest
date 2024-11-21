import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/loan_payment_history.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/portfolio_card.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_bottom_container.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_extensions.dart';


import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';

class LoanDetailsArgs{
  final String? capitalOutstanding;
  final String? loanTitle;
  final String? loanAmount;
  final String? loanNumber;
  final String? branch;
  final String? nextInstallmentAmount;
  final String? nextPaymentdate;
  final String? totalArrears;
  final String? maturityDate;
  final String? tenure;
  final String? interestType;
  final String? currentIntRate;
  final String? facilityAmount;
  final String? currency;




  LoanDetailsArgs(
      {this.capitalOutstanding,
      this.nextInstallmentAmount,
      this.nextPaymentdate,
      this.totalArrears,
      this.maturityDate,
        this.loanTitle,
        this.interestType,
        this.currentIntRate,
        this. loanAmount,
        this. loanNumber,
        this. branch,
        this.facilityAmount,
        this.currency,
      this.tenure});
}

class PortfolioloanDetailsView extends BaseView {
  final LoanDetailsArgs loanDetailsArgs;
  PortfolioloanDetailsView({required this.loanDetailsArgs});

  @override
  _PortfolioloanDetailsViewState createState() =>
      _PortfolioloanDetailsViewState();
}

class _PortfolioloanDetailsViewState
    extends BaseViewState<PortfolioloanDetailsView> {
  var bloc = injection<SplashBloc>();


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("loan_details")),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,0.h),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0.h , bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0).w,
                          child: PortfolioCard(
                            design: ManagePayDesign(
                                backgroundColor: colors(context).greyColor!,
                                fontColor: colors(context).whiteColor!,
                                dividerColor: colors(context).greyColor300!
                            ),
                            nickName: widget.loanDetailsArgs.loanTitle?.trimLeft()?? "",
                            accountNumber: widget.loanDetailsArgs.loanNumber,
                            // maturityDate: invList[index].maturityDate.toString().isDate() == true
                            //     ? DateFormat('dd-MMM-yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                            //   invList[index].maturityDate.toString(),
                            // )) : invList[index].maturityDate.toString(),
                            tenure: widget.loanDetailsArgs.tenure,
                            availableBalance: widget.loanDetailsArgs.capitalOutstanding,
                            actualBalance: widget.loanDetailsArgs.tenure,
                            currency: widget.loanDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                            cardType: "Loans",
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      // UBPortfolioContainerDefaultColored(
                      //   title: widget.loanDetailsArgs.loanTitle!,
                      //   amount: widget.loanDetailsArgs.loanAmount!
                      //       .withThousandSeparator(),
                      //   subTitle: widget.loanDetailsArgs.loanNumber!,
                      //   category: 'loan',
                      // ),
                      // const SizedBox(height: 25,),
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
                                title: AppLocalizations.of(context).translate("loan_value_granted"),
                                isCurrency: true,
                                currencyType: widget.loanDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                                amount: double.parse(widget.loanDetailsArgs.facilityAmount!.replaceAll("", "")),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("capital_outstanding"),
                                isCurrency: true,
                                currencyType: widget.loanDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                                amount: double.parse(widget.loanDetailsArgs.capitalOutstanding!.replaceAll("", "")),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("instalment_amount"),
                                isCurrency: true,
                                currencyType: widget.loanDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                                amount: double.parse(widget.loanDetailsArgs.nextInstallmentAmount!.replaceAll("", "")),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("next_payment_date"),
                                data: widget.loanDetailsArgs.nextPaymentdate == null || widget.loanDetailsArgs.nextPaymentdate == "" ? "-":
                                DateFormat("dd-MMM-yyyy").format(DateTime.parse(widget.loanDetailsArgs.nextPaymentdate ?? "-"))
                                // widget.loanDetailsArgs.nextPaymentdate.toString().isDate() == true ? DateFormat('dd-MMM-yyyy').format(
                                //     DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                //       widget.loanDetailsArgs.nextPaymentdate.toString(),
                                //     )):"0000-00-00",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("total_arrears"),
                                data: widget.loanDetailsArgs.totalArrears!.withThousandSeparator(),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("maturity_date"),
                                data:widget.loanDetailsArgs.maturityDate == null || widget.loanDetailsArgs.maturityDate == "" ? "-" :
                                DateFormat("dd-MMM-yyyy").format(DateTime.parse(widget.loanDetailsArgs.maturityDate ?? "-"))
                                // widget.loanDetailsArgs.maturityDate.toString().isDate() == true ?DateFormat('dd-MMM-yyyy').format(
                                //     DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                //       widget.loanDetailsArgs.maturityDate.toString(),
                                //     )):"0000-00-00",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("tenure_m"),
                                data: widget.loanDetailsArgs.tenure!,
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("interest_type"),
                                data: widget.loanDetailsArgs.interestType??"",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("current_rates"),
                                data:"${widget.loanDetailsArgs.currentIntRate.toString()}%",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("loan_granting_branch"),
                                data: widget.loanDetailsArgs.branch!,
                                isLastItem: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // UBPortfolioDetails(
                      //   title: 'Loan Value Granted',
                      //   isCurrency: true,
                      //   amount: widget.loanDetailsArgs.loanAmount!.withThousandSeparator(),
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Capital Outstanding',
                      //   isCurrency: true,
                      //   amount: widget.loanDetailsArgs.capitalOutstanding!.withThousandSeparator(),
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Instalment Amount',
                      //   isCurrency: true,
                      //   amount:  widget.loanDetailsArgs.nextInstallmentAmount!.withThousandSeparator(),
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Next Payment Date',
                      //
                      //   subTitle:widget.loanDetailsArgs.nextPaymentdate.toString().isDate() == true ? DateFormat('dd-MMM-yyyy').format(
                      //       DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                      //         widget.loanDetailsArgs.nextPaymentdate.toString(),
                      //       )):"0000-00-00",
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Total Arrears',
                      //
                      //   subTitle: widget.loanDetailsArgs.totalArrears!.withThousandSeparator(),
                      // ), UBPortfolioDetails(
                      //   title: 'Maturity Date',
                      //
                      //   subTitle:widget.loanDetailsArgs.maturityDate.toString().isDate() == true ?DateFormat('dd-MMM-yyyy').format(
                      //       DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                      //         widget.loanDetailsArgs.maturityDate.toString(),
                      //       )):"0000-00-00",
                      // ),UBPortfolioDetails(
                      //   title: 'Tenure',
                      //
                      //   subTitle: widget.loanDetailsArgs.tenure!,
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Interest Type',
                      //
                      //   subTitle: widget.loanDetailsArgs.interestType??"",
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Current Interest Rate',
                      //   subTitle:
                      //       "${widget.loanDetailsArgs.currentIntRate.toString()}%",
                      // ),
                      // UBPortfolioDetails(
                      //   title: 'Loan Granting Branch',
                      //   subTitle: widget.loanDetailsArgs.branch!,
                      // ),
                      16.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w , right: 16.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kPortfolioLoanPaymentHistoryView,
                                  arguments: LoanDetailsHistoryArgs(
                                    loanTitle: widget.loanDetailsArgs.loanTitle,
                                    loanAmount: widget.loanDetailsArgs.loanAmount,
                                    loanNumber: widget.loanDetailsArgs.loanNumber,
                                    currency: widget.loanDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                                  ));
                            },
                            child: UBPortfolioBottomContainer(
                              title: AppLocalizations.of(context)
                                  .translate("loan_payment_history"),
                              icon: PhosphorIcon(PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.bold),
                                  color: colors(context).primaryColor),
                              isLastItem: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
