import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/widgets/credit_card_details_card.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/widgets/credit_card_details_entity.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/card_management/card_list_response.dart';
import '../../widgets/appbar.dart';
import '../Manage_Payment_Intruments/data/manage_pay_design.dart';
import 'credit_card_details/credit_card_details_view.dart';

class CreditCardManagementCategoryListView extends BaseView {
  final String? route;
  const CreditCardManagementCategoryListView( {super.key,this.route,});

  @override
  State<CreditCardManagementCategoryListView> createState() =>
      _CreditCardManagementViewState();
}

class _CreditCardManagementViewState
    extends BaseViewState<CreditCardManagementCategoryListView> {
  final bloc = injection<CreditCardManagementBloc>();
  List<CreditCardDetails> tempCardList = [];
  List<CreditCardDetailsCard> cardList = [];
  List<CardResAddonCardDetail>? resAddonCardDetails = [];
  final CarouselSliderController _controller = CarouselSliderController();
  int current = 0;
  String? maskCardNumber;
  bool? isSupplimentaryCardAvailable = true;
  bool isTxnLimitAvailable = false;

  @override
  initState() {
    super.initState();
   
    bloc.add(GetCardListEvent());
  }

  // initCards() {
  //   setState(() {
  //     for (var element in tempCardList) {
  //       cardList.add(CreditCardDetailsCard(
  //         cardType: element.cardType,
  //         accountNumber: element.accountNumber,
  //         availableBalance: element.availableToSpentAmount,
  //         maskedCardNumber: element.cardNumber,
  //         design: ManagePayDesign(
  //             backgroundColor: colors(context).primaryColor400!,
  //             fontColor: colors(context).whiteColor!,
  //             dividerColor: colors(context).primaryColor200!),
  //       ));
  //     }
  //   });
  // }

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
              if(state is GetCardListLoadedState){
                 bloc.add(GetTranLimitForCardEvent());
                if(state.resCode == "00"){
                  cardList.addAll(state.cardListResponse!.resPrimaryCardDetails!.
                  map((e) => CreditCardDetailsCard(
                    design: ManagePayDesign(
                        backgroundColor: colors(context).primaryColor400!,
                        fontColor: colors(context).whiteColor!,
                        dividerColor: colors(context).primaryColor200!),
                    cardType: e.resCardTypeWithDesc?.removeUnwantedProductCodes(),
                    accountNumber: e.resCmsAccNo,
                    availableBalance: removeLeadingHyphen(e.resCurrentOutstandingBalance ?? ""),
                    maskedCardNumber: e.resMaskedPrimaryCardNumber,
                    crdPaymentAvailableBalance: e.resAvailableBalance,
                    creditCardName: e.resCardCustName,
                    resCardStatusWithDesc: e.resCardStatusWithDesc,
                    displayFlag: e.displayFlag,
                  )).toList());
                  if(state.cardListResponse?.resAddonCardDetails?.length == 0){
                    isSupplimentaryCardAvailable = false;
                    setState(() {

                    });
                  }
                  cardList = cardList
                      .where((element) =>
                  (element.displayFlag?.toUpperCase() == "Y")).toList();
                  maskCardNumber = cardList[0].maskedCardNumber;
                  resAddonCardDetails = state.cardListResponse?.resAddonCardDetails;
                  resAddonCardDetails = resAddonCardDetails
                      ?.where((element) => (element.displayFlag?.toUpperCase() == "Y")).toList();
                  setState(() {

                  });
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
              if (state is GetTransLimitForCardSuccessState) {
                isTxnLimitAvailable = true;
                setState(() {});
              }
              if (state is GetTransLimitForCardFailedState) {
                //  hideProgressBar();
                setState(() {});
              }
              if(state is GetCardDetailsSuccessState){}
            },
            child: Stack(
              children: [
              (cardList.isEmpty)?  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:
                                colors(context).secondaryColor300,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(14).w,
                          child: PhosphorIcon(
                            PhosphorIcons.article(
                                PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28.w,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate(
                            'no_card_title'),
                        style: size18weight700.copyWith(
                            color: colors(context).blackColor),
                      ),
                      4.verticalSpace,
                      Text(
                        AppLocalizations.of(context).translate(
                            'no_card_description'),
                        style: size14weight400.copyWith(
                            color: colors(context).greyColor),
                      )
                    ],
                  ),
                )
              : SizedBox.shrink(),
              if(cardList.isNotEmpty) Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w,
                              20.h + AppSizer.getHomeIndicatorStatus(context)),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        carouselController: _controller,
                                        options: CarouselOptions(
                                          autoPlayAnimationDuration:
                                              Duration(seconds: 2),
                                          autoPlay: false,
                                          scrollPhysics: const BouncingScrollPhysics(),
                                          enableInfiniteScroll: false,
                                          padEnds: cardList.length == current,
                                          initialPage: 0,
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              current = index;
                                              maskCardNumber = cardList[index].maskedCardNumber;
                                            });
                                          },
                                        ),
                                        items: cardList,
                                      ),
                                      4.verticalSpace,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: cardList.asMap().entries.map((entry) {
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
                                      20.verticalSpace,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async{
                                             await Navigator.pushNamed(context, Routes.kCreditCardDetailsView , arguments: CreditCardDetailsArgs(
                                                 itemList: cardList,
                                                 carouselIndex: current
                                             ));
                                            },
                                            child: Container(
                                              width: 155.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8).r,
                                                color: colors(context).primaryColor50,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0).w,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: PhosphorIcon(
                                                        PhosphorIcons.info(
                                                            PhosphorIconsStyle.bold),
                                                        color: colors(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    Text(
                                                      AppLocalizations.of(context)
                                                          .translate("more_info"),
                                                      style: size14weight700.copyWith(
                                                          color: colors(context)
                                                              .blackColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context, Routes.kReportLostOrStolenCardsView , arguments: maskCardNumber);
                                            },
                                            child: Container(
                                              width: 155.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8).r,
                                                color: colors(context).primaryColor50,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 16 ,horizontal: 8).w,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: PhosphorIcon(
                                                        PhosphorIcons.warning(
                                                            PhosphorIconsStyle.bold),
                                                        color:
                                                            colors(context).primaryColor,
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    Text(
                                                      AppLocalizations.of(context)
                                                          .translate(
                                                              "lost_report_or_stolen"),
                                                      style: size14weight700.copyWith(
                                                          color:
                                                              colors(context).blackColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
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
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.kSelfCareCategoryListView , arguments: cardList);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 48.w,
                                              width: 48.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8).r,
                                                  color: colors(context).whiteColor,
                                                  border: Border.all(
                                                      color: colors(context)
                                                              .greyColor300 ??
                                                          Colors.black // Border width
                                                      )),
                                              child: PhosphorIcon(
                                                PhosphorIcons.handHeart(
                                                    PhosphorIconsStyle.bold),
                                                color: colors(context).primaryColor,
                                              ),
                                            ),
                                            12.horizontalSpace,
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("self_care"),
                                              style: size16weight700.copyWith(
                                                  color: colors(context).blackColor),
                                            ),
                                            const Spacer(),
                                            PhosphorIcon(
                                              PhosphorIcons.caretRight(
                                                  PhosphorIconsStyle.bold),
                                              color: colors(context).greyColor300,
                                            )
                                          ],
                                        ),
                                      ),
                                      16.verticalSpace,
                                      Divider(
                                        thickness: 1,
                                        color: colors(context).greyColor100,
                                        height: 0,
                                      ),
                                      if(isSupplimentaryCardAvailable == true)
                                        Column(
                                          children: [
                                            16.verticalSpace,
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context, Routes.kSupplementaryCardsView , arguments: resAddonCardDetails);
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 48.w,
                                                    width: 48.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(8).r,
                                                        color: colors(context).whiteColor,
                                                        border: Border.all(
                                                            color: colors(context)
                                                                .greyColor300 ??
                                                                Colors.black // Border width
                                                        )),
                                                    child: PhosphorIcon(
                                                      PhosphorIcons.creditCard(
                                                          PhosphorIconsStyle.bold),
                                                      color: colors(context).primaryColor,
                                                    ),
                                                  ),
                                                  12.horizontalSpace,
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate("supplementary_cards"),
                                                    style: size16weight700.copyWith(
                                                        color: colors(context).blackColor),
                                                  ),
                                                  const Spacer(),
                                                  PhosphorIcon(
                                                    PhosphorIcons.caretRight(
                                                        PhosphorIconsStyle.bold),
                                                    color: colors(context).greyColor300,
                                                  )
                                                ],
                                              ),
                                            ),
                                            16.verticalSpace,
                                            Divider(
                                              thickness: 1,
                                              color: colors(context).greyColor100,
                                              height: 0,
                                            ),
                                          ],
                                        ),
                                      16.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          if(isTxnLimitAvailable == false){
                                            showAppDialog(
                                                alertType: AlertType.WARNING,
                                                title: "Something went wrong",
                                                // AppLocalizations.of(context).translate("something_went_wrong"),
                                                message: "Cannot get transaction limits, please try again later",
                                                // AppLocalizations.of(context).translate("txn_limit_not_ft"),
                                                positiveButtonText: "Ok",
                                                // AppLocalizations.of(context).translate("ok"),
                                                onPositiveCallback: () {
                                                  setState(() {});
                                                });
                                          } else {
                                            Navigator.pushNamed(context, Routes.kCreditCardPaymentCategoryView , arguments: cardList);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 48.w,
                                              width: 48.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8).r,
                                                  color: colors(context).whiteColor,
                                                  border: Border.all(
                                                      color: colors(context)
                                                              .greyColor300 ??
                                                          Colors.black // Border width
                                                      )),
                                              child: PhosphorIcon(
                                                PhosphorIcons.cardholder(
                                                    PhosphorIconsStyle.bold),
                                                color: colors(context).primaryColor,
                                              ),
                                            ),
                                            12.horizontalSpace,
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("credit_card_payment"),
                                              style: size16weight700.copyWith(
                                                  color: colors(context).blackColor),
                                            ),
                                            const Spacer(),
                                            PhosphorIcon(
                                              PhosphorIcons.caretRight(
                                                  PhosphorIconsStyle.bold),
                                              color: colors(context).greyColor300,
                                            )
                                          ],
                                        ),
                                      )
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
              ],
            ),
          ),
        ));
  }

  String removeLeadingHyphen(String text) {
    if (text.startsWith('-')) {
      return text.substring(1);
    }
    return text;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
