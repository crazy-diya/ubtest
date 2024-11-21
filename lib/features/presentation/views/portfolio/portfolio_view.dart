import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/Data/card_txn_details.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/portfolio_card.dart';
import '../../../../../utils/app_extensions.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/account_details_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/card_details_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/investment_details_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/loan_details_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/widgets/ub_portfolio_main_screen_container.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';


import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';


import '../../../data/models/responses/account_details_response_dtos.dart';
import '../../../data/models/responses/portfolio_lease_details_response.dart';
import '../../../data/models/responses/portfolio_loan_details_response.dart';
import '../../../data/models/responses/portfolio_userfd_details_response.dart';
import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import '../base_view.dart';

class PortfolioTypeArgs {
  final AccountType tabType;

  PortfolioTypeArgs({
    required this.tabType,
  });
}

class PortfolioView extends BaseView {
  final PortfolioTypeArgs portfolioTypeArgs;

  PortfolioView({required this.portfolioTypeArgs});

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends BaseViewState<PortfolioView>
    with SingleTickerProviderStateMixin {
  var bloc = injection<SplashBloc>();

  List<String> tabs = [
    "accounts",
    "cards",
    "investments",
    "loans",
    "lease",
  ];
  int current = 0;

  String accountTotal = '';
  String cardTotal = '';
  String investmentTotal = '';
  String loanTotal = '';
  String leaseTotal = '';
  List<AccountDetailsResponseDto> accList = [];
  List<FdDetailsResponseDtoList> invList = [];
  List<LoanDetailsResponseDtoList> lnList = [];
  List<CardTxnDetails> ccList = [];
  List<LeaseDetailsResponseDtoList> leaseList = [];

late TabController _tabController;

  @override
  void initState() {
    super.initState();
   _tabController = TabController(length: tabs.length, vsync: this);
    updateValues();
  }

  @override
  void dispose() {
_tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("portfolio"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                // width: MediaQuery.of(context).size.width - 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  color: colors(context).whiteColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                             AppLocalizations.of(context).translate(tabs[index]) ,
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
            24.verticalSpace,
            AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("accounts")
                ? Expanded(
                  child: SingleChildScrollView(
                    key: Key("n"),
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                      child: Column(
                        children: [
                          UBPortfolioContainer(
                            icon: PhosphorIcon(PhosphorIcons.wallet(PhosphorIconsStyle.bold),
                                color: colors(context).primaryColor),
                            title: accList.length == 1 ? AppLocalizations.of(context).translate("account") : AppLocalizations.of(context).translate("accounts"),
                            amount: accountTotal.withThousandSeparator(),
                            length: accList.length,
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16).w,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: accList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routes.kPortfolioAccountDetailsView,
                                                arguments: AccountDetailsArgs(
                                                    accountType: accList[index].accountType,
                                                    availableBalance: accList[index].availableBalance!.withThousandSeparator(),
                                                    actualeBalance: accList[index].actualBalance!.withThousandSeparator(),
                                                    accountNumber: accList[index].accountNumber!,
                                                    accountName: accList[index].productName!,
                                                    overDraftedLimit: accList[index].overDraftedLimit!,
                                                    unClearedBalance: accList[index].unclearedBalance!,
                                                    openDate: accList[index].openedDate,
                                                    accountStatus: accList[index].status!,
                                                    nickName: accList[index].nickName,
                                                    instrumentId: accList[index].instrumentId!,
                                                    branchName: accList[index].branchName!,
                                                    holdBalance: accList[index].holdBalance!,
                                                    effectiveInterestRate: accList[index].effectiveInterestRate!,
                                                    currency: accList[index].cfcurr,
                                                    index: index));
                                          },
                                          child: PortfolioCard(
                                            design: ManagePayDesign(
                                                backgroundColor: colors(context).primaryColor!,
                                                fontColor: colors(context).whiteColor!,
                                                dividerColor: colors(context).primaryColor300!
                                            ),
                                            nickName: accList[index].nickName,
                                            accountNumber: accList[index].accountNumber!,
                                            productName: accList[index].productName!,
                                            availableBalance: accList[index].availableBalance!.toString(),
                                            actualBalance: accList[index].actualBalance!.toString(),
                                            currency: accList[index].cfcurr ?? AppLocalizations.of(context).translate("lkr"),
                                            cardType: "Accounts",
                                          )
                                        // UBPortfolioContainerMain(
                                        //   // isprimary: true,
                                        //   title: accList[index].productName!,
                                        //   subTitle: accList[index].accountNumber!,
                                        //   availableAmount: accList[index]
                                        //       .availableBalance!
                                        //       .toString()
                                        //       .withThousandSeparator(),
                                        //   actualAmount: accList[index]
                                        //       .actualBalance!
                                        //       .toString()
                                        //       .withThousandSeparator(),
                                        // ),
                                      ),
                                      if(accList.length-1 != index)
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 16.h , top: 16.h),
                                          child: Divider(
                                            thickness: 1,
                                            height: 0,
                                            color: colors(context).greyColor100,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("cards")
                    ? Expanded(
                      child: SingleChildScrollView(
                        key: Key("p"),
                        physics: ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                          child: Column(
                            children: [
                              UBPortfolioContainer(
                                icon: PhosphorIcon(PhosphorIcons.creditCard(PhosphorIconsStyle.bold), color: colors(context).primaryColor),
                                title: ccList.length == 1 ? AppLocalizations.of(context).translate("card") : AppLocalizations.of(context).translate("cards"),
                                amount: cardTotal.withThousandSeparator(),
                                length: ccList.length,
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: ccList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .kPortfolioCardDetailsView,
                                                      arguments: CardDetailsArgs(
                                                          transaction: ccList[index].last5Txns ?? [],
                                                          isPrimary: ccList[index].isPrimary ?? false,
                                                          availableCreditLimit: ccList[index].availableBalance ?? "0.00",
                                                          totalCreditLimit: ccList[index].creditLimit ?? "0.00",
                                                          unBilledAmount: ccList[index].unBilledAmount ?? "0.00",
                                                          lastPaidAmount: ccList[index].lastPaidAmount??"0.00",
                                                          minimumPaymentDue: ccList[index].minAmtDue ?? "0.00",
                                                          paymentDueDate: ccList[index].pymtDueDate,
                                                          cardType: ccList[index].cardTypeWithDesc.removeUnwantedProductCodes(),
                                                          holderName: ccList[index].cardCustomerName,
                                                          cardExpiryDate: ccList[index].cardExpiryDate,
                                                          cardStatus: ccList[index].cardStatusWithDesc,
                                                          accountNumber: ccList[index].cmsAccNo??"",
                                                          outStandingBalance:ccList[index].currentOutstandingBalance ?? "0.00",
                                                          billedTransactionValue: ccList[index].billedTransactionValue??"0.00",
                                                          cardNumber: ccList[index].maskedPrimaryCardNumber ?? "",
                                                          lastPaidDate: ccList[index].lastPaidDate,
                                                          minimumPayment:ccList[index].minAmtDue ?? "0.00",
                                                          cardHolderName: ccList[index].cardCustomerName,
                                                          statementDate: ccList[index].statementDate,
                                                          utilizedBalance: ccList[index].utilizedBalance??"0.00",
                                                        currency: ccList[index].currency

                                                      ));
                                                },
                                                child: PortfolioCard(
                                                  design: ManagePayDesign(
                                                      backgroundColor: colors(context).primaryColor400!,
                                                      fontColor: colors(context).whiteColor!,
                                                      dividerColor: colors(context).primaryColor200!
                                                  ),
                                                  nickName: ccList[index].cardTypeWithDesc.removeUnwantedProductCodes(),
                                                  maskedCardNumber: ccList[index].maskedPrimaryCardNumber??"",
                                                  accountNumber: ccList[index].cmsAccNo??"",
                                                  productName: ccList[index].cardCustomerName!,
                                                  availableBalance: ccList[index].creditLimit!.toString(),
                                                  actualBalance: ccList[index].availableBalance.toString() ?? "",
                                                  currency: ccList[index].currency ?? AppLocalizations.of(context).translate("lkr"),
                                                  cardType: "Cards",
                                                )

                                              // UBPortfolioCardsContainer(
                                              //   title: ccList[index].cardTypeWithDesc??"",
                                              //   actualAmount:  ccList[index]
                                              //       .availableBalance
                                              //       ??"0.00",
                                              //   accountNumber: ccList[index].maskedPrimaryCardNumber??"",
                                              //   availableAmount: ccList[index]
                                              //       .creditLimit??"0.00",
                                              //   subTitle: ccList[index].cmsAccNo??"",
                                              // ),
                                            ),
                                            if(ccList.length-1 != index)
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 16.h , top: 16.h),
                                                child: Divider(
                                                  thickness: 1,
                                                  height: 0,
                                                  color: colors(context).greyColor100,
                                                ),
                                              ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("investments")
                        ? Expanded(
                          child: SingleChildScrollView(
                            key: Key("o"),
                            physics: ClampingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                              child: Column(
                                children: [
                                  UBPortfolioContainer(
                                    icon: PhosphorIcon(PhosphorIcons.chartLineUp(PhosphorIconsStyle.bold), color: colors(context).primaryColor),
                                    title: AppLocalizations.of(context).translate("investments"),
                                    amount: investmentTotal.withThousandSeparator(),
                                    length: invList.length,
                                  ),
                                  16.verticalSpace,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16).w,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: invList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .kPortfolioInvestmentDetailsView,
                                                      arguments:
                                                          InvestmentDetailsArgs(
                                                        category:
                                                            invList[index].fdtype,
                                                        accountNumber:
                                                            invList[index]
                                                                .accountNumber,
                                                        balance:
                                                            invList[index].balance,
                                                        depositAmount:
                                                            invList[index].balance,
                                                        interestrate:
                                                            invList[index].rate,
                                                        tenure:
                                                            invList[index].tenure,
                                                        openingDate: invList[index]
                                                            .openningDate
                                                            .toString(),
                                                        lastRenewaldate:
                                                            invList[index]
                                                                .lastRenewalDate
                                                                .toString(),
                                                        maturityDate: invList[index]
                                                            .maturityDate
                                                            .toString(),
                                                            currency: invList[index].cfcurr
                                                      ));
                                                },
                                                child: PortfolioCard(
                                                  design: ManagePayDesign(
                                                      backgroundColor: colors(context).primaryColor200!,
                                                      fontColor: colors(context).blackColor!,
                                                      dividerColor: colors(context).primaryColor300!
                                                  ),
                                                  nickName: invList[index].fdtype.trimLeft(),
                                                  accountNumber: invList[index].accountNumber,
                                                  maturityDate: invList[index].maturityDate.toString().isDate() == true
                                                      ? DateFormat('dd-MMM-yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                                    invList[index].maturityDate.toString(),
                                                  )) : invList[index].maturityDate.toString(),
                                                  tenure: invList[index].tenure,
                                                  availableBalance: invList[index].balance.toString(),
                                                  actualBalance: invList[index].rate,
                                                  currency: invList[index].cfcurr,
                                                  cardType: "Investments",
                                                )
                                                // UBPortfolioContainerInvestments(
                                                //   // isprimary: true,
                                                //   title: invList[index].fdtype,
                                                //   subTitle:
                                                //       invList[index].accountNumber,
                                                //   amount: invList[index]
                                                //       .balance
                                                //       .toString()
                                                //       .withThousandSeparator(),
                                                //   rate: invList[index].rate,
                                                //   tenure: invList[index].tenure,
                                                //   maturityDate: invList[index]
                                                //               .maturityDate
                                                //               .toString()
                                                //               .isDate() ==
                                                //           true
                                                //       ? DateFormat('dd-MMM-yyyy')
                                                //           .format(DateFormat(
                                                //                   'yyyy-MM-dd HH:mm:ss.SSSZ')
                                                //               .parse(
                                                //           invList[index]
                                                //               .maturityDate
                                                //               .toString(),
                                                //         ))
                                                //       : invList[index]
                                                //           .maturityDate
                                                //           .toString(),
                                                // ),
                                              ),
                                              if(invList.length-1 != index)
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 16.h , top: 16.h),
                                                  child: Divider(
                                                    thickness: 1,
                                                    height: 0,
                                                    color: colors(context).greyColor100,
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        : AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("loans")
                            ? Expanded(
                              child: SingleChildScrollView(
                                key: Key("nu"),
                                physics: ClampingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                                  child: Column(
                                    children: [
                                      UBPortfolioContainer(
                                        icon: PhosphorIcon(PhosphorIcons.creditCard(PhosphorIconsStyle.bold), color: colors(context).primaryColor),
                                        title: AppLocalizations.of(context).translate("loans"),
                                        amount: loanTotal.withThousandSeparator(),
                                        length: lnList.length,
                                      ),
                                      16.verticalSpace,
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16).w,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: lnList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .kPortfolioloanDetailsView,
                                                          arguments:
                                                              LoanDetailsArgs(
                                                            loanTitle: lnList[index]
                                                                .loanName,
                                                            loanAmount: lnList[
                                                                    index]
                                                                .outStandingBalance
                                                                .toString(),
                                                            loanNumber:
                                                                lnList[index]
                                                                    .loanAccountNo,
                                                            capitalOutstanding:
                                                                lnList[index]
                                                                    .outStandingBalance
                                                                    .toString(),
                                                            nextInstallmentAmount:
                                                                lnList[index]
                                                                    .nextInstallmentAmount,
                                                            nextPaymentdate: lnList[
                                                                    index]
                                                                .nextInstallmentDate
                                                                .toString(),
                                                            totalArrears: lnList[
                                                                    index]
                                                                .numberOfRentalsArrears
                                                                .toString(),
                                                            maturityDate: lnList[
                                                                    index]
                                                                .aggreementMaturityDate
                                                                .toString(),
                                                            tenure: lnList[index]
                                                                .loanPeriodInMonths
                                                                .toString(),
                                                            //tenure: lnList[index].tenure,
                                                            branch: lnList[index]
                                                                .agreementBranch,
                                                            currentIntRate: lnList[
                                                                    index]
                                                                .currentInterestRate,
                                                            interestType:
                                                                lnList[index]
                                                                    .interestType,
                                                                facilityAmount: lnList[index].facilityAmount,
                                                                currency: lnList[index].cfcurr
                                                          ));
                                                    },
                                                    child: PortfolioCard(
                                                      design: ManagePayDesign(
                                                          backgroundColor: colors(context).greyColor!,
                                                          fontColor: colors(context).whiteColor!,
                                                          dividerColor: colors(context).greyColor300!
                                                      ),
                                                      nickName: lnList[index].loanName?.trimLeft()??"",
                                                      accountNumber: lnList[index].loanAccountNo,
                                                      // maturityDate: invList[index].maturityDate.toString().isDate() == true
                                                      //     ? DateFormat('dd-MMM-yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                                      //   invList[index].maturityDate.toString(),
                                                      // )) : invList[index].maturityDate.toString(),
                                                      tenure: lnList[index].loanPeriodInMonths,
                                                      availableBalance: lnList[index].outStandingBalance.toString(),
                                                      actualBalance: lnList[index].loanPeriodInMonths.toString(),
                                                      currency: lnList[index].cfcurr ?? AppLocalizations.of(context).translate("lkr"),
                                                      cardType: "Loans",
                                                    )
                                                    // UBPortfolioContainerLoan(
                                                    //   // isprimary: true,
                                                    //   title: lnList[index].loanName??"",
                                                    //   subTitle: lnList[index]
                                                    //       .loanAccountNo??"",
                                                    //   amount: lnList[index]
                                                    //       .outStandingBalance
                                                    //       .toString()
                                                    //       .withThousandSeparator(),
                                                    //   period: lnList[index]
                                                    //       .loanPeriodInMonths
                                                    //       .toString(),
                                                    // ),
                                                  ),
                                                  if(lnList.length-1 != index)
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 16.h , top: 16.h),
                                                      child: Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        color: colors(context).greyColor100,
                                                      ),
                                                    ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            :SizedBox.shrink()
                            // : Expanded(
                            //   child: SingleChildScrollView(
                            //     key: Key("q"),
                            //     physics: ClampingScrollPhysics(),
                            //     child: Padding(
                            //       padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                            //       child: Column(
                            //         children: [
                            //           UBPortfolioContainer(
                            //             icon: PhosphorIcon(PhosphorIcons.carProfile(PhosphorIconsStyle.bold), color: colors(context).primaryColor),
                            //             title: 'Lease',
                            //             amount: leaseTotal
                            //                 .toString()
                            //                 .withThousandSeparator(),
                            //           ),
                            //           ListView.builder(
                            //               padding: EdgeInsets.zero,
                            //               physics: NeverScrollableScrollPhysics(),
                            //               shrinkWrap: true,
                            //               itemCount: leaseList.length,
                            //               itemBuilder:
                            //                   (BuildContext context,
                            //                       int index) {
                            //                 return Column(
                            //                   children: [
                            //                     InkWell(
                            //                       onTap: () {
                            //                         Navigator.pushNamed(
                            //                             context,
                            //                             Routes
                            //                                 .kPortfolioLeaseDetailsView,
                            //                             arguments:
                            //                                 LeaseDetailsArgs(
                            //                               category: leaseList[
                            //                                       index]
                            //                                   .productDescription,
                            //                               accountNumber:
                            //                                   leaseList[index]
                            //                                       .leaseNumber,
                            //                               balance:
                            //                                   leaseList[index]
                            //                                       .leaseAmount,
                            //                               capitalOutstanding:
                            //                                   leaseList[index]
                            //                                       .capitalOutstanding,
                            //                               rentalAmount:
                            //                                   leaseList[index]
                            //                                       .rentalAmount,
                            //                               nextPaymentDate:
                            //                                   leaseList[index]
                            //                                       .nextPaymentDate,
                            //                               totalArrears:
                            //                                   leaseList[index]
                            //                                       .totalArrears!,
                            //                               maturityDate:
                            //                                   leaseList[index]
                            //                                       .maturityDate,
                            //                               tenure:
                            //                                   leaseList[index]
                            //                                       .tenure,
                            //                             ));
                            //                       },
                            //                       child:
                            //                           UBPortfolioContainerLease(
                            //                         title: leaseList[index]
                            //                             .productDescription!,
                            //                         amount: leaseList[index]
                            //                             .leaseAmount!
                            //                             .toString()
                            //                             .withThousandSeparator(),
                            //                         subTitle: leaseList[index]
                            //                             .leaseNumber!,
                            //                         period: leaseList[index]
                            //                             .tenure!,
                            //                       ),
                            //                     ),
                            //                     if(leaseList.length-1 != index)
                            //                       Padding(
                            //                         padding: EdgeInsets.only(bottom: 16.h , top: 16.h),
                            //                         child: Divider(
                            //                           thickness: 1,
                            //                           height: 0,
                            //                           color: colors(context).greyColor100,
                            //                         ),
                            //                       ),
                            //                   ],
                            //                 );
                            //               })
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
          ],
        ),
      ),
    );
  }

  // String maskCardNumber(String cardNumber) {
  //   if (cardNumber.length <= 4) {
  //     return cardNumber;
  //   }
  //   String lastFourDigits = cardNumber.substring(cardNumber.length - 4);
  //
  //   String masked = '*' * (cardNumber.length - 4);
  //   return '$masked$lastFourDigits';
  // }


  void updateValues() {
    
      accountTotal = AppConstants.totalAccountBalance.toStringAsFixed(2);
      accList.addAll(AppConstants.accountDetailsResponseDtos);

      investmentTotal = AppConstants.totalInvestmentBalance.toStringAsFixed(2);
      invList.addAll(AppConstants.fdDetailsResponseDtoList);

      loanTotal = AppConstants.totalLoanBalance.toStringAsFixed(2);
      lnList.addAll(AppConstants.loanDetailsResponseDtoList);

      cardTotal = AppConstants.totalCardBalance.toStringAsFixed(2);
      ccList.addAll(AppConstants.cardDetailsResponseDtoList);

      leaseTotal = AppConstants.totalLeaseBalance.toStringAsFixed(2);
      leaseList.addAll(AppConstants.leaseDetailsResponseDtoList);
   
    if(accList.isEmpty){
      tabs.remove("accounts");
    }

    if(invList.isEmpty){
      tabs.remove("investments");
    }
    if(lnList.isEmpty){
      tabs.remove("loans");
    }
    if(ccList.isEmpty){
      tabs.remove("cards");
    }
    

    if(leaseList.isEmpty){
      tabs.remove("lease");
    }
   
   current = tabs.indexOf(getTabType(widget.portfolioTypeArgs.tabType));
   setState(() { });
  }



  String getTabType(AccountType type){
      switch (type) {
      case AccountType.LEASE:
        return "lease";
      case AccountType.INVESTMENT:
       return "investments";
      case AccountType.FIXED_DEPO:
       return "investments";
      case AccountType.LOAN:
        return "loans";
      case AccountType.CARDS:
       return "cards";
      case AccountType.ACCOUNTS:
        return "accounts";
      case AccountType.SAVING_ACCOUNT:
      return "accounts";
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
