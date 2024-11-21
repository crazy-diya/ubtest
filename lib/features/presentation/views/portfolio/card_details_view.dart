import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/widgets/credit_card_details_entity.dart';

import 'package:union_bank_mobile/features/presentation/views/portfolio/filter_past_card_statements.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/card_transaction_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/portfolio_card.dart';

import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_bottom_container.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/models/responses/card_management/card_list_response.dart';

import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';

class CardDetailsArgs {
  final String? availableCreditLimit;
  final String? totalCreditLimit;
  final String accountNumber;
  final String? unBilledAmount;
  final String? lastPaidAmount;
  final String? minimumPaymentDue;
  final String? cardType;
  final String? paymentDueDate;
  final String? cardExpiryDate;
  final String? holderName;
  final String? cardStatus;
  final String? cardNumber;
  final String? minimumPayment;
  final String? cardHolderName;
  final String? billedTransactionValue;
  final String? outStandingBalance;
  final String? lastPaidDate;
  final String? statementDate;
  final List<CardResLast5Txn>? transaction;
  final String? utilizedBalance;
  final String? currency;
  final bool isPrimary;

  CardDetailsArgs({
    this.availableCreditLimit,
    this.totalCreditLimit,
    this.unBilledAmount,
    required this.accountNumber,
    this.lastPaidAmount,
    this.minimumPaymentDue,
    this.cardType,
    this.paymentDueDate,
    this.cardExpiryDate,
    this.holderName,
    this.cardStatus,
    this.outStandingBalance,
    this.cardNumber,
    this.billedTransactionValue,
    this.minimumPayment,
    this.lastPaidDate,
    this.cardHolderName,
    this.transaction,
    this.statementDate,
    this.utilizedBalance,
    this.currency,
    required this.isPrimary,
  });
}

class PortfolioCardDetailsView extends BaseView {
  final CardDetailsArgs cardDetailsArgs;

  PortfolioCardDetailsView({required this.cardDetailsArgs});

  @override
  _PortfolioCardDetailsViewState createState() =>
      _PortfolioCardDetailsViewState();
}

