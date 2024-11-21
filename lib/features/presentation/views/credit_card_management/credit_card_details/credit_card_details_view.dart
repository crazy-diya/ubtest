import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_list_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/widgets/credit_card_details_card.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/widgets/credit_card_details_entity.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../domain/entities/request/card_management/loyalty_points/card_details_entity.dart';
import '../../../../domain/entities/request/credit_card_mngmt_request_entity.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/appbar.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';

class CreditCardDetailsArgs{
  final List<CreditCardDetailsCard> itemList;
  final int carouselIndex;

  CreditCardDetailsArgs({required this.itemList, required this.carouselIndex});
}


class CreditCardDetailsView extends BaseView {
  final CreditCardDetailsArgs creditCardDetailsArgs;

  CreditCardDetailsView({required this.creditCardDetailsArgs});

  @override
  State<CreditCardDetailsView> createState() => _CreditCardDetailsViewState();
}

class _CreditCardDetailsViewState extends BaseViewState<CreditCardDetailsView> {

  final bloc = injection<CreditCardManagementBloc>();


  @override
  initState() {
    bloc.add(GetCardListEvent());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>_controller.jumpToPage(widget.creditCardDetailsArgs.carouselIndex));
    super.initState();
  }


  int current = 0;
  List<CreditCardDetailsCard> itemList = [];
  List<CreditCardDetails> cardList = [];
  final CarouselSliderController _controller = CarouselSliderController();
  CreditCardDetails? custDetails;
  CreditCardMngmtRequestEntity? tempSelectedCreditCard;

  CardResPrimaryCardDetail? selectedCardDetails;
  List<CardResPrimaryCardDetail> primaryCardDetailsList = [];


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("credit_card"),
        goBackEnabled: true,
      ),
      body: BlocProvider<CreditCardManagementBloc>(
        create: (context) => bloc,
        child: BlocListener<CreditCardManagementBloc,
            BaseState<CreditCardManagementState>>(
          bloc: bloc,
          listener:(context, state){
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
                    resAddonDetails: state.cardDetailsResponse?.resAddonDetails
                );
                tempSelectedCreditCard = CreditCardMngmtRequestEntity(
                  title: selectedCardDetails?.resCardTypeWithDesc ?? "",
                  cardNo: selectedCardDetails
                      ?.resMaskedPrimaryCardNumber ?? "",
                  availablePoints: state.cardDetailsResponse?.resLoyaltyAvailablePoints??"",
                  pointsAboutToExpire: state.cardDetailsResponse?.resPointsToBeExpire??"",
                );
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
            if(state is GetCardListLoadedState){
                bloc.add(GetCardDetailsEvent(
              maskedPrimaryCardNumber: widget.creditCardDetailsArgs.itemList[widget.creditCardDetailsArgs.carouselIndex].maskedCardNumber
          ));
              setState(() {
                primaryCardDetailsList = state.cardListResponse!.resPrimaryCardDetails?.where((e) => e.displayFlag?.toUpperCase() == "Y").toList()??[];
                primaryCardDetailsList = state.cardListResponse!.resPrimaryCardDetails?.where((e) => (extractFirstSixDigits(e.resMaskedPrimaryCardNumber ?? "") == "428767") ||
                    (extractFirstSixDigits(e.resMaskedPrimaryCardNumber ?? "") == "428770") || (extractFirstSixDigits(e.resMaskedPrimaryCardNumber ?? "") == "433333") || ((extractFirstSixDigits(e.resMaskedPrimaryCardNumber ?? "") == "422222"))).toList()??[];
                selectedCardDetails = primaryCardDetailsList.first;
              });
              // bloc.add(GetCardDetailsEvent(
              //     maskedPrimaryCardNumber: widget.creditCardDetailsArgs.itemList[0].maskedCardNumber
              // ));
          
            }
            if(state is GetCardListFailedState){
              showAppDialog(
                title: AppLocalizations.of(context).translate("something_went_wrong"),
                alertType: AlertType.FAIL,
                message: state.message ?? AppLocalizations.of(context).translate("fail"),
                positiveButtonText: AppLocalizations.of(context).translate("ok"),
                onPositiveCallback: () {
                },
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              children: [
                                CarouselSlider(
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                    autoPlayAnimationDuration: Duration(seconds: 2),
                                    autoPlay: false,
                                    scrollPhysics: const BouncingScrollPhysics(),
                                    enableInfiniteScroll: false,
                                    padEnds: widget.creditCardDetailsArgs.itemList.length == current,
                                    initialPage: 0,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        current = index;
                                        bloc.add(GetCardDetailsEvent(
                                          maskedPrimaryCardNumber: widget.creditCardDetailsArgs.itemList[index].maskedCardNumber
                                        ));
                                      });
                                    },
                                  ),
                                  items: widget.creditCardDetailsArgs.itemList,
                                ),
                                4.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.creditCardDetailsArgs.itemList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 8.h,
                                        height: 8.w,
                                        margin: const EdgeInsets.symmetric(
                                                horizontal: 4)
                                            .w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: current == entry.key
                                              ? colors(context).secondaryColor
                                              : colors(context)
                                                  .secondaryColor800!
                                                  .withOpacity(0.4),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                4.verticalSpace
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context)
                              .translate("credit_card_information"),
                          style: size14weight700.copyWith(
                              color: colors(context).blackColor),
                        ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                            child: Column(
                              children: [
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("credit_limit"),
                                  amount: double.parse(
                                      custDetails?.creditLimit == "" ?
                                          "0.0" :
                                      custDetails?.creditLimit ?? "0.0"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("available_to_spend"),
                                  amount: double.parse(
                                      custDetails?.availableToSpentAmount == "" ?
                                          "0.0" :
                                      custDetails?.availableToSpentAmount ?? "0.0"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("last_payment_amount"),
                                  amount: double.parse(
                                      custDetails?.lastPaymentAmount == "" ?
                                      "0.0" :
                                      custDetails?.lastPaymentAmount ?? "0.0"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("last_payment_date"),
                                  data: custDetails?.lastPaymentDate == "" || custDetails?.lastPaymentDate == null ? "-" :
                                  DateFormat("dd-MMM-yyyy").format(DateTime.parse(custDetails?.lastPaymentDate ?? "-"))
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("pending_authorization"),
                                  amount: double.parse(
                                      custDetails?.pendingAuthorizationAmount == ""||custDetails?.pendingAuthorizationAmount == "0" ?
                                      "0.0" :
                                      custDetails?.pendingAuthorizationAmount ?? "0.00"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("installment_payable_balance"),
                                  amount: double.parse(
                                      custDetails?.installmentPayableBalance == "" ?
                                      "0.0" :
                                      custDetails?.installmentPayableBalance ?? "0.0"),
                                  isCurrency: true,
                                  isLastItem: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context)
                              .translate("statement_summary"),
                          style: size14weight700.copyWith(
                              color: colors(context).blackColor),
                        ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                            child: Column(
                              children: [
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("statement_balance"),
                                  amount: double.parse(
                                      custDetails?.statementBalance == "" ?
                                      "0.0" :
                                      custDetails?.statementBalance ?? "0.0"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("minimum_payment_due"),
                                  amount: double.parse(
                                      custDetails?.minimumPaymentDue == "" ?
                                      "0.0" :
                                      custDetails?.minimumPaymentDue ?? "0.0"),
                                  isCurrency: true,
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("payment_due_Date"),
                                  data: custDetails?.paymentDueDate == "null" || custDetails?.statementDate == null ? "-" :
                                  DateFormat("dd-MMM-yyyy").format(DateTime.parse(custDetails?.paymentDueDate ?? "-"))
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("statement_date"),
                                  data: custDetails?.statementDate == "" || custDetails?.statementDate == null ? "-" :
                                  transformDate(custDetails!.statementDate!)?? "-",
                                  // DateFormat("dd-MMM-yyyy").format(DateFormat("dd-MMM-yyyy").parse(custDetails?.statementDate ?? "-")),
                                  isLastItem: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("loyalty_points"),
                          style: size14weight700.copyWith(
                              color: colors(context).blackColor),
                        ),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                            child: Column(
                              children: [
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("total_loyalty_points"),
                                  data: custDetails?.totalLoyaltyPoints ?? "-",
                                  isLastItem: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.kRedeemPointsView , arguments: CardDetailsEntity(
                                selectedCardDetails: selectedCardDetails, primaryCardDetailsList: primaryCardDetailsList,
                                tempSelectedCreditCard: tempSelectedCreditCard
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIcons.handCoins(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).blackColor,
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("redeem"),
                                        style: size14weight700.copyWith(
                                            color: colors(context).blackColor),
                                      ),
                                    ],
                                  ),
                                  PhosphorIcon(
                                    PhosphorIcons.caretRight(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).greyColor300,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        if(custDetails?.resAddonDetails?.isNotEmpty??false)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate("supplementary_cards"),
                                style: size14weight700.copyWith(
                                    color: colors(context).blackColor),
                              ),
                              16.verticalSpace,
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: custDetails?.resAddonDetails?.length,
                                  itemBuilder: (context,index){
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context)
                                                    .translate("name"),
                                                data:(custDetails?.resAddonDetails?[index].resAddonCustomerName ?? "-"),
                                              ),
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context)
                                                    .translate("card_status"),
                                                data:(custDetails?.resAddonDetails?[index].resAddonCardStatusWithDesc?.toTitleCase() ?? "-"),
                                              ),
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context)
                                                    .translate("credit_limit"),
                                                amount: double.parse((custDetails?.resAddonDetails?[index].resAddonCreditLimit ?? "0.0")),
                                                isCurrency: true,
                                                isLastItem: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if((custDetails?.resAddonDetails!.length ?? 1) - 1!=index)
                                      16.verticalSpace,
                                    ],
                                  );
                                  }
                              ),
                              20.verticalSpace,
                            ],
                          ),
                        AppSizer.verticalSpacing(
                            AppSizer.getHomeIndicatorStatus(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String transformDate(String dateStr) {
    // Split the date string by '-'
    List<String> parts = dateStr.split('-');

    // Convert the month to camel case
    String month = parts[1].substring(0, 1) + parts[1].substring(1).toLowerCase();

    // Reassemble the date string
    String transformedDate = "${parts[0]}-$month-${parts[2]}";

    return transformedDate;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