class _PortfolioCardDetailsViewState
    extends BaseViewState<PortfolioCardDetailsView> {
  final bloc = injection<CreditCardManagementBloc>();
  bool toggleValue = false;
  double utilizedBalance = 0.00;

  String obscureCardNum(String subtitle) {
    final int visibleCharacters = 4; // Number of visible characters at the end
    final int totalCharacters = subtitle.length;

    String maskedCharacters = '*' * (totalCharacters - visibleCharacters);
    String visiblePart =
        subtitle.substring(totalCharacters - visibleCharacters);

    return '$maskedCharacters$visiblePart';
  }

  CreditCardDetails? custDetails;

  @override
  void initState() {
    super.initState();
    bloc.add(GetCardDetailsEvent(
        maskedPrimaryCardNumber: widget.cardDetailsArgs.cardNumber));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("card_details")),
      body: BlocProvider<CreditCardManagementBloc>(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is GetCardDetailsSuccessState){
              if(state.resCode == "00"){
                custDetails = CreditCardDetails(
                    creditLimit: state.cardDetailsResponse?.resCreditLimit,
                    availableToSpentAmount: state.cardDetailsResponse?.resAvailableBalance,
                    lastPaymentAmount: state.cardDetailsResponse?.resLastPaymentRecived,
                    lastPaymentDate: state.cardDetailsResponse?.resLastPaymentRecivedDate,
                    pendingAuthorizationAmount: state.cardDetailsResponse?.resPendingAuth.toString(),
                    installmentPayableBalance: state.cardDetailsResponse?.resInstPayableBalance.toString(),
                    statementBalance: state.cardDetailsResponse?.resStatmentBalance,
                    minimumPaymentDue: state.cardDetailsResponse?.resStmtMinAmtDue,
                    paymentDueDate: state.cardDetailsResponse?.resStmtPymtDueDate.toString(),
                    statementDate: state.cardDetailsResponse?.resStmtDate,
                    totalLoyaltyPoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints,
                    resAddonDetails: state.cardDetailsResponse?.resAddonDetails,
                  outstandingBalance: state.cardDetailsResponse?.resCurrentOutstandingBalance,
                  billedTotal: state.cardDetailsResponse?.resBilledTotal
                );
                utilizedBalance = double.parse(custDetails?.outstandingBalance ?? "0.00") + double.parse(custDetails?.pendingAuthorizationAmount ?? "0.00");
              }
              if(state.resCode != "00") {
                showAppDialog(
                  title: AppLocalizations.of(context).translate("unable_to_proceed"),
                  alertType: AlertType.FAIL,
                  message: state.resDescription ?? AppLocalizations.of(context).translate("fail"),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {},
                );
              }
              setState(() {});
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              20.h + AppSizer.getHomeIndicatorStatus(context),
                          top: 24.h),
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
                                    backgroundColor:
                                        colors(context).primaryColor400!,
                                    fontColor: colors(context).whiteColor!,
                                    dividerColor:
                                        colors(context).primaryColor200!),
                                nickName: widget.cardDetailsArgs.cardType,
                                maskedCardNumber:
                                    widget.cardDetailsArgs.cardNumber ?? "",
                                accountNumber:
                                    widget.cardDetailsArgs.accountNumber,
                                productName:
                                    widget.cardDetailsArgs.cardHolderName,
                                availableBalance:
                                    widget.cardDetailsArgs.totalCreditLimit,
                                actualBalance:
                                    widget.cardDetailsArgs.availableCreditLimit,
                                cardType: "Cards",
                                currency: widget.cardDetailsArgs.currency ?? AppLocalizations.of(context).translate("lkr"),
                              ),
                            ),
                          ),
                          // UBPortfolioCardColored(
                          //   title: widget.cardDetailsArgs.cardType!,
                          //   availableAmount:
                          //       widget.cardDetailsArgs.totalCreditLimit!,
                          //   accountNumber:  widget.cardDetailsArgs.cardNumber!,
                          //   actualAmount:
                          //       widget.cardDetailsArgs.availableCreditLimit!,
                          //   subTitle: widget.cardDetailsArgs.accountNumber,
                          // ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                              child: Column(
                                children: [
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("utilized_balance"),
                                    isCurrency: true,
                                    amount: utilizedBalance == "0.00" ?
                                    0.00 :
                                    utilizedBalance,
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("billed_transaction_value"),
                                    isCurrency: true,
                                    amount: custDetails?.statementBalance == null || custDetails?.statementBalance == "" ?
                                    0.00 :
                                    double.parse(custDetails!.statementBalance!.replaceAll(",", "")),
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("statement_date"),
                                    data: custDetails?.statementDate == "" || custDetails?.statementDate == null ? "-" :
                                  transformDate(custDetails!.statementDate!)?? "-",
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("payment_due_Date"),
                                    data:
                                        widget.cardDetailsArgs.paymentDueDate !=
                                                null
                                            ? DateFormat('dd-MMM-yyyy').format(
                                                DateFormat('dd-MM-yyyy').parse(
                                                widget.cardDetailsArgs
                                                    .paymentDueDate!,
                                              ))
                                            : "-",
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("minimum_payment"),
                                    isCurrency: true,
                                    amount: double.parse(widget
                                            .cardDetailsArgs.minimumPaymentDue
                                            ?.replaceAll(",", "") ??
                                        "0.00"),
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("minimum_payment_due"),
                                    isCurrency: true,
                                    amount: double.parse(widget
                                        .cardDetailsArgs.minimumPayment!
                                        .replaceAll(",", "")),
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("unbilled_amount"),
                                    isCurrency: true,
                                    amount: custDetails?.pendingAuthorizationAmount == null || custDetails?.pendingAuthorizationAmount == "" ?
                                        0.00 :
                                    double.parse(custDetails!.pendingAuthorizationAmount!.replaceAll(",", "")),
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("last_paid_amount"),
                                    amount: double.parse(
                                      custDetails?.lastPaymentAmount == "" ?
                                      "0.0" :
                                      custDetails?.lastPaymentAmount ?? "0.0"),
                                  isCurrency: true,
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("last_paid_date"),
                                    data: custDetails?.lastPaymentDate == "" || custDetails?.lastPaymentDate == null ? "-" :
                                  DateFormat("dd-MMM-yyyy").format(DateTime.parse(custDetails?.lastPaymentDate ?? "-")),
                                  ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("card_holder_name"),
                                    data:
                                        widget.cardDetailsArgs.cardHolderName ??
                                            "-",
                                    isLastItem: true,
                                  ),
                                  // FTSummeryDataComponent(
                                  //   title: AppLocalizations.of(context)
                                  //       .translate("card_expiry_date"),
                                  //   data:
                                  //       widget.cardDetailsArgs.cardExpiryDate !=
                                  //               null
                                  //           ? DateFormat('dd-MMM-yyyy').format(
                                  //               DateFormat('dd-MMM-yyyy').parse(
                                  //               widget.cardDetailsArgs
                                  //                   .cardExpiryDate!,
                                  //             ))
                                  //           : "-",
                                  //   isLastItem: true,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          // UBPortfolioDetails(
                          //    title: 'Utilized Balance',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.utilizedBalance.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Billed Transaction Value',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.billedTransactionValue.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Statement Date',
                          //    subTitle: widget.cardDetailsArgs.statementDate!=null? DateFormat('dd-MM-yyyy').format(
                          //      DateFormat('dd-MM-yyyy').parse(
                          //    widget.cardDetailsArgs.statementDate!,
                          //  )):"0000-00-00",
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Payment Due Date',
                          //    subTitle: widget.cardDetailsArgs.paymentDueDate!=null? DateFormat('dd-MM-yyyy').format(
                          //      DateFormat('dd-MM-yyyy').parse(
                          //    widget.cardDetailsArgs.paymentDueDate!,
                          //  )):"0000-00-00",
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Minimum Payment',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.minimumPaymentDue.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Minimum Payment Due',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.minimumPayment.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Unbilled Amount',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.unBilledAmount.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Last Paid Amount',
                          //    isCurrency: true,
                          //    amount: widget.cardDetailsArgs.lastPaidAmount.toString().withThousandSeparator(),
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Last Paid Date',
                          //    subTitle: widget.cardDetailsArgs.lastPaidDate!=null? DateFormat('dd-MMM-yyyy').format(
                          //      DateFormat('dd-MMM-yyyy').parse(
                          //    widget.cardDetailsArgs.lastPaidDate!,
                          //  )):"0000-00-00",
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Card Holder Name',
                          //    subTitle: widget.cardDetailsArgs.cardHolderName!,
                          //  ),
                          //  UBPortfolioDetails(
                          //    title: 'Card Expiry Date',
                          //    subTitle: widget.cardDetailsArgs.cardExpiryDate!=null? DateFormat('dd-MMM-yyyy').format(
                          //      DateFormat('dd-MMM-yyyy').parse(
                          //    widget.cardDetailsArgs.cardExpiryDate!,
                          //  )):"0000-00-00",
                          //  ),
                          //  if(widget.cardDetailsArgs.isPrimary)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .kPortfoliobilledTransactionView,
                                          arguments: CardTransactionArgs(
                                            transaction: widget.cardDetailsArgs
                                                    .transaction ??
                                                [],
                                            availableCreditLimit: widget
                                                .cardDetailsArgs
                                                .availableCreditLimit,
                                            cardType:
                                                widget.cardDetailsArgs.cardType,
                                            accountNumber: widget
                                                .cardDetailsArgs.accountNumber,
                                            cardNumber: widget
                                                .cardDetailsArgs.cardNumber,
                                          ));
                                    },
                                    child: UBPortfolioBottomContainer(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                              "card_transaction_history"),
                                      icon: PhosphorIcon(
                                          PhosphorIcons.clockCounterClockwise(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Routes.kPastCardStatementsFilterView,
                                          arguments: AccountNumberArgs(
                                              accountNumber: widget
                                                      .cardDetailsArgs
                                                      .cardNumber ??
                                                  "-"));
                                    },
                                    child: UBPortfolioBottomContainer(
                                      title: AppLocalizations.of(context)
                                          .translate("past_card_statements"),
                                      icon: PhosphorIcon(
                                          PhosphorIcons.files(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor),
                                      isLastItem: true,
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }

  // String removeLeadingHyphen(String input) {
  //   return input.replaceFirst(RegExp(r'^-'), '');
  // }

    String transformDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    String month = parts[1].substring(0, 1) + parts[1].substring(1).toLowerCase();
    String transformedDate = "${parts[0]}-$month-${parts[2]}";
    return transformedDate;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
